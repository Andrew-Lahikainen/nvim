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
					-- accept currently selected item:
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<Tab>"] = cmp.mapping(function(fallback)
						-- This little snippet will confirm with tab, and if no entry is selected, will confirm the first item
						if cmp.visible() then
							local entry = cmp.get_selected_entry()
							if not entry then
								cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
							end
							cmp.confirm()
						else
							fallback()
						end
					end, { "i", "s", "c" }),
				}),
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
			})

			-- https://github.com/hrsh7th/nvim-cmp/issues/1511
			vim.keymap.set("c", "<Tab>", "<C-z>", { silent = false })

			local lsp_cmds = vim.api.nvim_create_augroup("lsp_cmds", { clear = true })

			vim.api.nvim_create_autocmd("LspAttach", {
				group = lsp_cmds,
				desc = "LSP actions",
				callback = function()
					local bufmap = function(mode, lhs, rhs, desc)
						vim.keymap.set(mode, lhs, rhs, { buffer = true, desc = desc })
					end

					bufmap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", "lsp: hover")
					bufmap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", "lsp: go to definition")
					bufmap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", "lsp: go to declaration")
					bufmap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", "lsp: go to implementation")
					bufmap("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<CR>", "lsp: go to type definition")
					bufmap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", "lsp: go to references")
					bufmap("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>", "lsp: signature help")
					bufmap("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<CR>", "lsp: rename")
					bufmap("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<CR>", "lsp: code action")
					bufmap("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", "lsp: open diagnostics float")
					bufmap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", "lsp: go to previous diagnostic")
					bufmap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", "lsp: go to next diagnostic")
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
