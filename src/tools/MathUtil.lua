local MathUtil = class("MathUtil")

function MathUtil:ctor()

end

function MathUtil:getIntPart(x)
	if x <= 0 then
		return math.ceil(x)
	end
	
	if math.ceil(x) == x then
		x = math.ceil(x)
	else
		x = math.ceil(x) - 1
	end
	
	return x
end

return MathUtil