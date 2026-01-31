local Plug = require('thomas.vimplug')

Plug.begin()

Plug('nvim-lualine/lualine.nvim', {
	config = function()
		require('lualine').setup({
			sections = {
				lualine_x = {{'datetime', style = '%H:%M'}}
			}
		})
	end
})
Plug('nvim-lua/plenary.nvim')
Plug('nvim-treesitter/nvim-treesitter')
Plug('nvim-telescope/telescope.nvim')
Plug('kdheepak/lazygit.nvim')
Plug('williamboman/mason.nvim')
Plug('williamboman/mason-lspconfig.nvim')
Plug('hrsh7th/nvim-cmp')
Plug('hrsh7th/cmp-nvim-lsp')
Plug('neovim/nvim-lspconfig')
Plug('echasnovski/mini.nvim')
Plug('lukas-reineke/indent-blankline.nvim')
Plug('Vimjas/vim-python-pep8-indent')
Plug('linux-cultist/venv-selector.nvim', {
	config = function()
		require('venv-selector').setup({stay_on_this_version = true, name = {'venv', '.venv'}})
	end,
	keys = {
		{'<leader>v', '<cmd>VenvSelect<cr>'}
	},
})
Plug('ThePrimeagen/harpoon', {
	branch = 'harpoon2'
})
Plug('MunifTanjim/nui.nvim')
Plug('rcarriga/nvim-notify')
Plug('folke/noice.nvim')

Plug.ends()
