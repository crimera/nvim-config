return {
	"neovim/nvim-lspconfig",
	dependecies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
	},
	keys = {
		{
			"<leader>rn",
			function()
				vim.lsp.buf.rename()
			end,
			"Rename",
		},
	},
	opts = {},
	config = function()
		-- Set up lspconfig.

		local servers = {
			"angularls",
			"html",
			"vtsls",
			"gopls",
			"rust_analyzer",
			"svelte",
			"tailwindcss",
			"cssls",
			"pyright",
			"clangd",
			"zls",
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
