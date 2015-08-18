
local CityFac = {}

function CityFac.getCityByid(id)
	local rName = "game.modules.maincity.city.City_"..id
    local city = require(rName).new(id)
	return city
end

return CityFac