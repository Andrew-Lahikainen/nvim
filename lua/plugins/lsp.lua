return {
	{
		"seblyng/roslyn.nvim",
		ft = "cs",
		opts = {},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"neovim/nvim-lspconfig",
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-nvim-lsp",
			"L3MON4D3/LuaSnip",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			cmp.setup({
				sources = {
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<C-u>"] = cmp.mapping.scroll_docs(-4),
					["<C-d>"] = cmp.mapping.scroll_docs(4),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				}),
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
			})

			local lsp_cmds = vim.api.nvim_create_augroup("lsp_cmds", { clear = true })

			vim.api.nvim_create_autocmd("LspAttach", {
				group = lsp_cmds,
				desc = "LSP actions",
				callback = function()
					local bufmap = function(mode, lhs, rhs)
						vim.keymap.set(mode, lhs, rhs, { buffer = true })
					end

					bufmap("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>")
					bufmap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>")
					bufmap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>")
					bufmap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>")
					bufmap("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>")
					bufmap("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>")
					bufmap("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>")
					bufmap("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>")
					bufmap("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>")
					bufmap("n", "gl", "<cmd>lua vim.lsp.buf.open_float()<cr>")
					bufmap("n", "[d", "<cmd>lua vim.lsp.buf.goto_prev()<cr>")
					bufmap("n", "]d", "<cmd>lua vim.lsp.buf.goto_next()<cr>")
				end,
			})

			local mason = require("mason")
			local mason_lspconfig = require("mason-lspconfig")
			local lspconfig = require("lspconfig")
			local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

			mason.setup()
			mason_lspconfig.setup({
				ensure_installed = {
					"lua_ls",
					"ts_ls",
					"html",
					"cssls",
				},
				handlers = {
					function(server)
						lspconfig[server].setup({
							capabilities = lsp_capabilities,
						})
					end,
					["ts_ls"] = function()
						lspconfig.ts_ls.setup({
							capabilities = lsp_capabilities,
							settings = {
								completions = {
									completeFunctionCalls = true,
								},
							},
						})
					end,
				},
			})
		end,
	},
}
