
local LevelFact = {}

function LevelFact.getLevelsByID(id)
    local rName = "game.map.levels.Level_"..id
    local level = require(rName).new(id)
    return level
end

return LevelFact