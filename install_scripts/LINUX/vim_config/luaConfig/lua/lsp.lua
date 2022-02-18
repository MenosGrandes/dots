local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end
local on_attach = function(client, bufnr)
	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
	local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

	--Enable completion triggered by <c-x><c-o>
	-- buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings.
	local opts = { noremap=true, silent=true }

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
	buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
	buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
	buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
	buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
	buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
	buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
	buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
	buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
	buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
	buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
	buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
	buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
	buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end
require("trouble").setup {
	fold_open = "v", -- icon used for open folds
	fold_closed = ">", -- icon used for closed folds
	indent_lines = false, -- add an indent guide below the fold icons
	signs = {
		-- icons / text used for a diagnostic
		error = "error",
		warning = "warn",
		hint = "hint",
		information = "info"
	},
	use_lsp_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
}
require'nvim-treesitter.configs'.setup {
	ensure_installed = {"cpp","python","c","bash","dockerfile","cmake","html","json","json5","latex","lua","regex","vim","yaml"}, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
	sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
	highlight = {
		enable = true,              -- false will disable the whole extension
		additional_vim_regex_highlighting = false,
	},
}

-- Set completeopt to have a better completion experience
-- vim.opt.completeopt = 'menuone,longest'

-- luasnip setup
local luasnip = require 'luasnip'
require("luasnip.loaders.from_vscode").lazy_load()
-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
		end,
	},
	mapping = {
		['<C-p>'] = cmp.mapping.select_prev_item(),
		['<C-n>'] = cmp.mapping.select_next_item(),
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.close(),
		['<CR>'] = cmp.mapping.confirm {
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		},
		["<Tab>"] = function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif require("luasnip").expand_or_jumpable() then
				vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
			else
				fallback()
			end
		end,
		["<S-Tab>"] = function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif require("luasnip").jumpable(-1) then
				vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
			else
				fallback()
			end
		end,
	},
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
		--{ name = 'buffer' },
		--{ name = 'path' },
		--{ name = 'cmdline' },
		{ name = 'nvim_lua' },
	},
}
cmp.setup.cmdline('/', {
		sources = {
			{ name = 'buffer' }
		}
	})
cmp.setup.cmdline(':', {
		sources = cmp.config.sources({
				{ name = 'path' }
			}, {
				{ name = 'cmdline' }
			})
	})

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
local nvim_lsp = require('lspconfig')
-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { 'ccls', 'pyright' ,'html', 'tsserver'}
for _, lsp in ipairs(servers) do
	nvim_lsp[lsp].setup {
		on_attach = on_attach,
		capabilities = capabilities,
	}
end
----------------- EFM config -----------------
-- Below is a variable in wich you specify where you have prettier installed
-- make sure you update the formatCommand path to the location where you have installed prettier
local prettier = {
	formatCommand = os.getenv('HOME') .. '/.nvm/versions/node/v17.5.0/bin/prettier ${--config-precedence:configPrecedence} ${--tab-width:tabWidth} ${--single-quote:singleQuote} ${--trailing-comma:trailingComma} --stdin-filepath ${INPUT}',
	formatStdin = true
}

-- Below is a variable in wich you specify where eslint_d is installed, you dont need to change this
-- as it should be the same for you.
local eslint = {
	lintCommand = "eslint_d -f unix --stdin",
	lintIgnoreExitCode = true,
	lintStdin = true
}

-- Below you can set some formatting options for prettier
-- Format options for prettier
local format_options_prettier = {
	tabWidth = 2,
	singleQuote = true,
	trailingComma = 'all',
	configPrecedence = 'prefer-file'
}

-- Below is a list of languages and a list of servers you want per language
-- so for typescript we have prettier and eslint for example
local languages = {
	typescript = {prettier, eslint},
	javascript = {prettier, eslint},
	typescriptreact = {prettier, eslint},
	javascriptreact = {prettier, eslint},
	yaml = {prettier},
	json = {prettier},
	html = {prettier},
	scss = {prettier},
	css = {prettier},
	markdown = {prettier},
	python = {black, flake8}
}
local black = require "efm/black"
local flake8 = require "efm/flake8"
require "lspconfig".efm.setup {
	on_attach = on_attach,

	filetypes = vim.tbl_keys(languages),    
	-- Set some extra settings
	init_options = {
		-- Enable document formatting
		documentFormatting = true,

		-- Enable hover information functionality
		hover = true,

		-- Enable the use of symbols
		documentSymbol = true,

		-- Enable the use of code actions
		codeAction = true,

		-- Enable autocompletion popup
		completion = true
	},
	settings = {
		-- This is the location where error messages wil be written to
		-- this is nice for debugging your language server
		log_file = '~/.config/efm.log',

		-- These are the paths efm will look for eslint settings and prettier settings
		-- inside a project you are working on
		rootMarkers = {
			".git/",
			".lua-format",
			".eslintrc.cjs",
			".eslintrc",
			".eslintrc.json",
			".eslintrc.js",
			".prettierrc",
			".prettierrc.js",
			".prettierrc.json",
			".prettierrc.yml",
			".prettierrc.yaml",
			".prettier.config.js",
			".prettier.config.cjs",
		},

		-- Setting the languages
		languages = languages

	}
}
