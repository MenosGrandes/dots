return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-buffer", -- source for text in buffer
		"hrsh7th/cmp-path",   -- source for file system paths
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip"
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		require("luasnip.loaders.from_vscode").lazy_load()
		cmp.setup(
			{
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end
				},
				mapping = cmp.mapping.preset.insert(
					{
						["<C-p>"] = cmp.mapping.select_prev_item(),
						["<C-n>"] = cmp.mapping.select_next_item(),
						["<C-d>"] = cmp.mapping.scroll_docs(-4),
						["<C-f>"] = cmp.mapping.scroll_docs(4),
						["<C-Space>"] = cmp.mapping.complete(),
						["<C-e>"] = cmp.mapping.close(),
						["<CR>"] = cmp.mapping.confirm(
							{
								behavior = cmp.ConfirmBehavior.Replace,
								select = true
							}
						),
						["<Tab>"] = function(fallback)
							if cmp.visible() then
								cmp.select_next_item()
							elseif require("luasnip").expand_or_jumpable() then
								vim.fn.feedkeys(
									vim.api.nvim_replace_termcodes(
										"<Plug>luasnip-expand-or-jump", true,
										true, true),
									""
								)
							else
								fallback()
							end
						end,
						["<S-Tab>"] = function(fallback)
							if cmp.visible() then
								cmp.select_prev_item()
							elseif require("luasnip").jumpable(-1) then
								vim.fn.feedkeys(
									vim.api.nvim_replace_termcodes(
										"<Plug>luasnip-jump-prev", true, true,
										true),
									""
								)
							else
								fallback()
							end
						end
					}
				),
				sources = cmp.config.sources(
					{
						{ name = "nvim_lsp" },
						{ name = "buffer" },
						{ name = "path" },
						{ name = "luasnip" }
					}
				)
			}
		)
		cmp.setup.cmdline(
			"/",
			{
				sources = {
					{ name = "buffer" }
				}
			}
		)
		cmp.setup.cmdline(
			":",
			{
				sources = cmp.config.sources(
					{
						{ name = "path" }
					},
					{
						{ name = "cmdline" }
					}
				)
			}
		)
		vim.cmd(
			[[
      set completeopt=menuone,noinsert,noselect
      highlight! default link CmpItemKind CmpItemMenuDefault
    ]]
		)
	end
}
