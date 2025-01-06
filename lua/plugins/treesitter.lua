return { -- Highlight, edit, and navigate code
	"nvim-treesitter/nvim-treesitter",
	event = "BufReadPre",
	tag = "v0.9.3",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = { 
				"bash", 
				"c", 
				"lua", 
				"markdown",
				"html",
				"css",
				"javascript",
				"typescript", 
				"rust", 
				"go",
				"python", 
				"powershell",
			},
			auto_install = true,
			highlight = { enable = true },
			indent = { enable = true },
			autopairs = { enable = true },
			incremental_selection = { enable = true },
			context_commentstring = { enable = true },
		})
	end,
}
