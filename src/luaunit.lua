
local _T = {}

local _R = {}

function _T:init()
	_R = {}
end

function _T:assert_equals(actual, expected)
	if type(actual) ~= type(expected) then 
		table.insert(_R, {false, 'expected and actual are not same type'})
		return
	end

	if type(actual) == 'table' and type(expected) == 'table' then
		if not self:assert_table_equals(actual, expected) then
			table.insert(_R, {false, 'expected table and actual table are not equals'})
			return
		end
	elseif actual ~= expected then
		table.insert(_R, {false, string.format('expect %s, but %s', tostring(expected), tostring(actual))})
		return
	end
	
	table.insert(_R, {true, nil})
end

function _T:assert_not_equals(actual, expected)
	if type(actual) ~= type(expected) then 
		table.insert(_R, {false, 'expected and actual are not same type'})
		return
	end
	
	if type(actual) == 'table' and type(expected) == 'table' then
		if self:assert_table_equals(actual, expected) then
			table.insert(_R, {false, 'expected table and actual table are equals'})
			return
		end
	elseif actual == expected then
		table.insert(_R, {false, string.format('expect not %s, but %s', tostring(expected), tostring(actual))})
		return
	end
	
	table.insert(_R, {true, nil})
end

function _T:assert_true(value)
	if value ~= nil and value == true then
		table.insert(_R, {true, nil})
		return
	end
	table.insert(_R, {false, value..' is not true'})
end

function _T:assert_false(value)
	if value ~= nil and value == false then
		table.insert(_R, {true, nil})
		return
	end
	table.insert(_R, {false, value..' is not false'})
end

function _T:assert_greater_than(actual, expected)
	if type(actual) ~= type(expected) then 
		table.insert(_R, {false, 'expected and actual are not same type'}) 
		return
	end
	
	actual, expected = tonumber(actual), tonumber(expected)
	if actual and expected then
		local r = actual > expected
		if r then
			table.insert(_R, {true, nil})
		else
			table.insert(_R, {false, string.format('%s is less than %s', actual, expected)})
		end
	else
		table.insert(_R, {false, 'actual value or expected value is not number'})
	end
	
end

function _T:assert_less_than(actual, expected)
	if type(actual) ~= type(expected) then 
		table.insert(_R, {false, 'expected and actual are not same type'})
		return
	end
	
	actual, expected = tonumber(actual), tonumber(expected)
	if actual and expected then
		local r = actual < expected
		if r then
			table.insert(_R, {true, nil})
		else
			table.insert(_R, {false, string.format('%s is greater than %s', actual, expected)})
		end
	else
		table.insert(_R, {false, 'actual value or expected value is not number'})
	end
end

function _T:assert_table_equals(actual, expected)
	if type(actual) ~= type(expected) then 
		table.insert(_R, {false, 'expected and actual are not same type'})
		return
	end
	
	if type(actual) == 'table' and type(expected) == 'table' then
		for k, v in ipairs(actual) do
			local v1 = expected[k]
			if not v1 or v ~= v1 then
				table.insert(_R, {false, string.format('%s is not equal %s', v, v1)})
				return
			end
		end
	else
		table.insert(_R, {false, 'expected or actual is not table type'})
		return
	end
	
	table.insert(_R, {true, nil})
end

function _T:assert_is_nil(value)
	table.insert(_R, {(value == nil), nil})
end

function _T:assert_is_not_nil(value)
	table.insert(_R, {(value ~= nil), nil})
end

function _T:assert_in(table, key)
	if not table or not key then 
		table.insert(_R, {false, 'table or key is nil'})
		return
	end
	
	if type(actual) == 'table' then
		for _, k in pairs(table) do
			if k == key then
				table.insert(_R, {true, nil})
				return
			end
		end
		
		for k, _ in ipairs(table) do
			if k == key then
				table.insert(_R, {true, nil})
				return
			end
		end
	end
	
	table.insert(_R, {false, key..' is not in table'})
end

function _T:assert_not_in(table, key)
	if not table or not key then 
		table.insert(_R, {false, 'table or key is nil'})
		return
	end
	
	if type(actual) == 'table' then
		for _, k in pairs(table) do
			if k == key then
				table.insert(_R, {false, key..' is in table'})
				return
			end
		end
		
		for k, _ in ipairs(table) do
			if k == key then
				table.insert(_R, {false, key..' is in table'})
				return
			end
		end
	end
	table.insert(_R, {true, nil})
end

function _T:get_result()
	return _R
end

local _M = { _VERSION = '0.1' }

function _M:run_test(test_cases)
	local test_result = {}
	if test_cases and type(test_cases) == 'table' then
		for fun_name, test_case in pairs(test_cases) do
			if string.find(fun_name, 'test') == 1 then
				local test = {}
				setmetatable(test, {__index = _T})
				test:init()
				test_case(test)
				local result = test:get_result()
				test_result[fun_name] = result
			end
		end
	end
	return test_result
end

function _M:print_result(test_result)
	for name, result in pairs(test_result) do

		local pass = true
		for _, msg in pairs(result) do
			if not msg[1] then
				pass = false
			end
		end
		
		if pass then
			print(string.format('%s all pass', name))
		else
			print(string.format('%s fail', name))
			for _, msg in pairs(result) do
				if not msg[1] then
					print('  '..msg[2])
				end
			end
		end
	end
end

return _M
