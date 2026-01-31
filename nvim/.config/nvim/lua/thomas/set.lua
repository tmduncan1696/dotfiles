vim.g.mapleader = ' '

vim.opt.nu = true
vim.opt.rnu = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.expandtab = true
vim.opt.autoindent = true

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'python',
    callback = function()
	vim.bo.expandtab = true
	vim.bo.tabstop = 4
	vim.bo.shiftwidth = 4
	vim.softtabstop = 4
    end
})

vim.opt.wrap = false

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.scrolloff = 8

vim.opt.updatetime = 80

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.guifont = 'CaskaydiaMonoNerdFont-Regular'

vim.opt.shadafile = 'NONE'

vim.g.python3_host_prog = 'python3'
