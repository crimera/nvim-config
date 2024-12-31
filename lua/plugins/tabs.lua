return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	opts = {
		options = {
			diagnostics = "nvim_lsp",
			diagnostics_indicator = function(_, _, diag)
				local ret = (diag.error and " " .. diag.error .. " " or "")
					.. (diag.warning and " " .. diag.warning or "")
				return vim.trim(ret)
			end,
		},
	},
}
