local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

vim.opt.list = true
vim.opt.listchars = { space = '_', tab = '>~' }
vim.opt.relativenumber = true
vim.opt.wildmenu = true
vim.opt.wildmode = {longest,list,full}
vim.opt.laststatus=2
vim.opt.softtabstop=4
vim.opt.expandtab = true
vim.opt.hlsearch= true
vim.opt.clipboard:append({unnamed})
vim.opt.ignorecase = true

-- Shortcutting split navigation, saving a keypress: TODO Move to navigation.lua
map('','<C-h>', '<C-w>h')
map('','<C-j>', '<C-w>j')
map('','<C-k>', '<C-w>k')
map('','<C-l>', '<C-w>l')
vim.cmd("colorscheme dracula")
map('', '<Leader>n',':NERDTreeToggle<CR>')
vim.api.nvim_exec([[ autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif ]], false)
local cmd = vim.cmd
cmd([[command! Config execute "e $MYVIMRC" ]])
