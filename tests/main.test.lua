local LuvyArray = require("main")
local TestRunner = require("tests.test_runner")

local tests = {
	test_constructor = function()
		local arr = LuvyArray(1, 2, 3)
		TestRunner.assert_equal(arr:length(), 3, "Constructor should create array with correct length")
		TestRunner.assert_equal(
			tostring(arr),
			"{1, 2, 3}",
			"Constructor should create array with correct string representation"
		)
	end,

	test_add = function()
		local arr1 = LuvyArray(1, 2, 3)
		local arr2 = LuvyArray(4, 5, 6)
		local result = arr1 + arr2
		TestRunner.assert_equal(tostring(result), "{1, 2, 3, 4, 5, 6}", "Addition should concatenate arrays")
	end,

	test_subtract = function()
		local arr1 = LuvyArray(1, 2, 3, 4, 5)
		local arr2 = LuvyArray(2, 4)
		local result = arr1 - arr2
		TestRunner.assert_equal(
			tostring(result),
			"{1, 3, 5}",
			"Subtraction should remove elements present in second array"
		)
	end,

	test_equality = function()
		local arr1 = LuvyArray(1, 2, 3)
		local arr2 = LuvyArray(1, 2, 3)
		local arr3 = LuvyArray(1, 2, 3, 4)
		TestRunner.assert_true(arr1 == arr2, "equality should return true for equal arrays")
		TestRunner.assert_false(arr1 == arr3, "equality should return false for inequal arrays")
	end,

	test_multiply = function()
		local arr = LuvyArray(1, 2, 3)
		local result = arr * 2
		TestRunner.assert_equal(tostring(result), "{1, 2, 3, 1, 2, 3}", "Multiplication should repeat array")
	end,

	test_divide = function()
		local arr = LuvyArray(1, 2, 3, 4, 5, 6)
		local result = arr / 2
		TestRunner.assert_equal(tostring(result), "{{1, 2}, {3, 4}, {5, 6}}", "Division should chunk array")
	end,

	test_less_than = function()
		local arr1 = LuvyArray(1, 2, 3)
		local arr2 = LuvyArray(1, 2, 3, 4)
		TestRunner.assert_true(arr1 < arr2, "Less than should compare lengths")
	end,

	test_less_equal = function()
		local arr1 = LuvyArray(1, 2, 3)
		local arr2 = LuvyArray(1, 2, 3)
		local arr3 = LuvyArray(1, 2, 3, 4)
		TestRunner.assert_true(arr1 <= arr2, "Less than or equal should work for equal arrays")
		TestRunner.assert_true(arr1 <= arr3, "Less than or equal should work for different length arrays")
	end,

	test_greater_than = function()
		local arr1 = LuvyArray(1, 2, 3, 4)
		local arr2 = LuvyArray(1, 2, 3)
		TestRunner.assert_true(arr1 > arr2, "Greater than should compare lengths")
	end,

	test_greater_equal = function()
		local arr1 = LuvyArray(1, 2, 3)
		local arr2 = LuvyArray(1, 2, 3)
		local arr3 = LuvyArray(1, 2, 3, 4)
		TestRunner.assert_true(arr1 >= arr2, "Greater than or equal should work for equal arrays")
		TestRunner.assert_true(arr3 >= arr1, "Greater than or equal should work for different length arrays")
		TestRunner.assert_false(arr1 >= arr3, "Greater then or equal should return false")
	end,

	test_unary_minus = function()
		local arr = LuvyArray(1, 2, 3)
		local result = -arr
		TestRunner.assert_equal(tostring(result), "{3, 2, 1}", "Unary minus should reverse array")
	end,

	test_concatenation = function()
		local arr1 = LuvyArray(1, 2, 3)
		local arr2 = LuvyArray(4, 5, 6)
		local result1 = arr1 .. arr2
		TestRunner.assert_equal(tostring(result1), "{1, 2, 3, 4, 5, 6}", "Concatenation with another array")

		local result2 = arr1 .. 4
		TestRunner.assert_equal(tostring(result2), "{1, 2, 3, 4}", "Concatenation with a single element")
	end,

	test_indexing = function()
		local arr = LuvyArray(10, 20, 30, 40)
		TestRunner.assert_equal(arr[1], 10, "Positive indexing should work")
		TestRunner.assert_equal(arr[4], 40, "Positive indexing should work")
		TestRunner.assert_equal(arr[-1], 40, "Negative indexing should work")
		TestRunner.assert_equal(arr[-4], 10, "Negative indexing should work")
	end,

	test_length = function()
		local arr = LuvyArray(10, 20, 30, 40)
		TestRunner.assert_equal(arr:length(), 4, "Should return length")
		TestRunner.assert_equal(#arr, 4, "Works with lua length operator")
	end,

	test_push_pop = function()
		local arr = LuvyArray(1, 2, 3)
		arr:push(4)
		TestRunner.assert_equal(arr:length(), 4, "Push should increase array length")
		TestRunner.assert_equal(arr[4], 4, "Push should add element to the end")

		local popped = arr:pop()
		TestRunner.assert_equal(popped, 4, "Pop should return last element")
		TestRunner.assert_equal(arr:length(), 3, "Pop should decrease array length")
	end,

	test_shift_unshift = function()
		local arr = LuvyArray(1, 2, 3)
		arr:unshift(0)
		TestRunner.assert_equal(arr[1], 0, "Unshift should add element to the beginning")
		TestRunner.assert_equal(arr:length(), 4, "Unshift should increase array length")

		local shifted = arr:shift()
		TestRunner.assert_equal(shifted, 0, "Shift should remove first element")
		TestRunner.assert_equal(arr:length(), 3, "Shift should decrease array length")
	end,

	test_at_method = function()
		local arr = LuvyArray(10, 20, 30, 40)
		TestRunner.assert_equal(arr:at(1), 10, "at() with positive index should work")
		TestRunner.assert_equal(arr:at(-1), 40, "at() with negative index should work")
	end,

	test_first_last = function()
		local arr = LuvyArray(10, 20, 30)
		TestRunner.assert_equal(arr:first(), 10, "First should return first element")
		TestRunner.assert_equal(arr:last(), 30, "Last should return last element")
	end,

	test_map = function()
		local arr = LuvyArray(1, 2, 3)
		local doubled = arr:map(function(v)
			return v * 2
		end)
		TestRunner.assert_equal(tostring(doubled), "{2, 4, 6}", "Map should transform elements")
		TestRunner.assert_true(arr ~= doubled, "Map should return a new array")
	end,

	test_map_destructive = function()
		local arr = LuvyArray(1, 2, 3)
		arr:map_(function(v)
			return v * 2
		end)
		TestRunner.assert_equal(tostring(arr), "{2, 4, 6}", "Map_ should modify original array")
	end,

	test_select = function()
		local arr = LuvyArray(1, 2, 3, 4, 5)
		local evens = arr:select(function(v)
			return v % 2 == 0
		end)
		TestRunner.assert_equal(tostring(evens), "{2, 4}", "Select should filter elements")
		TestRunner.assert_true(arr ~= evens, "Select should return a new array")
	end,

	test_select_destructive = function()
		local arr = LuvyArray(1, 2, 3, 4, 5)
		arr:select_(function(v)
			return v % 2 == 0
		end)
		TestRunner.assert_equal(tostring(arr), "{2, 4}", "Select_ should modify original array")
	end,

	test_reject = function()
		local arr = LuvyArray(1, 2, 3, 4, 5)
		local odds = arr:reject(function(v)
			return v % 2 == 0
		end)
		TestRunner.assert_equal(tostring(odds), "{1, 3, 5}", "Reject should filter out elements")
		TestRunner.assert_true(arr ~= odds, "Reject should return a new array")
	end,

	test_reject_destructive = function()
		local arr = LuvyArray(1, 2, 3, 4, 5)
		arr:reject_(function(v)
			return v % 2 == 0
		end)
		TestRunner.assert_equal(tostring(arr), "{1, 3, 5}", "Reject_ should modify original array")
	end,

	test_reduce = function()
		local arr = LuvyArray(1, 2, 3, 4)
		local sum = arr:reduce(0, function(acc, v)
			return acc + v
		end)
		TestRunner.assert_equal(sum, 10, "Reduce should accumulate values")
	end,

	test_join = function()
		local arr = LuvyArray("a", "b", "c")
		TestRunner.assert_equal(arr:join(","), "a,b,c", "Join with comma")
		TestRunner.assert_equal(arr:join(" "), "a b c", "Join with space")
	end,

	test_include = function()
		local arr = LuvyArray(1, 2, 3)
		TestRunner.assert_true(arr:include(2), "Include should return true for existing element")
		TestRunner.assert_false(arr:include(4), "Include should return false for non-existing element")
	end,

	test_clear = function()
		local arr = LuvyArray(1, 2, 3)
		arr:clear()
		TestRunner.assert_equal(arr:length(), 0, "Clear should remove all elements")
	end,

	test_empty = function()
		local arr1 = LuvyArray()
		local arr2 = LuvyArray(1, 2, 3)

		TestRunner.assert_true(arr1:empty(), "Empty should return true for empty array")
		TestRunner.assert_false(arr2:empty(), "Empty should return false for non-empty array")
	end,

	test_all = function()
		local arr1 = LuvyArray(2, 4, 6)
		local arr2 = LuvyArray(1, 2, 3)

		TestRunner.assert_true(
			arr1:all(function(v)
				return v % 2 == 0
			end),
			"All should return true when all elements match"
		)
		TestRunner.assert_false(
			arr2:all(function(v)
				return v % 2 == 0
			end),
			"All should return false when not all elements match"
		)
	end,

	test_any = function()
		local arr1 = LuvyArray(1, 3, 5)
		local arr2 = LuvyArray(1, 2, 3)

		TestRunner.assert_false(
			arr1:any(function(v)
				return v % 2 == 0
			end),
			"Any should return false when no elements match"
		)
		TestRunner.assert_true(
			arr2:any(function(v)
				return v % 2 == 0
			end),
			"Any should return true when some elements match"
		)
	end,

	test_index_of = function()
		local arr = LuvyArray(10, 20, 30, 20)
		TestRunner.assert_equal(arr:index_of(20), 2, "index_of should return first occurrence")
		TestRunner.assert_nil(arr:index_of(40), "index_of should return nil for non-existing element")
	end,

	test_count = function()
		local arr = LuvyArray(1, 2, 2, 3, 2)
		TestRunner.assert_equal(arr:count(), 5, "Count should return total number of elements")
		TestRunner.assert_equal(
			arr:count(function(v)
				return v == 2
			end),
			3,
			"Count should return number of elements matching predicate"
		)
	end,

	test_compact = function()
		local arr = LuvyArray(1, nil, 2, nil, 3)
		local compacted = arr:compact()
		TestRunner.assert_equal(tostring(compacted), "{1, 2, 3}", "Compact should remove nil values")
		TestRunner.assert_true(arr ~= compacted, "Compact should return a new array")
	end,

	test_compact_destructive = function()
		local arr = LuvyArray(1, nil, 2, nil, 3)
		arr:compact_()
		TestRunner.assert_equal(tostring(arr), "{1, 2, 3}", "Compact_ should modify original array")
	end,

	test_uniq = function()
		local arr = LuvyArray(1, 2, 2, 3, 3, 4)
		local unique = arr:uniq()
		TestRunner.assert_equal(tostring(unique), "{1, 2, 3, 4}", "Uniq should remove duplicate elements")
		TestRunner.assert_true(arr ~= unique, "Uniq should return a new array")
	end,

	test_uniq_destructive = function()
		local arr = LuvyArray(1, 2, 2, 3, 3, 4)
		arr:uniq_()
		TestRunner.assert_equal(
			tostring(arr),
			"{1, 2, 3, 4}",
			"Uniq_ should modify original array by removing duplicates"
		)
	end,

	test_flatten = function()
		local arr = LuvyArray(1, { 2, 3 }, { 4, { 5, 6 } })
		local flattened = arr:flatten()
		TestRunner.assert_equal(
			tostring(flattened),
			"{1, 2, 3, 4, 5, 6}",
			"Flatten should remove nested array structures"
		)
		TestRunner.assert_true(arr ~= flattened, "Flatten should return a new array")
	end,

	test_flatten_destructive = function()
		local arr = LuvyArray(1, { 2, 3 }, { 4, { 5, 6 } })
		arr:flatten_()
		TestRunner.assert_equal(
			tostring(arr),
			"{1, 2, 3, 4, 5, 6}",
			"Flatten_ should modify original array by removing nested structures"
		)
	end,

	test_reverse = function()
		local arr = LuvyArray(1, 2, 3, 4)
		local reversed = arr:reverse()
		TestRunner.assert_equal(tostring(reversed), "{4, 3, 2, 1}", "Reverse should return elements in opposite order")
		TestRunner.assert_true(arr ~= reversed, "Reverse should return a new array")
	end,

	test_reverse_destructive = function()
		local arr = LuvyArray(1, 2, 3, 4)
		arr:reverse_()
		TestRunner.assert_equal(tostring(arr), "{4, 3, 2, 1}", "Reverse_ should modify original array")
	end,

	test_sort = function()
		local arr = LuvyArray(3, 1, 4, 2)
		local sorted = arr:sort()
		TestRunner.assert_equal(
			tostring(sorted),
			"{1, 2, 3, 4}",
			"Sort should order elements in ascending order by default"
		)
		TestRunner.assert_true(arr ~= sorted, "Sort should return a new array")
	end,

	test_sort_with_comparison = function()
		local arr = LuvyArray(3, 1, 4, 2)
		local sorted = arr:sort(function(a, b)
			return a > b
		end)
		TestRunner.assert_equal(tostring(sorted), "{4, 3, 2, 1}", "Sort should use custom comparison function")
	end,

	test_sort_destructive = function()
		local arr = LuvyArray(3, 1, 4, 2)
		arr:sort_()
		TestRunner.assert_equal(tostring(arr), "{1, 2, 3, 4}", "Sort_ should modify original array")
	end,

	test_intersection = function()
		local arr1 = LuvyArray(1, 2, 3, 4)
		local arr2 = LuvyArray(3, 4, 5, 6)
		local intersection = arr1:intersection(arr2)
		TestRunner.assert_equal(tostring(intersection), "{3, 4}", "Intersection should return common elements")
	end,

	test_union = function()
		local arr1 = LuvyArray(1, 2, 3)
		local arr2 = LuvyArray(3, 4, 5)
		local union = arr1:union(arr2)
		TestRunner.assert_equal(
			tostring(union),
			"{1, 2, 3, 4, 5}",
			"Union should combine unique elements from both arrays"
		)
	end,

	test_difference = function()
		local arr1 = LuvyArray(1, 2, 3, 4)
		local arr2 = LuvyArray(3, 4, 5, 6)
		local difference = arr1:difference(arr2)
		TestRunner.assert_equal(
			tostring(difference),
			"{1, 2}",
			"Difference should return elements in first array not in second"
		)
	end,

	test_slice = function()
		local arr = LuvyArray(1, 2, 3, 4, 5)
		local sliced = arr:slice(2, 4)
		TestRunner.assert_equal(tostring(sliced), "{2, 3, 4}", "Slice should return elements in specified range")
	end,

	test_take = function()
		local arr = LuvyArray(1, 2, 3, 4, 5)
		local taken = arr:take(3)
		TestRunner.assert_equal(tostring(taken), "{1, 2, 3}", "Take should return first n elements")
	end,

	test_drop = function()
		local arr = LuvyArray(1, 2, 3, 4, 5)
		local dropped = arr:drop(2)
		TestRunner.assert_equal(tostring(dropped), "{3, 4, 5}", "Drop should skip first n elements")
	end,

	test_chunk = function()
		local arr = LuvyArray(1, 2, 3, 4, 5, 6)
		local chunked = arr:chunk(2)
		TestRunner.assert_equal(
			tostring(chunked),
			"{{1, 2}, {3, 4}, {5, 6}}",
			"Chunk should group elements into fixed-size groups"
		)
	end,

	test_transpose = function()
		local arr = LuvyArray({ 1, 2, 3 }, { 4, 5, 6 })
		local transposed = arr:transpose()
		TestRunner.assert_equal(
			tostring(transposed),
			"{{1, 4}, {2, 5}, {3, 6}}",
			"Transpose should convert rows to columns"
		)
	end,

	test_transpose_destructive = function()
		local arr = LuvyArray({ 1, 2, 3 }, { 4, 5, 6 })
		arr:transpose_()
		TestRunner.assert_equal(tostring(arr), "{{1, 4}, {2, 5}, {3, 6}}", "Transpose_ should modify original array")
	end,
}

return TestRunner.run_tests(tests)
