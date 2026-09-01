local wk = require("which-key")

-- The plugin's plugin/tts.lua is sourced after init and replaces the real user
-- commands with lazy-loading stubs that recurse infinitely once the module is
-- already required. Claim the guard so that shim bails out; setup() below
-- creates the commands itself.
vim.g.loaded_tts = true

-- Local piper backend
-- ----------------
-- tts.nvim ships only 'macos' and 'openai' backends, but tts.backends resolves
-- one with require("tts.backends." .. name). require() short-circuits on
-- package.loaded, so preloading the module below is enough to register a third
-- backend without patching the plugin or putting a file on the runtimepath.
local piper = {}

-- Synthesised wavs are kept around so replaying a segment is instant; piper is
-- local, so this is purely to avoid re-running it, not to save on API calls.
local MAX_CACHED = 64

local synth = {} -- key -> { file, status, job, cbs }
local order = {} -- cache keys, oldest first
local generation = 0 -- bumped by stop() to orphan in-flight callbacks

local function piper_config()
	return require("tts.config").get().piper or {}
end

local function forget(key)
	local rec = synth[key]
	if not rec then
		return
	end
	synth[key] = nil
	if rec.file then
		vim.fn.delete(rec.file)
	end
	for i, k in ipairs(order) do
		if k == key then
			table.remove(order, i)
			break
		end
	end
end

local function trim_cache()
	while #order > MAX_CACHED do
		forget(order[1])
	end
end

local function cache_key(text, cfg)
	return vim.fn.sha256(table.concat({
		text,
		cfg.model or "",
		tostring(cfg.speed),
		tostring(cfg.volume),
		tostring(cfg.sentence_silence),
		tostring(cfg.speaker),
	}, "\30"))
end

local function start_synth(key, text, cfg)
	local existing = synth[key]
	if existing then
		return existing
	end

	local file = vim.fn.tempname() .. ".wav"
	local rec = { file = file, status = "running", cbs = {} }
	synth[key] = rec
	table.insert(order, key)
	trim_cache()

	local cmd = { "piper", "--model", cfg.model, "--output-file", file }

	-- piper thinks in phoneme length, which is the inverse of speed.
	if cfg.speed and cfg.speed > 0 then
		vim.list_extend(cmd, { "--length-scale", tostring(1 / cfg.speed) })
	end
	if cfg.sentence_silence then
		vim.list_extend(cmd, { "--sentence-silence", tostring(cfg.sentence_silence) })
	end
	if cfg.volume then
		vim.list_extend(cmd, { "--volume", tostring(cfg.volume) })
	end
	if cfg.speaker then
		vim.list_extend(cmd, { "--speaker", tostring(cfg.speaker) })
	end

	local stderr = {}
	local job = vim.fn.jobstart(cmd, {
		stdin = "pipe",
		on_stderr = function(_, data)
			if data then
				vim.list_extend(stderr, data)
			end
		end,
		on_exit = function(_, code)
			local ok = code == 0 and vim.fn.getfsize(file) > 0
			rec.job = nil
			rec.status = ok and "ok" or "failed"

			local cbs = rec.cbs
			rec.cbs = {}

			if not ok then
				-- Drop it so the next attempt retries instead of replaying the failure.
				forget(key)
				local msg = vim.trim(table.concat(stderr, "\n"))
				vim.schedule(function()
					vim.notify(
						"TTS: piper failed" .. (msg ~= "" and (": " .. msg) or (" (exit " .. code .. ")")),
						vim.log.levels.ERROR
					)
				end)
			end

			for _, cb in ipairs(cbs) do
				cb(ok and file or nil)
			end
		end,
	})

	if job <= 0 then
		rec.status = "failed"
		forget(key)
		vim.schedule(function()
			vim.notify("TTS: could not start piper", vim.log.levels.ERROR)
		end)
		return rec
	end

	rec.job = job
	vim.fn.chansend(job, text)
	vim.fn.chanclose(job, "stdin")
	return rec
end

local function when_ready(key, text, cfg, callback)
	local rec = start_synth(key, text, cfg)
	if rec.status == "running" then
		table.insert(rec.cbs, callback)
	else
		callback(rec.status == "ok" and rec.file or nil)
	end
end

function piper.is_available()
	if vim.fn.executable("piper") ~= 1 then
		vim.schedule(function()
			vim.notify("TTS: piper not found on PATH", vim.log.levels.ERROR)
		end)
		return false
	end

	local model = piper_config().model
	if not model or model == "" or vim.fn.filereadable(model) ~= 1 then
		vim.schedule(function()
			vim.notify("TTS: piper voice model not readable: " .. tostring(model), vim.log.levels.ERROR)
		end)
		return false
	end

	for _, player in ipairs({ "afplay", "mpv", "ffplay", "play" }) do
		if vim.fn.executable(player) == 1 then
			return true
		end
	end

	vim.schedule(function()
		vim.notify("TTS: no audio player found (mpv, ffplay or play)", vim.log.levels.ERROR)
	end)
	return false
end

function piper._play(file, opts)
	local handle = require("tts.player").play(
		file,
		vim.tbl_extend("force", opts, {
			on_complete = function(code)
				vim.api.nvim_exec_autocmds("User", {
					pattern = "TTSPlayEnd",
					data = { backend = "piper" },
				})
				if opts.on_complete then
					opts.on_complete(code)
				end
			end,
		})
	)

	if not handle and opts.on_complete then
		opts.on_complete(1)
	end
end

function piper.speak(text, opts)
	opts = opts or {}

	if not text or text == "" or text:match("^%s*$") then
		vim.schedule(function()
			vim.notify("TTS: No text to speak", vim.log.levels.WARN)
		end)
		return nil
	end

	-- Keep in-flight synthesis: the segment we are about to play is very often
	-- the one prefetch() already started.
	piper.stop({ keep_synth = true })

	local cfg = piper_config()
	local token = generation
	local key = cache_key(text, cfg)

	when_ready(key, text, cfg, function(file)
		if token ~= generation then
			return
		end
		if not file then
			if opts.on_complete then
				opts.on_complete(1)
			end
			return
		end
		piper._play(file, opts)
	end)

	return {
		stop = function()
			piper.stop()
		end,
	}
end

function piper.prefetch(text, opts)
	if not text or text == "" or text:match("^%s*$") then
		return
	end
	if not require("tts.config").get().cache.prefetch_next then
		return
	end

	local cfg = piper_config()
	if not cfg.model then
		return
	end

	start_synth(cache_key(text, cfg), text, cfg)
end

function piper.stop(opts)
	generation = generation + 1
	require("tts.player").stop()

	if not (opts and opts.keep_synth) then
		for _, rec in pairs(synth) do
			if rec.job then
				vim.fn.jobstop(rec.job)
			end
		end
	end
end

function piper.list_voices()
	local model = piper_config().model or ""
	return {
		{
			name = vim.fn.fnamemodify(model, ":t:r"),
			language = "en",
			note = "local piper voice",
		},
	}
end

package.loaded["tts.backends.piper"] = piper

vim.api.nvim_create_autocmd("VimLeavePre", {
	desc = "Remove piper's synthesised wav files",
	callback = function()
		for key, _ in pairs(synth) do
			forget(key)
		end
	end,
})

-- Setup
-- ----------------
-- backend must be one of 'auto' / 'macos' / 'openai' to pass the plugin's own
-- validation, so piper is selected right afterwards via the backend switcher.
-- That also leaves :TTSBackend openai working if an API key ever shows up.
require("tts").setup({
	backend = "openai",

	piper = {
		model = vim.env.PIPER_VOICE_MODEL,
		speed = 1.0,
		sentence_silence = 0.3,
		volume = 1.0,
	},

	openai = {
		-- api_key defaults to $OPENAI_API_KEY (see base/_envVars.nix)
		model = "tts-1",
		voice = "nova",
		speed = 1.0,
		format = "mp3",
	},

	playback = {
		player = "mpv",
		default_selection = "buffer",
		segmentation = "line",
		lines_per_segment = 5,
		follow = true,
	},

	keymaps = {
		play = ",vp",
		visual_play = ",vp",
		stop = ",vs",
		queue = ",vq",
		clear = ",vc",
		next = ",vn",
		prev = ",vN",
	},
})

require("tts.backends").set("piper")

wk.add({
	{ ",v", group = "Voice" },
	{ ",vp", desc = "TTS play" },
	{ ",vs", desc = "TTS stop" },
	{ ",vq", desc = "TTS queue" },
	{ ",vc", desc = "TTS clear queue" },
	{ ",vn", desc = "TTS next segment" },
	{ ",vN", desc = "TTS previous segment" },
})
