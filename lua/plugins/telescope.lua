return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = {
        {
            "<leader>q",
            function()
                require("telescope.builtin").quickfix()
            end,
            mode = "n",
            desc = "Show quickfix list",
        },
		{
			"<C-p>",
			function()
				require("telescope.builtin").find_files()
			end,
			mode = {"n", "i"},
			desc = "Find files",
		},
		{
			"<leader>g",
			function()
				require("telescope.builtin").grep_string()
			end,
			mode = "n",
			desc = "Grep",
		},
		{
			"<leader>f",
			function()
				require("telescope.builtin").git_files()
			end,
			mode = "n",
			desc = "Find files in git repo",
		},
		{
			"<leader><leader>",
			function()
				require("telescope.builtin").buffers()
			end,
			mode = "n",
			desc = "List buffers",
		},
		{
			"gd",
			function()
				require("telescope.builtin").lsp_definitions()
			end,
			"[G]oto [D]efinitions"
		}
	},
}
