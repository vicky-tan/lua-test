

function run(test_cases)
	if test_cases and type(test_cases) == 'table' then
		for name, test in pairs(test_cases) do
			if string.find(name, 'test') == 1 then
				test()
			end
		end
	end
end