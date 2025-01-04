local ls = require("luasnip")

-- TODO: can I extract it to one place?
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet
local k = require("luasnip.nodes.key_indexer").new_key

local function copy(args)
	return args[1]
end

ls.add_snippets("markdown", {
	s("newpost", {
		t({
			"+++",
			'title = "',
		}),
		i(1),
		t({
			'"',
			'date = "' .. vim.fn.strftime("%Y-%m-%d") .. '"',
			'slug = "',
		}),
		i(2),
		t({
			'"',
			"",
			"[extra]",
			'banner = "banner-ai-generated-images.png"',
			'bannerAlt = "TODO"',
			'reddithref = ""',
			"",
			"[taxonomies]",
			"tags = [",
		}),
		i(3),
		t({ "]", "+++", "", "" }),
		i(4),
		t({
			"",
			"",
			"<!-- more -->",
			"<!-- TOC -->",
		}),
	}),

	s("octopus", {
		t({
			"{{ ",
		}),
		c(1, { t("nerdy"), t("curious") }),
		t({
			'(text="',
			"",
			"",
		}),
		i(2),
		t({
			"",
			"",
			'") }}',
		}),
	}),

	s("mermaid", {
		t({
			"<!-- prettier-ignore-start -->",
			"{% mermaid() %}",
			"graph TD;",
			"    A-->B;",
			"{% end %}",
			"<!-- prettier-ignore-end -->",
		}),
	}),

	s("img", {
		t({
			'<div style="margin-top: 24px">',
			'{{ resize_image_w(path="',
		}),
		i(1),
		t({ '", width=450) }}', "</div>" }),
	}),

	postfix({
		trig = ".lnk",
		match_pattern = "https?://%S+",
	}, {
		t("["),
		i(1, "txt"),
		t("]("),
		f(function(_, parent)
			return { parent.snippet.env.POSTFIX_MATCH }
		end, {}),
		t(")"),
	}),
}, { key = "markdown" })

-- [Lord-Valen's repository](https://github.com/Lord-Valen/configuration.nix)
