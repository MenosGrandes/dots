vim.opt.list = true
vim.opt.listchars = { space = '·', tab = '>~' }
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.wildmenu = true
vim.opt.wildmode = { longest, list, full }
vim.opt.laststatus = 2
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.hlsearch = true
vim.opt.clipboard:append({ unnamed })
vim.opt.ignorecase = true
vim.opt.cursorline = true
vim.diagnostic.config({
	virtual_text = false
})
-- Show line diagnostics automatically in hover window
vim.o.updatetime = 250
vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
-- vim.cmd("colorscheme kanagawa-wave")
