local M = {}

-- INFO: find_mapping: take a table of mappings and find the info for the lhs value.
local find_mapping = function(maps, lhs)
	for _, value in ipairs(maps) do
		if value.lhs == lhs then
			return value
		end
	end
end

M._stack = {}

--[[
name: the custom name for our mode
mode: the vim mode for which the keymap is defined
mappings: the list of the actual mappings to map
--]]
M.push = function(name, mode, mappings)
	local maps = vim.api.nvim_get_keymap(mode)

	local existing_maps = {}
	for lhs, _ in pairs(mappings) do
		local existing = find_mapping(maps, lhs)
		if existing then
			table.insert(existing_maps, existing)
		end
	end

	M._stack[name] = existing_maps

	for lhs, rhs in pairs(mappings) do
		-- TODO: pass other options here
		vim.api.nvim_set_keymap(mode, lhs, rhs, {})
	end
end

M.pop = function(name)
-- TODO: Implement pop
end

M.push("debug_mode", "n", {
	[" lg"] = "echo 'Hello'",
	[" ll"] = "echo 'Hello again'",
})

return M
