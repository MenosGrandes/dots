
local function map(mode, lhs, rhs, opts)

  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end
map('','<C-h>', '<C-w>h')
map('','<C-j>', '<C-w>j')
map('','<C-k>', '<C-w>k')
map('','<C-l>', '<C-w>l')
map('', '<Leader>n',':NERDTreeToggle<CR>')
map('', '<Leader>f',':NERDTreeFind<CR>')
vim.api.nvim_exec([[ autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif ]], false)
local cmd = vim.cmd
cmd([[command! Config execute "e $MYVIMRC" ]])
