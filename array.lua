Array = {}

function Array.new(...)
	local self = {}
	self.items = { ... }
	setmetatable(self, Array)
	return self
end

function Array:__tostring()
	local parts = {}
	for _, v in ipairs(self.items) do
		table.insert(parts, tostring(v))
	end
	return "{" .. table.concat(parts, ", ") .. "}"
end

function Array:__index(key)
	if type(key) == "number" then
		if key < 0 then
			key = #self.items + key + 1
		end
		return self.items[key]
	else
		return Array[key] -- This handles method lookup
	end
end

function Array:__newindex(key, value)
	if type(key) == "number" then
		self.items[key] = value
	else
		error("Array indices must be numbers, got: " .. type(key))
	end
end

function Array:__eq(arr2)
	if self:length() ~= arr2:length() then
		return false
	end
	for i = 1, self:length() do
		if self[i] ~= arr2[i] then
			return false
		end
	end
	return true
end

function Array:__add(other)
	local result = Array()
	for _, v in ipairs(self.items) do
		result:push(v)
	end
	for _, v in ipairs(other.items) do
		result:push(v)
	end
	return result
end

function Array:__sub(other)
	return self:reject(function(x)
		return other:include(x)
	end)
end

function Array:__mul(n)
	if type(n) == "number" then
		local result = Array()
		for _ = 1, n do
			for _, v in ipairs(self.items) do
				result:push(v)
			end
		end
		return result
	end
	error("Can only multiply array by a number")
end

function Array:__div(n)
	if type(n) == "number" then
		local result = Array()
		local currentChunk = Array()
		for _, v in ipairs(self.items) do
			currentChunk:push(v)
			if currentChunk:length() == n then
				result:push(currentChunk)
				currentChunk = Array()
			end
		end
		if currentChunk:length() > 0 then
			result:push(currentChunk)
		end
		return result
	end
	error("Can only divide array by a number")
end

function Array:__lt(other)
	return self:length() < other:length()
end

function Array:__le(other)
	return self:length() <= other:length()
end

function Array:__gt(other)
	return self:length() > other:length()
end

function Array:__ge(other)
	return self:length() >= other:length()
end

function Array:__unm()
	return self:reverse()
end

function Array:__concat(other)
	local result = Array()
	for _, v in ipairs(self.items) do
		result:push(v)
	end
	if type(other) == "table" and other.items then
		for _, v in ipairs(other.items) do
			result:push(v)
		end
	else
		result:push(other)
	end
	return result
end

function Array:__len()
	return self:length()
end

function Array:push(item)
	table.insert(self.items, item)
	return self
end

function Array:pop()
	return table.remove(self.items), self
end

function Array:shift()
	return table.remove(self.items, 1), self
end

function Array:unshift(item)
	table.insert(self.items, 1, item)
	return self
end

function Array:length()
	return #self.items
end

function Array:at(index)
	if index < 0 then
		index = self:length() + index + 1
	end
	return self.items[index]
end

function Array:first()
	return self:at(1)
end

function Array:last()
	return self:at(-1)
end

function Array:each(predicate)
	for i, v in ipairs(self.items) do
		predicate(v, i)
	end
	return self
end

function Array:map(predicate)
	local result = Array()
	self:each(function(v)
		result:push(predicate(v))
	end)
	return result
end

function Array:map_(predicate)
	self.items = self:map(predicate).items
	return self
end

function Array:select(predicate)
	local result = Array()
	self:each(function(v)
		if predicate(v) then
			result:push(v)
		end
	end)
	return result
end

function Array:select_(predicate)
	self.items = self:select(predicate)
	return self
end

function Array:reject(predicate)
	local result = Array()
	self:each(function(v)
		if not (predicate(v)) then
			result:push(v)
		end
	end)
	return result
end

function Array:reject_(predicate)
	self.items = self:reject(predicate).items
	return self
end

function Array:reduce(accumulator, predicate)
	self:each(function(v)
		accumulator = predicate(accumulator, v)
	end)
	return accumulator
end

function Array:join(separator)
	return table.concat(self.items, separator)
end

function Array:include(item)
	for _, v in ipairs(self.items) do
		if v == item then
			return true
		end
	end
	return false
end

function Array:clear()
	self.items = {}
	return self
end

function Array:empty()
	return self:length() == 0
end

function Array:all(predicate)
	for _, v in ipairs(self.items) do
		if not (predicate(v)) then
			return false
		end
	end
	return true
end

function Array:any(predicate)
	for _, v in ipairs(self.items) do
		if predicate(v) then
			return true
		end
	end
	return false
end

function Array:index_of(item)
	for i, v in ipairs(self.items) do
		if v == item then
			return i
		end
	end
	return nil
end

function Array:count(predicate)
	if not predicate then
		return self:length()
	end
	return self:select(predicate):length()
end

function Array:uniq()
	local result = Array()
	self:each(function(v)
		if not result:include(v) then
			result:push(v)
		end
	end)
	return result
end

function Array:uniq_()
	self.items = self:uniq().items
	return self
end

function Array:flatten()
	local result = Array()
	self:each(function(v)
		if getmetatable(v) == Array then
			v:each(function(item)
				result:push(item)
			end)
		else
			result:push(v)
		end
	end)
	return result
end

function Array:flatten_()
	self.items = self:flatten().items
	return self
end

function Array:deep_flatten()
	local result = Array()
	self:each(function(v)
		if getmetatable(v) == Array then
			v:deep_flatten():each(function(item)
				result:push(item)
			end)
		else
			result:push(v)
		end
	end)
	return result
end

function Array:deep_flatten_()
	self.items = self:deep_flatten().items
	return self
end

function Array:reverse()
	local result = Array()
	self:each(function(v)
		result:unshift(v)
	end)
	return result
end

function Array:reverse_()
	self.items = self:reverse().items
	return self
end

function Array:sort(predicate)
	local function default_predicate(a, b)
		return a < b
	end

	local function quicksort(arr, left, right, compare)
		if left >= right then
			return
		end

		local pivot_idx = math.floor((left + right) / 2)
		local pivot = arr[pivot_idx]

		arr[pivot_idx], arr[right] = arr[right], arr[pivot_idx]

		local partition = left
		for i = left, right - 1 do
			if compare(arr[i], pivot) then
				arr[i], arr[partition] = arr[partition], arr[i]
				partition = partition + 1
			end
		end

		arr[right], arr[partition] = arr[partition], arr[right]

		quicksort(arr, left, partition - 1, compare)
		quicksort(arr, partition + 1, right, compare)
	end

	local result = Array(table.unpack(self.items))

	quicksort(result.items, 1, result:length(), predicate or default_predicate)
	return result
end

function Array:sort_()
	self.items = self:sort().items
	return self
end

function Array:intersection(other)
	local result = Array()
	self:each(function(v)
		if other:include(v) then
			result:push(v)
		end
	end)
	return result
end

function Array:union(other)
	local result = Array(table.unpack(self.items))

	other:each(function(v)
		if not result:include(v) then
			result:push(v)
		end
	end)

	return result
end

function Array:difference(other)
	local result = Array()

	self:each(function(v)
		if not other:include(v) then
			result:push(v)
		end
	end)

	return result
end

function Array:slice(start_idx, end_idx)
	local result = Array()
	for i = start_idx, end_idx do
		result:push(self[i])
	end
	return result
end

function Array:take(n)
	local result = Array()
	for i = 1, n do
		result:push(self[i])
	end
	return result
end

function Array:drop(n)
	local result = Array()
	for i = n + 1, #self do
		result:push(self[i])
	end
	return result
end

function Array:chunk(predicate)
	if type(predicate) == "number" then
		return self / predicate
	end

	local result = Array()
	local current_chunk = Array()

	self:each(function(v)
		if current_chunk:empty() then
			current_chunk:push(v)
			return
		end

		local should_group = predicate(current_chunk:last(), v)

		if should_group then
			current_chunk:push(v)
		else
			result:push(current_chunk)
			current_chunk = Array(v)
		end
	end)

	if not current_chunk:empty() then
		result:push(current_chunk)
	end

	return result
end

function Array:transpose()
	local columns = #self
	local rows = #self:first()

	self:each(function(row)
		if getmetatable(row) ~= Array then
			error("Can only transpose nested Arrays")
		end
	end)

	local result = Array()
	for i = 1, rows do
		local arr = Array()
		for x = 1, columns do
			arr:push(self[x][i])
		end
		result:push(arr)
	end
	return result
end

function Array:transpose_()
	self.items = self:transpose().items
	return self
end

function Array:zip(...)
	local args = { ... }

	if #args == 0 then
		return self:map(function(v)
			return Array(v)
		end)
	end

	local to_transpose = Array(self, table.unpack(args))

	return to_transpose:transpose()
end

function Array:rand()
	if self:empty() then
		return nil
	end
	return self[math.random(1, self:length())]
end

setmetatable(Array, {
	__call = function(self, ...)
		return Array.new(...)
	end,
})

return Array
