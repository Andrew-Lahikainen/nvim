return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
        ensure_installed = {
            "c",
            "lua",
            "vim",
            "vimdoc",
            "query",
            "html",
            "javascript",
            "typescript",
            "rust"
        },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
    }
}
