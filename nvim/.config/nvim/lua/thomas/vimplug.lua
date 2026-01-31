local configs = {
	lazy = {},
	start = {}
}

local Plug = {
	begin = vim.fn['plug#begin'],

	ends = function()
		vim.fn['plug#end']()

		for i, config in pairs(configs.start) do
			config()
		end
	end
}

local apply_config = function(plugin_name)
	local fn = configs.lazy[plugin_name]
	if type(fn) == 'function' then fn() end
end

local plug_name = function(repo)
	return repo:match("^[%w-]+/([%w-_.]+)$")
end

local meta = {
	__call = function(self, repo, opts)
		opts = opts or vim.empty_dict()

		opts['do'] = opts.run
		opts.run = nil

		opts['for'] = opts.ft
		opts.ft = nil

		vim.call('plug#', repo, opts)

		if type(opts.config) == 'function' then
			local plugin = opts.as or plug_name(repo)

			if opts['for'] == nil and opts.on == nil then
				configs.start[plugin] = opts.config
			else
				configs.lazy[plugin] = opts.config
				vim.api.nvim_create_autocmd('User', {
					pattern = plugin,
					once = true,
					callback = function()
						apply_config(plugin)
					end,
				})
			end
		end
	end
}

return setmetatable(Plug, meta)

