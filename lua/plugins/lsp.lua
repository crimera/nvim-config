return {
	"neovim/nvim-lspconfig",
	dependecies = {
		{
			"j-hui/fidget.nvim",
			opts = {},
		},
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		-- Set up lspconfig.
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		local servers = {
			{"gopls", opts = {}},
			"vtsls",
			"svelte",
			"tailwindcss",
			"cssls",
		}

		for _, server in pairs(servers) do
			if type(server) == "table" then
				require("lspconfig")[server[1]].setup(vim.tbl_extend("force", {
					capabilities = capabilities,
				}, server.opts))
			else
				require("lspconfig")[server].setup({
					capabilities = capabilities,
				})
			end
		end
	end,
}
