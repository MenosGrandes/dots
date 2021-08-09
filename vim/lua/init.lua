vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.encoding = "utf-8"
vim.opt.wildmenu = true
vim.opt.laststatus = 2
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.hlsearch = true
vim.opt.wildmode = {"longest","list","full"}
vim.opt.list = true
vim.opt.listchars = { trail= '⋅', tab = ':›', eol = '¬'  }
vim.opt.ignorecase = true
vim.opt.clipboard = "unnamed"
vim.o.completeopt = "menuone,noselect"
-- colors --
vim.cmd[[colorscheme dracula]]
-- plugins --
local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.vim/plugged')
Plug 'neovim/nvim-lspconfig'
Plug 'SirVer/ultisnips'
Plug "hrsh7th/nvim-compe"
vim.call('plug#end')

-- nvim-compe
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  resolve_timeout = 800;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = {
    border = { '', '' ,'', ' ', '', '', '', ' ' }, -- the border option is the same as `|help nvim_open_win|`
    winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
    max_width = 120,
    min_width = 60,
    max_height = math.floor(vim.o.lines * 0.3),
    min_height = 1,
  };

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = true;
    ultisnips = true;
    luasnip = true;
  };
}



vim.api.nvim_set_keymap('n', '<Leader><Space>', ':set hlsearch!<CR>', { noremap = true, silent = true })
