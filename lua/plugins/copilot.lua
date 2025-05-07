return {
	{
		"zbirenbaum/copilot.lua",
		config = function()
			require("copilot").setup({
				suggestion = {
					enabled = true,
					auto_trigger = true,
					keymap = {
						accept = "<Tab>",
					},
				},
			})
		end,
	}, -- or github/copilot.vim
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
			{ "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
		},
		keys = {
			{ "<leader>av", "<cmd>CopilotChatToggle<cr>", desc = "CopilotChat - Toggle" },
			{
				"<leader>as",
				"<cmd>CopilotChatCommitStage<cr>",
				desc = "Use copilot to generate commit for stagged changes",
			},
			{
				"<leader>ai",
				function()
					local input = vim.fn.input("Quick Chat: ")

					if input ~= "" then
						require("CopilotChat").ask(input, { selection = require("CopilotChat.select").visual })
					end
				end,
				desc = "CopilotChat Selected",
				mode = "v",
			},
			{
				"<leader>ai",
				function()
					local input = vim.fn.input("Quick Chat: ")

					if input ~= "" then
						require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
					end
				end,
				desc = "CopilotChat - Quick chat",
				mode = "n",
			},
		},
		opts = {
			debug = false,
			model = "claude-3.5-sonnet",

			window = {
				layout = "float",
				border = "rounded",
				width = 0.6,
				height = 0.9,
			},
			mappings = {
				close = {
					normal = "<ESC>",
				},
			},
		},
	},
	{
		"olimorris/codecompanion.nvim",
		keys = {
			{
				"<C-c>",
				function()
					-- Toggle NeoTree
					vim.cmd("Neotree close")

					-- Also toggle CodeCompanion
					require("codecompanion").toggle()
				end,
				desc = "CodeCompanion chat",
				mode = { "i", "n" },
			},
		},
		opts = {
			display = {
				chat = {
					window = {
						position = "right",
						width = 0.35,
					},
				},
			},
			adapters = {
				copilot = function()
					return require("codecompanion.adapters").extend("copilot", {
						schema = {
							model = {
								default = "claude-3.7-sonnet-thought",
							},
						},
					})
				end,
				copilot_inline = function()
					return require("codecompanion.adapters").extend("copilot", {
						schema = {
							model = {
								default = "gpt-4o",
							},
						},
					})
				end,
			},
			strategies = {
				chat = {
					adapter = "copilot",
					keymaps = {
						close = {
							modes = { n = "<C-S-c>", i = "<C-S-c>" },
						},
						-- Add further custom keymaps here
					},
				},
				inline = {
					adapter = "copilot_inline",
				},
			},
		},
		init = function()
			local progress = require("fidget.progress")
			local handle = nil

			local group = vim.api.nvim_create_augroup("CodeCompanionFidgetHooks", {})

			vim.api.nvim_create_autocmd({ "User" }, {
				pattern = "CodeCompanionRequest*",
				group = group,
				callback = function(request)
					if request.match == "CodeCompanionRequestStarted" then
						local adapter_name = "TODO"
						local model_name = "TODO"
						handle = progress.handle.create({
							title = " Requesting assistance",
							lsp_client = {
								name = string.format("CodeCompanion (%s - %s)", adapter_name, model_name),
							},
						})
					elseif request.match == "CodeCompanionRequestFinished" then
						if handle then
							handle:finish()
						end
					end
				end,
			})
		end,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
	},
}
