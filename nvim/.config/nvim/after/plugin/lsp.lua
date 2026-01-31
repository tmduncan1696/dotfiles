require('mason').setup()

local mason_lspconfig = require('mason-lspconfig')

mason_lspconfig.setup({
	ensure_installed = { 'pylsp' }
})

local function find_venv(start_path)
	local venv_path = start_path .. '/.venv'
	
	if vim.fn.isdirectory(venv_path) == 1 then
		return venv_path
	end

	local handle = vim.loop.fs_scandir(start_path)
	if handle then
		while true do
			local name, type = vim.loop.fs_scandir_next(handle)
			if not name then break end
			if type == 'directory' then
				venv_path = start_path .. '/' .. name .. '/.venv'
				if vim.fn.isdirectory(venv_path) == 1 then
					return venv_path
				end
			end
		end
	end

	return nil
end

local cmp = require('cmp')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

local pylsp_restarted = false

vim.lsp.config('pylsp', {
	on_init = function(client)
		if not pylsp_restarted then
			local cwd = vim.fn.getcwd()
			local venv_path = find_venv(cwd)
			if venv_path then
				print('venv folder found: ' .. venv_path)
				vim.env.VIRTUAL_ENV = venv_path
				vim.env.PATH = venv_path .. '/bin:' .. vim.env.PATH

				pylsp_restarted = true

				vim.schedule(function()
					vim.cmd('LspRestart pylsp')
					print('PyLSP restarted with new venv settings')
				end)
			else
				print('No venv folder found')
			end
		end
		return true
	end,
	on_attach = custom_attach,
	settings = {
		pylsp = {
			plugins = {
				black = { enabled = true },
				autopep8 = { enabled = false },
				yapf = { enabled = false },
				pylint = { enabled = true, executable = 'pylint' },
				pyflakes = { enabled = false },
				pycodestyle = { enabled = false },
				pylsp_mypy = { enabled = true },
				jedi_completion = { fuzzy = true },
				pyls_isort = { enabled = true }
			},
		},
	},
	flags = {
		debounce_text_changes = 200,
	},
	capabilities = capabilities,
	root_markers = { '.git' }
})

vim.lsp.enable('pylsp')

vim.diagnostic.config({
	virtual_text = true
})
