LuvyArray = {}

function LuvyArray.new(...)
	local self = {}
	self.items = { ... }
	setmetatable(self, LuvyArray)
	return self
end

function LuvyArray:__tostring()
	local parts = {}
	for _, v in ipairs(self.items) do
		table.insert(parts, tostring(v))
	end
	return "{" .. table.concat(parts, ", ") .. "}"
end

LuvyArray.__index = function(self, key)
	if type(key) == "number" then
		if key < 0 then
			key = #self.items + key + 1
		end
		return self.items[key]
	else
		return LuvyArray[key] -- This handles method lookup
	end
end

LuvyArray.__newindex = function(self, key, value)
	if type(key) == "number" then
		self.items[key] = value
	else
		error("LuvyArray indices must be numbers, got: " .. type(key))
	end
end

LuvyArray.__eq = function(arr1, arr2)
	if arr1:length() ~= arr2:length() then
		return false
	end

	for i = 1, arr1:length() do
		if arr1[i] ~= arr2[i] then
			return false
		end
	end
	return true
end

function LuvyArray:push(item)
	table.insert(self.items, item)
end

function LuvyArray:pop()
	return table.remove(self.items)
end

function LuvyArray:shift()
	return table.remove(self.items, 1)
end

function LuvyArray:unshift(item)
	table.insert(self.items, 1, item)
end

function LuvyArray:length()
	return #self.items
end

function LuvyArray:at(index)
	if index < 0 then
		index = self:length() + index + 1
	end
	return self.items[index]
end

function LuvyArray:first()
	return self:at(1)
end

function LuvyArray:last()
	return self:at(-1)
end

function LuvyArray:each(predicate)
	for _, v in ipairs(self.items) do
		predicate(v)
	end
	return self
end

function LuvyArray:map(predicate)
	local result = LuvyArray.new()
	self:each(function(v)
		result:push(predicate(v))
	end)
	return result
end

function LuvyArray:map_(predicate)
	self.items = self:map(predicate).items
	return self
end

function LuvyArray:select(predicate)
	local result = LuvyArray.new()
	self:each(function(v)
		if predicate(v) then
			result:push(v)
		end
	end)
	return result
end

function LuvyArray:select_(predicate)
	self.items = self:select(predicate)
	return self
end

function LuvyArray:reject(predicate)
	local result = LuvyArray.new()
	self:each(function(v)
		if not (predicate(v)) then
			result:push(v)
		end
	end)
	return result
end

function LuvyArray:reject_(predicate)
	self.items = self:reject(predicate).items
	return self
end

function LuvyArray:reduce(accumaltor, predicate)
	self:each(function(v)
		accumaltor = predicate(accumaltor, v)
	end)
	return accumaltor
end

function LuvyArray:join(separator)
	return table.concat(self.items, separator)
end

function LuvyArray:include(item)
	for _, v in ipairs(self.items) do
		if v == item then
			return true
		end
	end
	return false
end

function LuvyArray:clear()
	self.items = {}
	return self
end

function LuvyArray:empty()
	return self:length() == 0
end

function LuvyArray:all(predicate)
	for _, v in ipairs(self.items) do
		if not (predicate(v)) then
			return false
		end
	end
	return true
end

function LuvyArray:any(predicate)
	for _, v in ipairs(self.items) do
		if predicate(v) then
			return true
		end
	end
	return false
end

function LuvyArray:index_of(item)
	for i, v in ipairs(self.items) do
		if v == item then
			return i
		end
	end
	return nil
end

function LuvyArray:count(predicate)
	if not predicate then
		return self:length()
	end
	return self:select(predicate):length()
end

function LuvyArray:compact()
	return self:reject(function(v)
		return v == nil
	end)
end

function LuvyArray:compact_()
	return self:reject_(function(v)
		return v == nil
	end)
end

-- Return new array with duplicates removed
function LuvyArray:uniq() end

-- Destructive uniq
function LuvyArray:uniq_() end

-- Return new array with all nested arrays flattened
function LuvyArray:flatten() end

-- Destructive flatten
function LuvyArray:flatten_() end

-- Return new array in reverse order
function LuvyArray:reverse() end

-- Destructive reverse
function LuvyArray:reverse_() end

-- Return new sorted array
function LuvyArray:sort(comparison_func) end

-- Destructive sort
function LuvyArray:sort_() end

-- Return new array with elements common to another array
function LuvyArray:intersection(other) end

-- Return new array combining unique elements from both arrays
function LuvyArray:union(other) end

-- Return new array with elements from other array removed
function LuvyArray:difference(other) end

-- Get range of elements [start_idx, end_idx]
function LuvyArray:slice(start_idx, end_idx) end

-- Get first n elements
function LuvyArray:take(n) end

-- Skip first n elements
function LuvyArray:drop(n) end

-- Group elements into chunks by predicate
function LuvyArray:chunk(predicate) end

-- Convert rows to columns and columns to rows
-- e.g. {{1,2,3}, {4,5,6}} becomes {{1,4}, {2,5}, {3,6}}
-- All sub-arrays must be the same length
function LuvyArray:transpose() end

-- Destructive transpose
function LuvyArray:transpose_() end

setmetatable(LuvyArray, {
	__call = function(self, ...)
		return LuvyArray.new(...)
	end,
})

return LuvyArray
