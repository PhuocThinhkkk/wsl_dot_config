return {
	{
		"neovim/nvim-lspconfig",
		tag = "v1.8.0",
		pin = true,
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"j-hui/fidget.nvim",
			"stevearc/conform.nvim",
		},
		config = function()
			vim.opt.signcolumn = "yes"

			local lsp_defaults = require("lspconfig.util").default_config
			lsp_defaults.capabilities =
				vim.tbl_deep_extend("force", lsp_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

			require("fidget").setup({})
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					go = { "gofmt" },
					rust = { "rustfmt" },
					javascript = { "prettier" },
					typescript = { "prettier" },
					["typescriptreact"] = { "prettier" },
					["javascriptreact"] = { "prettier" },
					json = { "prettier" },
					css = { "prettier" },
					html = { "prettier" },
				},
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				desc = "LSP actions",
				callback = function(ev)
					local buf = ev.buf
					local map = vim.keymap.set
					local opts = { buffer = buf }
					map("n", "K", vim.lsp.buf.hover, opts)
					map("n", "gd", vim.lsp.buf.definition, opts)
					map("n", "gD", vim.lsp.buf.declaration, opts)
					map("n", "gi", vim.lsp.buf.implementation, opts)
					map("n", "go", vim.lsp.buf.type_definition, opts)
					map("n", "gr", vim.lsp.buf.references, opts)
					map("n", "gs", vim.lsp.buf.signature_help, opts)
					map("n", "<F2>", vim.lsp.buf.rename, opts)
					map({ "n", "x" }, "<leader>fa", function()
						require("conform").format({ async = true })
					end)
					map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
				end,
			})
		end,
	},

	-- 2. Mason installer
	{
		"williamboman/mason.nvim",
		tag = "v1.11.0",
		pin = true,
		config = true,
	},

	-- 3. Mason + lspconfig integration
	{
		"williamboman/mason-lspconfig.nvim",
		tag = "v1.32.0",
		pin = true,
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "ts_ls", "gopls", "rust_analyzer" },
			})
			require("mason-lspconfig").setup_handlers({
				function(server)
					require("lspconfig")[server].setup({})
				end,
				["lua_ls"] = function()
					require("lspconfig").lua_ls.setup({
						settings = {
							Lua = {
								format = {
									enable = true,
									defaultConfig = {
										indent_style = "space",
										indent_size = "2",
									},
								},
							},
						},
					})
				end,
			})
		end,
	},

	-- 4. nvim-cmp with first‑config behavior
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-p>"] = cmp.mapping.select_prev_item({ behavior = "select" }),
					["<C-n>"] = cmp.mapping.select_next_item({ behavior = "select" }),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-y>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
				}, {
					{ name = "buffer" },
					{ name = "path" },
				}),
			})
		end,
	},
}
