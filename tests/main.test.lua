local LuvyArray = require("main")
local TestRunner = require("tests.test_runner")

local tests = {
	test_constructor = function()
		local arr = LuvyArray(1, 2, 3)
		TestRunner.assert_equal(arr:length(), 3, "Constructor should initialize array with exactly 3 elements")
		TestRunner.assert_equal(
			tostring(arr),
			"{1, 2, 3}",
			"Constructor should format array as {1, 2, 3} when converted to string"
		)
	end,

	test_add = function()
		local arr1 = LuvyArray(1, 2, 3)
		local arr2 = LuvyArray(4, 5, 6)
		local result = arr1 + arr2
		TestRunner.assert_equal(
			tostring(result),
			"{1, 2, 3, 4, 5, 6}",
			"Adding arrays [1,2,3] + [4,5,6] should concatenate into [1,2,3,4,5,6]"
		)
	end,

	test_subtract = function()
		local arr1 = LuvyArray(1, 2, 3, 4, 5)
		local arr2 = LuvyArray(2, 4)
		local result = arr1 - arr2
		TestRunner.assert_equal(
			tostring(result),
			"{1, 3, 5}",
			"Subtracting [2,4] from [1,2,3,4,5] should remove matching elements leaving [1,3,5]"
		)
	end,

	test_equality = function()
		local arr1 = LuvyArray(1, 2, 3)
		local arr2 = LuvyArray(1, 2, 3)
		local arr3 = LuvyArray(1, 2, 3, 4)
		TestRunner.assert_true(arr1 == arr2, "Arrays with identical elements [1,2,3] should be considered equal")
		TestRunner.assert_false(
			arr1 == arr3,
			"Arrays [1,2,3] and [1,2,3,4] should not be considered equal due to different lengths"
		)
	end,

	test_multiply = function()
		local arr = LuvyArray(1, 2, 3)
		local result = arr * 2
		TestRunner.assert_equal(
			tostring(result),
			"{1, 2, 3, 1, 2, 3}",
			"Multiplying array [1,2,3] by 2 should duplicate the entire sequence"
		)
	end,

	test_divide = function()
		local arr = LuvyArray(1, 2, 3, 4, 5, 6)
		local result = arr / 2
		TestRunner.assert_equal(
			tostring(result),
			"{{1, 2}, {3, 4}, {5, 6}}",
			"Dividing [1,2,3,4,5,6] by 2 should create chunks of size 2"
		)
	end,

	test_less_than = function()
		local arr1 = LuvyArray(1, 2, 3)
		local arr2 = LuvyArray(1, 2, 3, 4)
		TestRunner.assert_true(arr1 < arr2, "Array of length 3 should be considered less than array of length 4")
	end,

	test_less_equal = function()
		local arr1 = LuvyArray(1, 2, 3)
		local arr2 = LuvyArray(1, 2, 3)
		local arr3 = LuvyArray(1, 2, 3, 4)
		TestRunner.assert_true(arr1 <= arr2, "Arrays of equal length 3 should satisfy less than or equal")
		TestRunner.assert_true(arr1 <= arr3, "Array of length 3 should be less than or equal to array of length 4")
	end,

	test_greater_than = function()
		local arr1 = LuvyArray(1, 2, 3, 4)
		local arr2 = LuvyArray(1, 2, 3)
		TestRunner.assert_true(arr1 > arr2, "Array of length 4 should be considered greater than array of length 3")
	end,

	test_greater_equal = function()
		local arr1 = LuvyArray(1, 2, 3)
		local arr2 = LuvyArray(1, 2, 3)
		local arr3 = LuvyArray(1, 2, 3, 4)
		TestRunner.assert_true(arr1 >= arr2, "Arrays of equal length 3 should satisfy greater than or equal")
		TestRunner.assert_true(arr3 >= arr1, "Array of length 4 should be greater than or equal to array of length 3")
		TestRunner.assert_false(
			arr1 >= arr3,
			"Array of length 3 should not be greater than or equal to array of length 4"
		)
	end,

	test_unary_minus = function()
		local arr = LuvyArray(1, 2, 3)
		local result = -arr
		TestRunner.assert_equal(
			tostring(result),
			"{3, 2, 1}",
			"Unary minus should reverse array order from [1,2,3] to [3,2,1]"
		)
	end,

	test_concatenation = function()
		local arr1 = LuvyArray(1, 2, 3)
		local arr2 = LuvyArray(4, 5, 6)
		local result1 = arr1 .. arr2
		TestRunner.assert_equal(
			tostring(result1),
			"{1, 2, 3, 4, 5, 6}",
			"Concatenating arrays [1,2,3] and [4,5,6] should join all elements"
		)

		local result2 = arr1 .. 4
		TestRunner.assert_equal(
			tostring(result2),
			"{1, 2, 3, 4}",
			"Concatenating array [1,2,3] with single value 4 should append the value"
		)
	end,

	test_indexing = function()
		local arr = LuvyArray(10, 20, 30, 40)
		TestRunner.assert_equal(arr[1], 10, "Positive index [1] should return first element (10)")
		TestRunner.assert_equal(arr[4], 40, "Positive index [4] should return last element (40)")
		TestRunner.assert_equal(arr[-1], 40, "Negative index [-1] should return last element (40)")
		TestRunner.assert_equal(arr[-4], 10, "Negative index [-4] should return first element (10)")
	end,

	test_length = function()
		local arr = LuvyArray(10, 20, 30, 40)
		TestRunner.assert_equal(arr:length(), 4, "Length method should return correct count of elements (4)")
		TestRunner.assert_equal(#arr, 4, "Lua length operator (#) should return correct count of elements (4)")
	end,

	test_push_pop = function()
		local arr = LuvyArray(1, 2, 3)
		arr:push(4)
		TestRunner.assert_equal(arr:length(), 4, "Push should increase array length from 3 to 4")
		TestRunner.assert_equal(arr[4], 4, "Push(4) should add element 4 at the end of array")

		local popped = arr:pop()
		TestRunner.assert_equal(popped, 4, "Pop should return the last element (4)")
		TestRunner.assert_equal(arr:length(), 3, "Pop should decrease array length from 4 to 3")
	end,

	test_shift_unshift = function()
		local arr = LuvyArray(1, 2, 3)
		arr:unshift(0)
		TestRunner.assert_equal(arr[1], 0, "Unshift(0) should add element 0 at the beginning")
		TestRunner.assert_equal(arr:length(), 4, "Unshift should increase array length from 3 to 4")

		local shifted = arr:shift()
		TestRunner.assert_equal(shifted, 0, "Shift should return the first element (0)")
		TestRunner.assert_equal(arr:length(), 3, "Shift should decrease array length from 4 to 3")
	end,

	test_at_method = function()
		local arr = LuvyArray(10, 20, 30, 40)
		TestRunner.assert_equal(arr:at(1), 10, "at(1) should return first element (10)")
		TestRunner.assert_equal(arr:at(-1), 40, "at(-1) should return last element (40)")
	end,

	test_first_last = function()
		local arr = LuvyArray(10, 20, 30)
		TestRunner.assert_equal(arr:first(), 10, "first() should return the first element (10)")
		TestRunner.assert_equal(arr:last(), 30, "last() should return the last element (30)")
	end,

	test_map = function()
		local arr = LuvyArray(1, 2, 3)
		local doubled = arr:map(function(v)
			return v * 2
		end)
		TestRunner.assert_equal(tostring(doubled), "{2, 4, 6}", "map(double) should transform [1,2,3] to [2,4,6]")
		TestRunner.assert_true(arr ~= doubled, "map should return a new array instance, not modify original")
	end,

	test_map_destructive = function()
		local arr = LuvyArray(1, 2, 3)
		arr:map_(function(v)
			return v * 2
		end)
		TestRunner.assert_equal(
			tostring(arr),
			"{2, 4, 6}",
			"map_(double) should modify original array from [1,2,3] to [2,4,6]"
		)
	end,

	test_select = function()
		local arr = LuvyArray(1, 2, 3, 4, 5)
		local evens = arr:select(function(v)
			return v % 2 == 0
		end)
		TestRunner.assert_equal(
			tostring(evens),
			"{2, 4}",
			"select(even) should filter [1,2,3,4,5] to only even numbers [2,4]"
		)
		TestRunner.assert_true(arr ~= evens, "select should return a new array instance, not modify original")
	end,

	test_select_destructive = function()
		local arr = LuvyArray(1, 2, 3, 4, 5)
		arr:select_(function(v)
			return v % 2 == 0
		end)
		TestRunner.assert_equal(
			tostring(arr),
			"{2, 4}",
			"select_(even) should modify original array to contain only even numbers [2,4]"
		)
	end,

	test_reject = function()
		local arr = LuvyArray(1, 2, 3, 4, 5)
		local odds = arr:reject(function(v)
			return v % 2 == 0
		end)
		TestRunner.assert_equal(
			tostring(odds),
			"{1, 3, 5}",
			"reject(even) should filter out even numbers from [1,2,3,4,5] leaving [1,3,5]"
		)
		TestRunner.assert_true(arr ~= odds, "reject should return a new array instance, not modify original")
	end,

	test_reject_destructive = function()
		local arr = LuvyArray(1, 2, 3, 4, 5)
		arr:reject_(function(v)
			return v % 2 == 0
		end)
		TestRunner.assert_equal(
			tostring(arr),
			"{1, 3, 5}",
			"reject_(even) should modify original array to remove even numbers, leaving [1,3,5]"
		)
	end,

	test_reduce = function()
		local arr = LuvyArray(1, 2, 3, 4)
		local sum = arr:reduce(0, function(acc, v)
			return acc + v
		end)
		TestRunner.assert_equal(sum, 10, "reduce(sum) of [1,2,3,4] with initial value 0 should total 10")
	end,

	test_join = function()
		local arr = LuvyArray("a", "b", "c")
		TestRunner.assert_equal(arr:join(","), "a,b,c", "join(',') should concatenate elements with comma separator")
		TestRunner.assert_equal(arr:join(" "), "a b c", "join(' ') should concatenate elements with space separator")
	end,

	test_include = function()
		local arr = LuvyArray(1, 2, 3)
		TestRunner.assert_true(arr:include(2), "include(2) should return true for element present in array")
		TestRunner.assert_false(arr:include(4), "include(4) should return false for element not in array")
	end,

	test_clear = function()
		local arr = LuvyArray(1, 2, 3)
		arr:clear()
		TestRunner.assert_equal(arr:length(), 0, "clear() should remove all elements resulting in empty array")
	end,

	test_empty = function()
		local arr1 = LuvyArray()
		local arr2 = LuvyArray(1, 2, 3)

		TestRunner.assert_true(arr1:empty(), "empty() should return true for array with no elements")
		TestRunner.assert_false(arr2:empty(), "empty() should return false for array with elements")
	end,

	test_all = function()
		local arr1 = LuvyArray(2, 4, 6)
		local arr2 = LuvyArray(1, 2, 3)

		TestRunner.assert_true(
			arr1:all(function(v)
				return v % 2 == 0
			end),
			"all(even) should return true when all elements [2,4,6] are even"
		)
		TestRunner.assert_false(
			arr2:all(function(v)
				return v % 2 == 0
			end),
			"all(even) should return false when some elements in [1,2,3] are odd"
		)
	end,

	test_any = function()
		local arr1 = LuvyArray(1, 3, 5)
		local arr2 = LuvyArray(1, 2, 3)

		TestRunner.assert_false(
			arr1:any(function(v)
				return v % 2 == 0
			end),
			"any(even) should return false when no elements in [1,3,5] are even"
		)
		TestRunner.assert_true(
			arr2:any(function(v)
				return v % 2 == 0
			end),
			"any(even) should return true when at least one element in [1,2,3] is even"
		)
	end,

	test_index_of = function()
		local arr = LuvyArray(10, 20, 30, 20)
		TestRunner.assert_equal(arr:index_of(20), 2, "index_of(20) should return first occurrence index (2)")
		TestRunner.assert_nil(arr:index_of(40), "index_of(40) should return nil for non-existent element")
	end,

	test_count = function()
		local arr = LuvyArray(1, 2, 2, 3, 2)
		TestRunner.assert_equal(arr:count(), 5, "count() without predicate should return total number of elements (5)")
		TestRunner.assert_equal(
			arr:count(function(v)
				return v == 2
			end),
			3,
			"count(v == 2) should return number of occurrences of 2 in array (3)"
		)
	end,

	test_uniq = function()
		local arr = LuvyArray(1, 2, 2, 3, 3, 4)
		local unique = arr:uniq()
		TestRunner.assert_equal(
			tostring(unique),
			"{1, 2, 3, 4}",
			"uniq() should remove all duplicate elements from [1,2,2,3,3,4]"
		)
		TestRunner.assert_true(arr ~= unique, "uniq should return a new array instance, not modify original")
	end,

	test_uniq_destructive = function()
		local arr = LuvyArray(1, 2, 2, 3, 3, 4)
		arr:uniq_()
		TestRunner.assert_equal(
			tostring(arr),
			"{1, 2, 3, 4}",
			"uniq_() should modify original array by removing all duplicate elements"
		)
	end,

	test__flatten = function()
		local arr = LuvyArray(1, LuvyArray(2, 3), LuvyArray(4, LuvyArray(5, 6)))
		local flattened = arr:flatten()
		TestRunner.assert_equal(
			tostring(flattened),
			"{1, 2, 3, 4, {5, 6}}",
			"flatten() should recursively flatten nested arrays into a single level"
		)
		TestRunner.assert_true(arr ~= flattened, "flatten should return a new array instance, not modify original")
	end,

	test_flatten_destructive = function()
		local arr = LuvyArray(1, LuvyArray(2, 3), LuvyArray(4, LuvyArray(5, 6)))
		arr:flatten_()
		TestRunner.assert_equal(
			tostring(arr),
			"{1, 2, 3, 4, {5, 6}}",
			"flatten_() should modify original array by recursively flattening nested arrays"
		)
	end,

	test_deep_flatten = function()
		local arr = LuvyArray(1, LuvyArray(2, 3), LuvyArray(4, LuvyArray(5, 6)))
		local flattened = arr:deep_flatten()
		TestRunner.assert_equal(
			tostring(flattened),
			"{1, 2, 3, 4, 5, 6}",
			"flatten() should recursively flatten nested arrays into a single level"
		)
		TestRunner.assert_true(arr ~= flattened, "flatten should return a new array instance, not modify original")
	end,

	test_deep_flatten_destructive = function()
		local arr = LuvyArray(1, LuvyArray(2, 3), LuvyArray(4, LuvyArray(5, 6)))
		arr:deep_flatten_()
		TestRunner.assert_equal(
			tostring(arr),
			"{1, 2, 3, 4, 5, 6}",
			"flatten_() should modify original array by recursively flattening nested arrays"
		)
	end,

	test_reverse = function()
		local arr = LuvyArray(1, 2, 3, 4)
		local reversed = arr:reverse()
		TestRunner.assert_equal(
			tostring(reversed),
			"{4, 3, 2, 1}",
			"reverse() should return new array with elements in reverse order"
		)
		TestRunner.assert_true(arr ~= reversed, "reverse should return a new array instance, not modify original")
	end,

	test_reverse_destructive = function()
		local arr = LuvyArray(1, 2, 3, 4)
		arr:reverse_()
		TestRunner.assert_equal(
			tostring(arr),
			"{4, 3, 2, 1}",
			"reverse_() should modify original array by reversing element order"
		)
	end,

	test_sort = function()
		local arr = LuvyArray(3, 1, 4, 2)
		local sorted = arr:sort()
		TestRunner.assert_equal(
			tostring(sorted),
			"{1, 2, 3, 4}",
			"sort() without predicate should sort elements in ascending order"
		)
		TestRunner.assert_true(arr ~= sorted, "sort should return a new array instance, not modify original")
	end,

	test_sort_with_comparison = function()
		local arr = LuvyArray(3, 1, 4, 2)
		local sorted = arr:sort(function(a, b)
			return a > b
		end)
		TestRunner.assert_equal(
			tostring(sorted),
			"{4, 3, 2, 1}",
			"sort() with descending comparator should sort elements in descending order"
		)
	end,

	test_sort_destructive = function()
		local arr = LuvyArray(3, 1, 4, 2)
		arr:sort_()
		TestRunner.assert_equal(
			tostring(arr),
			"{1, 2, 3, 4}",
			"sort_() should modify original array by sorting elements in ascending order"
		)
	end,

	test_intersection = function()
		local arr1 = LuvyArray(1, 2, 3, 4)
		local arr2 = LuvyArray(3, 4, 5, 6)
		local intersection = arr1:intersection(arr2)
		TestRunner.assert_equal(
			tostring(intersection),
			"{3, 4}",
			"intersection() should return elements common to both arrays"
		)
	end,

	test_union = function()
		local arr1 = LuvyArray(1, 2, 3)
		local arr2 = LuvyArray(3, 4, 5)
		local union = arr1:union(arr2)
		TestRunner.assert_equal(
			tostring(union),
			"{1, 2, 3, 4, 5}",
			"union() should return combined unique elements from both arrays"
		)
	end,

	test_difference = function()
		local arr1 = LuvyArray(1, 2, 3, 4)
		local arr2 = LuvyArray(3, 4, 5, 6)
		local difference = arr1:difference(arr2)
		TestRunner.assert_equal(
			tostring(difference),
			"{1, 2}",
			"difference() should return elements in first array not present in second array"
		)
	end,

	test_slice = function()
		local arr = LuvyArray(1, 2, 3, 4, 5)
		local sliced = arr:slice(2, 4)
		TestRunner.assert_equal(
			tostring(sliced),
			"{2, 3, 4}",
			"slice(2,4) should return elements from index 2 to 4 inclusive"
		)
	end,

	test_take = function()
		local arr = LuvyArray(1, 2, 3, 4, 5)
		local taken = arr:take(3)
		TestRunner.assert_equal(tostring(taken), "{1, 2, 3}", "take(3) should return first 3 elements of array")
	end,

	test_drop = function()
		local arr = LuvyArray(1, 2, 3, 4, 5)
		local dropped = arr:drop(2)
		TestRunner.assert_equal(
			tostring(dropped),
			"{3, 4, 5}",
			"drop(2) should return array with first 2 elements removed"
		)
	end,

	test_chunk = function()
		local arr = LuvyArray(1, 2, 3, 4, 5, 6)
		local chunked = arr:chunk(2)
		TestRunner.assert_equal(
			tostring(chunked),
			"{{1, 2}, {3, 4}, {5, 6}}",
			"chunk(2) should group elements into arrays of size 2"
		)

		local arr2 = LuvyArray(1, 2, 3, 4, 5)
		local chunked2 = arr2:chunk(2)
		TestRunner.assert_equal(
			tostring(chunked2),
			"{{1, 2}, {3, 4}, {5}}",
			"chunk(2) with uneven array should create a smaller last chunk"
		)

		local arr3 = LuvyArray(1, 2, 3)
		local chunked3 = arr3:chunk(5)
		TestRunner.assert_equal(
			tostring(chunked3),
			"{{1, 2, 3}}",
			"chunk(5) on smaller array should return single chunk with all elements"
		)

		local arr4 = LuvyArray(1, 2, 3)
		local chunked4 = arr4:chunk(1)
		TestRunner.assert_equal(tostring(chunked4), "{{1}, {2}, {3}}", "chunk(1) should create single-element chunks")

		local arr5 = LuvyArray(1, 2, 3, 5, 6, 9, 10)
		local chunked5 = arr5:chunk(function(last, current)
			return math.abs(last - current) < 2
		end)
		TestRunner.assert_equal(
			tostring(chunked5),
			"{{1, 2, 3}, {5, 6}, {9, 10}}",
			"predicate-based chunk should group by custom condition"
		)

		local arr6 = LuvyArray()
		local chunked6 = arr6:chunk(2)
		TestRunner.assert_equal(tostring(chunked6), "{}", "chunk on empty array should return empty array")
	end,

	test_transpose = function()
		local arr = LuvyArray(LuvyArray(1, 2, 3), LuvyArray(4, 5, 6))
		local transposed = arr:transpose()
		TestRunner.assert_equal(
			tostring(transposed),
			"{{1, 4}, {2, 5}, {3, 6}}",
			"transpose() should convert rows to columns"
		)
		TestRunner.assert_true(arr ~= transposed, "transpose should return a new array instance, not modify original")
	end,

	test_transpose_destructive = function()
		local arr = LuvyArray(LuvyArray(1, 2, 3), LuvyArray(4, 5, 6))
		arr:transpose_()
		TestRunner.assert_equal(
			tostring(arr),
			"{{1, 4}, {2, 5}, {3, 6}}",
			"transpose_() should modify original array by converting rows to columns"
		)
	end,

	test_zip = function()
		local a = LuvyArray(4, 5, 6)
		local b = LuvyArray(7, 8, 9)
		local zipped = LuvyArray(1, 2, 3):zip(a, b)
		TestRunner.assert_equal(
			tostring(zipped),
			"{{1, 4, 7}, {2, 5, 8}, {3, 6, 9}}",
			"Basic zip with equal length arrays"
		)

		local zipped2 = LuvyArray(1, 2):zip(a, b)
		TestRunner.assert_equal(tostring(zipped2), "{{1, 4, 7}, {2, 5, 8}}", "Zip with shorter initial array")

		local c = LuvyArray(8)
		local zipped3 = a:zip(LuvyArray(1, 2), c)
		TestRunner.assert_equal(tostring(zipped3), "{{4, 1, 8}, {5, 2}, {6}}", "Zip with arrays of different lengths")

		local zipped4 = LuvyArray(1, 2, 3):zip()
		TestRunner.assert_equal(tostring(zipped4), "{{1}, {2}, {3}}", "Zip with no additional arrays")

		local empty1 = LuvyArray()
		local empty2 = LuvyArray()
		local zipped5 = empty1:zip(empty2)
		TestRunner.assert_equal(tostring(zipped5), "{}", "Zip with empty arrays")
	end,

	test_method_chaining = function()
		local arr = LuvyArray(1, 2, 3)
		local result = arr:push(4)
			:push(5)
			:map_(function(x)
				return x * 2
			end)
			:reject_(function(x)
				return x > 6
			end)
			:reverse_()

		TestRunner.assert_equal(tostring(result), "{6, 4, 2}", "Method chaining should work correctly")
		TestRunner.assert_true(arr == result, "Chaining should maintain the same array instance")
	end,

	test_pop_shift_chaining = function()
		local arr = LuvyArray(1, 2, 3, 4)
		local last, chainArr = arr:pop()
		TestRunner.assert_equal(last, 4, "Pop should return the last element")
		TestRunner.assert_true(arr == chainArr, "Pop should return the array for chaining")

		local first, chainArr2 = chainArr:shift()
		TestRunner.assert_equal(first, 1, "Shift should return the first element")
		TestRunner.assert_true(chainArr == chainArr2, "Shift should return the array for chaining")

		chainArr2:push(5):push(6)
		TestRunner.assert_equal(tostring(chainArr2), "{2, 3, 5, 6}", "Chaining should work after pop/shift")
	end,
}

return TestRunner.run_tests(tests)
