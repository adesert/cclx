
local MapFac = {}

function MapFac.getMapById(id)
    local mapid = "src/game/modules/fight/map/FMap_"..id
    local map = require(mapid).new(id)
    return map
end

return MapFac