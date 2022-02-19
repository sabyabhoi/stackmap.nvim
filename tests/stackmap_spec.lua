local find_mapping = function(maps, lhs)
	for _, value in ipairs(maps) do
		if value.lhs == lhs then
			return value
		end
	end
end

describe("stackmap", function()
	it("can be required", function()
		require "stackmap"
	end)

	it("can push a single mapping", function()
		local rhs =  "echo 'This is a test'"
		require("stackmap").push("test1", "n", {
			foo = rhs,
		})

		local maps = vim.api.nvim_get_keymap('n')

		local found = find_mapping(maps, "foo")
		assert.are.same(rhs, found.rhs)
	end)
	
	it("can push multiple mappings", function()
		local rhs =  "echo 'This is a test'"
		require("stackmap").push("test1", "n", {
			["foo"] = rhs .. "1",
			["bar"] = rhs .. "2",
		})

		local maps = vim.api.nvim_get_keymap('n')

		local found1 = find_mapping(maps, "foo")
		assert.are.same(rhs .. "1", found1.rhs)

		local found2 = find_mapping(maps, "bar")
		assert.are.same(rhs .. "2", found2.rhs)
	end)
end)
