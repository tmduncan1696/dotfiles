vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)

vim.keymap.set('t', '<esc>', '<C-\\><C-n>')

vim.keymap.set('v', 'J', ':m >+1<CR>gv=gv')
vim.keymap.set('v', 'K', ':m <-1<CR>gv=gv')

vim.keymap.set('n', 'J', 'mzJ`z')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

vim.keymap.set('n', '<A-t>', ':sp term<CR>:term<CR>10<C-w>_i')
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')

vim.keymap.set('n', '<leader>c', ':.s/^\\(\\s*\\)/\\1# /e<CR>')
vim.keymap.set('v', '<leader>c', ':s/^\\(\\s*\\)/\\1# /e<CR>')

vim.keymap.set('n', '<leader>C', ':.s/^\\(\\s*\\)\\(# \\)\\+/\\1/e<CR>')
vim.keymap.set('v', '<leader>C', ':.s/^\\(\\s*\\)\\(# \\)\\+/\\1/e<CR>')
