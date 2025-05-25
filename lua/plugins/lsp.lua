return {
    {
        "neovim/nvim-lspconfig",
        lazy = true,
        config = function()
            local capabilities = require("blink.cmp").get_lsp_capabilities()

            vim.lsp.config("*", {
                capabilities = capabilities,
                root_markers = { ".git" },
            })

            vim.lsp.enable("ts_ls")
            vim.lsp.enable("lua_ls")
            vim.lsp.enable("astro")

            vim.lsp.inlay_hint.enable(true, { 0 })
        end,
        keys = {
            {
                "K",
                function()
                    vim.lsp.buf.hover()
                end,
                desc = "lsp: hover"
            },
            {
                "gd",
                function()
                    vim.lsp.buf.definition()
                end,
                desc = "lsp: go to definition"
            },
            {
                "gD",
                function()
                    vim.lsp.buf.declaration()
                end,
                desc = "lsp: go to declaration"
            },
            {
                "gi",
                function()
                    vim.lsp.buf.implementation()
                end,
                desc = "lsp: go to implementation"
            },
            {
                "go",
                function()
                    vim.lsp.buf.type_definition()
                end,
                desc = "lsp: go to type definition"
            },
            {
                "gr",
                function()
                    vim.lsp.buf.references()
                end,
                desc = "lsp: go to references"
            },
            {
                "gs",
                function()
                    vim.lsp.buf.signature_help()
                end,
                desc = "lsp: signature help"
            },
            {
                "<F2>",
                function()
                    vim.lsp.buf.rename()
                end,
                desc = "lsp: rename"
            },
            {
                "<F4>",
                function()
                    vim.lsp.buf.code_action()
                end,
                desc = "lsp: code action"
            },
            {
                "gl",
                function()
                    vim.lsp.buf.open_float()
                end,
                desc = "lsp: open diagnostics float"
            },
            {
                "[d",
                function()
                    vim.lsp.buf.goto_prev()
                end,
                desc = "lsp: go to previous diagnostic"
            },
            {
                "]d",
                function()
                    vim.lsp.buf.goto_next()
                end,
                desc = "lsp: go to next diagnostic"
            }
        },
    },
    {
        "mason-org/mason-lspconfig.nvim",
        lazy = false,
        config = function()
            require("lspconfig")
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "ts_ls",
                    "lua_ls",
                },
                automatic_enable = true,
            })
        end
    },
    {
        "mason-org/mason.nvim",
        event = "VeryLazy",
        opts = {}
    }
}