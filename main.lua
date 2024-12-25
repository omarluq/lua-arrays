Array = {}

Array.__index = Array

function Array.new(...)
	local self = setmetatable({}, Array)
	self.items = { ... }
	return self
end

function Array:__tostring()
	local parts = {}
	for _, v in ipairs(self.items) do
		table.insert(parts, tostring(v))
	end
	return "{" .. table.concat(parts, ", ") .. "}"
end

function Array:push(item)
	table.insert(self.items, item)
end

function Array:pop()
	return table.remove(self.items)
end

function Array:shift()
	return table.remove(self.items, 1)
end

function Array:unshift(item)
	table.insert(self.items, 1, item)
end

local arr = Array.new(1, 2, 3)

print("arr")
print(arr)
