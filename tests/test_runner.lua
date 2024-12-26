TestRunner = {}
local colors = {
	green = "\27[32m",
	red = "\27[31m",
	reset = "\27[0m",
}

local assert_counts = {
	total = 0,
	passed = 0,
	failed = 0,
}

local function increment_assert(success)
	assert_counts.total = assert_counts.total + 1
	if success then
		assert_counts.passed = assert_counts.passed + 1
	else
		assert_counts.failed = assert_counts.failed + 1
	end
end

function TestRunner.assert_equal(actual, expected, message)
	local success = actual == expected
	increment_assert(success)
	if not success then
		error(
			string.format(
				"%sASSERTION FAILED%s: %s\nExpected %s, got %s",
				colors.red,
				colors.reset,
				message or "Values are not equal",
				tostring(expected),
				tostring(actual)
			),
			2
		)
	end
end

function TestRunner.assert_true(condition, message)
	local success = condition == true
	increment_assert(success)
	if not success then
		error(
			string.format("%sASSERTION FAILED%s: %s", colors.red, colors.reset, message or "Condition is not true"),
			2
		)
	end
end

function TestRunner.assert_false(condition, message)
	local success = condition == false
	increment_assert(success)
	if not condition == false then
		error(
			string.format("%sASSERTION FAILED%s: %s", colors.red, colors.reset, message or "Condition is not false"),
			2
		)
	end
end

function TestRunner.assert_nil(value, message)
	local success = value == nil
	increment_assert(success)
	if not success then
		error(
			string.format(
				"%sASSERTION FAILED%s: %s\nExpected nil, got %s",
				colors.red,
				colors.reset,
				message or "Value is not nil",
				tostring(value)
			),
			2
		)
	end
end

function TestRunner.assert_not_nil(value, message)
	local success = value ~= nil
	increment_assert(success)
	if not success then
		error(string.format("%sASSERTION FAILED%s: %s", colors.red, colors.reset, message or "Value is nil"), 2)
	end
end

function TestRunner.run_tests(tests)
	assert_counts.total = 0
	assert_counts.passed = 0
	assert_counts.failed = 0

	local passed = 0
	local failed = 0
	local start_time = os.time()
	print("Starting test suite...")
	for name, test_func in pairs(tests) do
		local status, err = pcall(test_func)
		if status then
			passed = passed + 1
			print(string.format("%s[PASS]%s %s", colors.green, colors.reset, name))
		else
			failed = failed + 1
			print(string.format("%s[FAIL]%s %s\n%s", colors.red, colors.reset, name, err))
		end
	end
	local end_time = os.time()
	local duration = end_time - start_time

	print(string.format("\nTest Summary:"))
	print(string.format("========================="))
	print(string.format("Total tests: %d", passed + failed))
	print(string.format("Total assertions: %d", assert_counts.total))
	print(string.format("%sPassing tests: %d%s", colors.green, passed, colors.reset))
	print(string.format("%sPassing assertions: %d%s", colors.green, assert_counts.passed, colors.reset))

	if failed > 0 or assert_counts.failed > 0 then
		print(string.format("%sFailing tests: %d%s", colors.red, failed, colors.reset))
		print(string.format("%sFailing assertions: %d%s", colors.red, assert_counts.failed, colors.reset))
	end

	print(string.format("Duration: %d seconds", duration))

	-- Exit with failure if any tests failed
	if failed > 0 then
		os.exit(1)
	end

	return true
end

return TestRunner
