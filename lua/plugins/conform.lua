return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	---@module "conform"
	---@type conform.setupOpts
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			javascript = { "prettierd", "prettier", stop_after_first = true },
			typescript = { "prettierd", "prettier", stop_after_first = true },
		},

		default_format_opts = {
			lsp_format = "fallback",
		},

		format_on_save = { timeout_ms = 500 },

		formatters = {
			shfmt = {
				prepend_args = { "-i", "2" },
			},
		},
	},
	keys = function()
		local conform = require("conform")
		return {
			{
				"<leader>fm",
				function()
					conform.format({ async = true })
				end,
				desc = "Conform format file",
				mode = "n",
			},
		}
	end,
	init = function()
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,
}
