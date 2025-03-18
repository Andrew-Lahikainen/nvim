return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			find_command = { "rg", "--files", "--hidden", "-g", "!.git" },
		},
		keys = function()
			local builtin = require("telescope.builtin")
			return {
				{
					"<leader>ff",
					function()
						builtin.find_files({ find_command = { "rg", "--files", "--hidden", "-g", "!.git" } })
					end,
					desc = "Telescope find files",
					mode = "n",
				},
				{
					"<leader>fg",
					builtin.live_grep,
					desc = "Telescope live grep",
					mode = "n",
				},
				{
					"<leader>fb",
					builtin.buffers,
					desc = "Telescope buffers",
					mode = "n",
				},
				{
					"<leader>fh",
					builtin.help_tags,
					desc = "Telescope help tags",
					mode = "n",
				},
			}
		end,
	},
}
