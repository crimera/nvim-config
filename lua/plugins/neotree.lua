-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
	"nvim-neo-tree/neo-tree.nvim",
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
	},
	cmd = "Neotree",
	keys = {
		{
			"<leader>e",
			function()
				-- Check if CodeCompanion is open and close it if it is
				local codecompanion = require("codecompanion")
				local windows = vim.api.nvim_list_wins()

				-- Look for CodeCompanion window
				for _, win in ipairs(windows) do
					local buf = vim.api.nvim_win_get_buf(win)
					local name = vim.api.nvim_buf_get_name(buf)
					if string.match(name, "CodeCompanion") then
						codecompanion.toggle()
						break
					end
				end

				-- Toggle NeoTree
				vim.cmd("Neotree toggle")
			end,
			desc = "NeoTree reveal",
			silent = true,
		},
	},
	opts = {
		filesystem = {
			window = {
				position = "right",
				mappings = {
					["<leader>e"] = "close_window",
				},
			},
		},
	},
}
