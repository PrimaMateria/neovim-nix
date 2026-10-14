local wk = require("which-key")

-- Tokens are baked in from src/_secrets via _envVars.nix.
-- Jira: classic Atlassian API token. Bitbucket: scoped API token (app passwords
-- are retired), and Bitbucket basic auth wants the Atlassian email as the user.
local email = "matus.benko@finapi.io"
local bitbucket_uuid = "{7c490a28-0d51-46f8-915a-5b516677bc12}"

-- Bitbucket has no workspace-wide PR search; every view needs repo:/project:
-- targets and costs one request per repo. Whole teaminvest is ~140 repos, so
-- stick to the ones checked out under ~/dev.
local repos = {
	"finapi-customer-dashboard-ui",
	"finapi-design-system",
	"finapi-hostpages",
	"finapi-js-loader",
	"finapi-js-static-resources",
	"finapi-orderprocess-ui",
	"finapi-web-utils",
	"finapi-widget-library",
	"react-to-webcomponent-bundler",
	"web-form",
	"web-form-design-system",
	"web-form-loader",
	"web-form-ui",
	"web-form-ui-2_1",
}
local targets = table.concat(
	vim.tbl_map(function(repo)
		return "repo:teaminvest/" .. repo
	end, repos),
	" "
)
local authored = string.format('author.uuid = "%s"', bitbucket_uuid)
local reviewing = string.format('reviewers.uuid = "%s"', bitbucket_uuid)

require("atlas").setup({
	ui = {
		-- Keep lualine; atlas would otherwise take over the statusline.
		statusline = { atlas = false, diff = false },
	},
	providers = {
		bitbucket = {
			user = email,
			token = vim.env.BITBUCKET_API_TOKEN,
		},
		jira = {
			-- Legacy Cloud domain, so api_type must be explicit.
			base_url = "https://finapi.jira.com",
			email = email,
			token = vim.env.JIRA_API_TOKEN,
			auth_method = "basic",
			api_type = "cloud",
		},
	},
	pulls = {
		repo_config = {
			paths = {
				["teaminvest/*"] = "~/dev/*",
			},
		},
		bitbucket = {
			views = {
				{
					name = "Mine",
					key = "1",
					layout = "grouped",
					search = string.format("%s (%s OR %s)", targets, authored, reviewing),
				},
				{ name = "Authored", key = "2", layout = "grouped", search = targets .. " " .. authored },
				{ name = "Reviewing", key = "3", layout = "grouped", search = targets .. " " .. reviewing },
				{ name = "This repo", key = "4", layout = "compact", current_repo = true },
			},
		},
	},
})

vim.keymap.set("n", ",jp", "<cmd>Atlas pulls bitbucket<CR>", { silent = true, desc = "Pull requests" })
vim.keymap.set("n", ",ji", "<cmd>Atlas issues jira<CR>", { silent = true, desc = "Jira issues" })
vim.keymap.set("n", ",jr", "<cmd>Atlas review<CR>", { silent = true, desc = "Review PR" })
vim.keymap.set("n", ",jc", "<cmd>Atlas create pr<CR>", { silent = true, desc = "Create PR" })

wk.add({
	{ ",j", group = "Atlas" },
})
