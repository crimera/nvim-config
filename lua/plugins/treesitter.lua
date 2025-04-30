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

		local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
		parser_config.renpy = {
		  install_info = {
			url = "/Users/steven/Downloads/totono/tree-sitter-renpy", -- local path or git repo
			files = {"src/parser.c"}, -- note that some parsers also require src/scanner.c or src/scanner.cc
			-- optional entries:
			branch = "trunk", -- default branch in case of git repo if different from master
			generate_requires_npm = false, -- if stand-alone parser without npm dependencies
			requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
		  },
		  filetype = "rpy", -- if filetype does not match the parser name
		}

		vim.treesitter.language.register('renpy', 'rpy')  -- the someft filetype will use the python parser and queries.

	end,
}
