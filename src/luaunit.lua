
local _M = { _VERSION = '0.1' }

local test_result = {}

function _M:assert_equals(actual, expected)
	if type(actual) ~= type(expected) then return false end

	if type(actual) == 'table' and type(expected) == 'table' then
		if not self:assert_table_equals(actual, expected) then
			return false
		end
	elseif actual ~= expected then
		return false
	end
	
	return true
end

function _M:assert_not_equals(actual, expected)
	if type(actual) ~= type(expected) then return false end
	
	if type(actual) == 'table' and type(expected) == 'table' then
		if self:assert_table_equals(actual, expected) then
			return false
		end
	elseif actual == expected then
		return false
	end
	
	return true
end

function _M:assert_true(value)
	if value ~= nil and value == true then
		return true
	end
	return false
end

function _M:assert_false(value)
	if value ~= nil and value == false then
		return true
	end
	return false
end

function _M:assert_greater_than(actual, expected)
	if type(actual) ~= type(expected) then return false end
	
	actual, expected = tonumber(actual), tonumber(expected)
	if actual and expected then
		return actual > expected
	else
		return false
	end
end

function _M:assert_less_than(actual, expected)
	if type(actual) ~= type(expected) then return false end
	
	actual, expected = tonumber(actual), tonumber(expected)
	if actual and expected then
		return actual < expected
	else
		return false
	end
end

function _M:assert_table_equals(actual, expected)
	if type(actual) ~= type(expected) then return false end
	
	if type(actual) == 'table' and type(expected) == 'table' then
		for k, v in ipairs(actual) do
			local v1 = expected[k]
			if not v1 or v ~= v1 then
				return false
			end
		end
	else
		return false
	end
	return true
end

function _M:assert_is_nil(value)
	return (value == nil)
end

function _M:assert_is_not_nil(value)
	return (value ~= nil)
end

function _M:assert_in(table, key)
	if not table or not key then return false end
	if type(actual) == 'table' then
		for _, k in pairs(table) do
			if k == key then
				return true
			end
		end
		
		for k, _ in ipairs(table) do
			if k == key then
				return true
			end
		end
	end
	return false
end

function _M:assert_not_in(table, key)
	if not table or not key then return false end
	if type(actual) == 'table' then
		for _, k in pairs(table) do
			if k == key then
				return false
			end
		end
		
		for k, _ in ipairs(table) do
			if k == key then
				return false
			end
		end
	end
	return true
end

function _M:run_test(test_cases)
	if test_cases and type(test_cases) == 'table' then
		for fun_name, test_case in pairs(test_cases) do
			if string.find(fun_name, 'test') == 1 then
				local result = test_case()
				test_result[fun_name] = result
			end
		end
	end
end

function _M:print_result()
	for name, result in pairs(test_result) do
		print(string.format('%s : %s', name, tostring(result)))
	end
end

return _M
