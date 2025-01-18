return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            
        },
        keys = function ()
            local builtin = require("telescope.builtin")
            return {
                { "<leader>ff", builtin.find_files, desc = "Telescope find files", mode = "n" },
                { "<leader>fg", builtin.live_grep, desc = "Telescope live grep", mode = "n" },
                { "<leader>fb", builtin.buffers, desc = "Telescope buffers", mode = "n" },
                { "<leader>fh", builtin.help_tags, desc = "Telescope help tags", mode = "n" },
            }
        end,
    }
}
