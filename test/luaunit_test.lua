
local unit = require 'luaunit'

local function test_assert_equals()
	local actual, expected = 'abc', 'abc'
	unit:assert_equals(actual, expected)
end

local function main()
	local test_cases = {
		test_assert_equals = test_assert_equals,
	}
	unit:run_test(test_cases)
	unit:print_result()
end

main()

