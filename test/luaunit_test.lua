
local unit = require 'luaunit'

local function test_assert_equals(test)
	local actual, expected = 'abc', 'abc'
	test:assert_equals(actual, expected)
end

local function test_assert_equals2(test)
	local actual, expected = 'abc', 'abcd'
	test:assert_equals(actual, expected)
	
	local actual, expected = 'abce', 'abcd'
	test:assert_equals(actual, expected)
end

local function main()
	local test_cases = {
		test_assert_equals = test_assert_equals,
		test_assert_equals2 = test_assert_equals2,
	}
	local test_result = unit:run_test(test_cases)
	unit:print_result(test_result)
end

main()

