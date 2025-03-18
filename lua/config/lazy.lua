local lazypath = vim.fn.stdpath("data") .. "lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		lazyrepo,
		lazypath,
	})

	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "warningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end

vim.opt.rtp:prepend(lazypath)

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.cursorline = true
vim.opt.termguicolors = true

-- Make sure to setup `mapleader` and `maplocalleader` before loading lazy.nvim so that mappings
-- are correct:
vim.keymap.set("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Yank into system clipboard:
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y') -- Yank motion
vim.keymap.set({ "n", "v" }, "<leader>yy", '"+yy') -- Yank line

-- Delete into system clipboard:
vim.keymap.set({ "n", "v" }, "<leader>d", '"+d') -- Delete motion
vim.keymap.set({ "n", "v" }, "<leader>dd", '"+d') -- Delete line

-- Paste from system clipboard:
vim.keymap.set("n", "<leader>P", '"+P') -- Paste before cursor
vim.keymap.set("n", "<leader>p", '"+p') -- Paste after cursor

-- Setup lazy.nvim:
require("lazy").setup({
	spec = {
		-- Import plugins:
		{ import = "plugins" },
	},
	install = {
		-- Colorscheme that will be used when installing plugins:
		colorscheme = { "habamax" },
	},
	-- Automatically check for plugin updates:
	checker = { enabled = true },
})
