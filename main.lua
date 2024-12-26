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

function LuvyArray:__index(key)
	if type(key) == "number" then
		if key < 0 then
			key = #self.items + key + 1
		end
		return self.items[key]
	else
		return LuvyArray[key] -- This handles method lookup
	end
end

function LuvyArray:__newindex(key, value)
	if type(key) == "number" then
		self.items[key] = value
	else
		error("LuvyArray indices must be numbers, got: " .. type(key))
	end
end

function LuvyArray:__eq(arr2)
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

function LuvyArray:__add(other)
	local result = LuvyArray()
	for _, v in ipairs(self.items) do
		result:push(v)
	end
	for _, v in ipairs(other.items) do
		result:push(v)
	end
	return result
end

function LuvyArray:__sub(other)
	return self:reject(function(x)
		return other:include(x)
	end)
end

function LuvyArray:__mul(n)
	if type(n) == "number" then
		local result = LuvyArray()
		for _ = 1, n do
			for _, v in ipairs(self.items) do
				result:push(v)
			end
		end
		return result
	end
	error("Can only multiply array by a number")
end

function LuvyArray:__div(n)
	if type(n) == "number" then
		local result = LuvyArray()
		local currentChunk = LuvyArray()
		for _, v in ipairs(self.items) do
			currentChunk:push(v)
			if currentChunk:length() == n then
				result:push(currentChunk)
				currentChunk = LuvyArray()
			end
		end
		if currentChunk:length() > 0 then
			result:push(currentChunk)
		end
		return result
	end
	error("Can only divide array by a number")
end

function LuvyArray:__lt(other)
	return self:length() < other:length()
end

function LuvyArray:__le(other)
	return self:length() <= other:length()
end

function LuvyArray:__gt(other)
	return self:length() > other:length()
end

function LuvyArray:__ge(other)
	return self:length() >= other:length()
end

function LuvyArray:__unm()
	return self:reverse()
end

function LuvyArray:__concat(other)
	local result = LuvyArray()
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

function LuvyArray:__len()
	return self:length()
end

function LuvyArray:push(item)
	table.insert(self.items, item)
	return self
end

function LuvyArray:pop()
	return table.remove(self.items), self
end

function LuvyArray:shift()
	return table.remove(self.items, 1), self
end

function LuvyArray:unshift(item)
	table.insert(self.items, 1, item)
	return self
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
	local result = LuvyArray()
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
	local result = LuvyArray()
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
	local result = LuvyArray()
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

function LuvyArray:reduce(accumulator, predicate)
	self:each(function(v)
		accumulator = predicate(accumulator, v)
	end)
	return accumulator
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

function LuvyArray:uniq()
	local result = LuvyArray()
	self:each(function(v)
		if not result:include(v) then
			result:push(v)
		end
	end)
	return result
end

function LuvyArray:uniq_()
	self.items = self:uniq().items
	return self
end

function LuvyArray:flatten()
	local result = LuvyArray()
	self:each(function(v)
		if getmetatable(v) == LuvyArray then
			v:each(function(item)
				result:push(item)
			end)
		else
			result:push(v)
		end
	end)
	return result
end

function LuvyArray:flatten_()
	self.items = self:flatten().items
	return self
end

function LuvyArray:deep_flatten()
	local result = LuvyArray()
	self:each(function(v)
		if getmetatable(v) == LuvyArray then
			v:deep_flatten():each(function(item)
				result:push(item)
			end)
		else
			result:push(v)
		end
	end)
	return result
end

function LuvyArray:deep_flatten_()
	self.items = self:deep_flatten().items
	return self
end

function LuvyArray:reverse()
	local result = LuvyArray()
	self:each(function(v)
		result:unshift(v)
	end)
	return result
end

function LuvyArray:reverse_()
	self.items = self:reverse().items
	return self
end

function LuvyArray:sort(predicate)
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

	local result = LuvyArray(table.unpack(self.items))

	quicksort(result.items, 1, result:length(), predicate or default_predicate)
	return result
end

function LuvyArray:sort_()
	self.items = self:sort().items
	return self
end

function LuvyArray:intersection(other)
	local result = LuvyArray()
	self:each(function(v)
		if other:include(v) then
			result:push(v)
		end
	end)
	return result
end

function LuvyArray:union(other)
	local result = LuvyArray(table.unpack(self.items))

	other:each(function(v)
		if not result:include(v) then
			result:push(v)
		end
	end)

	return result
end

function LuvyArray:difference(other)
	local result = LuvyArray()

	self:each(function(v)
		if not other:include(v) then
			result:push(v)
		end
	end)

	return result
end

function LuvyArray:slice(start_idx, end_idx)
	local result = LuvyArray()
	for i = start_idx, end_idx do
		result:push(self[i])
	end
	return result
end

function LuvyArray:take(n)
	local result = LuvyArray()
	for i = 1, n do
		result:push(self[i])
	end
	return result
end

function LuvyArray:drop(n)
	local result = LuvyArray()
	for i = n + 1, #self do
		result:push(self[i])
	end
	return result
end

function LuvyArray:chunk(predicate)
	if type(predicate) == "number" then
		return self / predicate
	end

	local result = LuvyArray()
	local current_chunk = LuvyArray()

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
			current_chunk = LuvyArray(v)
		end
	end)

	if not current_chunk:empty() then
		result:push(current_chunk)
	end

	return result
end

function LuvyArray:transpose()
	local columns = #self
	local rows = #self:first()

	self:each(function(row)
		if getmetatable(row) ~= LuvyArray then
			error("Can only transpose nested LuvyArrays")
		end
	end)

	local result = LuvyArray()
	for i = 1, rows do
		local arr = LuvyArray()
		for x = 1, columns do
			arr:push(self[x][i])
		end
		result:push(arr)
	end
	return result
end

function LuvyArray:transpose_()
	self.items = self:transpose().items
	return self
end

function LuvyArray:zip(...)
	local args = { ... }

	if #args == 0 then
		return self:map(function(v)
			return LuvyArray(v)
		end)
	end

	local to_transpose = LuvyArray(self, table.unpack(args))

	return to_transpose:transpose()
end

setmetatable(LuvyArray, {
	__call = function(self, ...)
		return LuvyArray.new(...)
	end,
})

return LuvyArray
