
local _M = { _VERSION = '0.1' }

function _M.assert_equals(actual, expected)
	if type(actual) ~= type(expected) then return false end

	if type(actual) == 'table' and type(expected) == 'table' then
		if not _is_table_equals(actual, expected) then
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
		if _is_table_equals(actual, expected) then
			return false
		end
	elseif actual == expected then
		return false
	end
	
	return true
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
end

function _M:assert_is_nil(value)
	
end

function _M:assert_is_not_nil(value)

end

function _M:assert_in(table, key)

end

function _M:assert_not_in(table, key)

end

return _M

