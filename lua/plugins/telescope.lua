return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = {
		{
			"<C-p>",
			function()
				require("telescope.builtin").find_files()
			end,
			mode = "n",
			desc = "Find files in git repo",
		},
		{
			"<leader>g",
			function()
				require("telescope.builtin").grep_string()
			end,
			mode = "n",
			desc = "Find files in git repo",
		},
		{
			"<leader>f",
			function()
				require("telescope.builtin").git_files()
			end,
			mode = "n",
			desc = "Find files",
		},
		{
			"<leader><leader>",
			function()
				require("telescope.builtin").buffers()
			end,
			mode = "n",
			desc = "List buffers",
		},
	},
}
