return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	opts = {
		close_if_last_window = false,
		enable_git_status = true,
		filesystem = {
			filtered_items = {
				visible = true,
			},
		},
		never_show = {
			".DS_Store",
			"thumbs.db",
		},
		git_status = {
			window = {
				position = "float",
				mappings = {
					["A"] = "git_add_all",
					["gu"] = "git_unstage_file",
					["ga"] = "git_add_file",
					["gr"] = "git_revert_file",
					["gc"] = "git_commit",
					["gp"] = "git_push",
				},
			},
		},
	},
	keys = {
		{
			"<leader>nt",
			"<cmd>Neotree toggle<cr>",
			desc = "Toggle NeoTree",
			mode = "n",
		},
		{
			"<leader>gs",
			"<cmd>Neotree git_status<cr>",
			desc = "Neotree git status",
			mode = "n",
		},
	},
}
