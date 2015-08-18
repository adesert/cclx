
local BarryFac = {}


function BarryFac.getBarry(type,...)
    local bs = nil
    
    if type == BARRYS_TYPE.BARRY_CIRCLE then
	   bs = require("game.modules.gaming.barry.CircleBarrys").new(...)	
	elseif type == BARRYS_TYPE.BARRY_RECT then
        bs = require("game.modules.gaming.barry.RectBarrys").new(...)
	elseif type == BARRYS_TYPE.BARRY_TRA then
        bs = require("game.modules.gaming.barry.TarBarrys").new(...)
	elseif type == BARRYS_TYPE.BARRY_QT_CIRCLE then
        bs = require("game.modules.gaming.barry.QtCircle").new(...)
	elseif type == BARRYS_TYPE.BARRY_QT_RECT then
        bs = require("game.modules.gaming.barry.QtRect").new(...)
    elseif type == BARRYS_TYPE.BALL_TYPE then
        bs = require("game.modules.gaming.barry.BallBody").new(...)
    elseif type == BARRYS_TYPE.BARRY_WOOD then
        bs = require("game.modules.gaming.barry.WoodBarry").new(...)
    elseif type == BARRYS_TYPE.BARRY_JAR_TARGET then
        bs = require("game.modules.gaming.barry.JarTargetBarrier").new(...)    
    elseif type == BARRYS_TYPE.BARRY_DOT then
        bs = require("game.modules.gaming.barry.DotPhysics").new(...)
    elseif type == BARRYS_TYPE.BARRY_Triangle then
        bs = require("game.modules.gaming.barry.TriangleBody").new(...)
    elseif type == BARRYS_TYPE.BARRY_GOAL then
        bs = require("game.modules.gaming.barry.GoalBody").new(...)    
    elseif type == BARRYS_TYPE.BARRY_LINEBODY then
        bs = require("game.modules.gaming.barry.LineBody").new(...)    
    elseif type == BARRYS_TYPE.BARRY_COMBAT_BLOCK then
        bs = require("game.modules.gaming.barry.CombatBlockBody").new(...)
    elseif type == BARRYS_TYPE.BARRY_BLOCK_T then
        bs = require("game.modules.gaming.barry.BlockPhysicsBody").new(...)    
	end
	bs:setType(type)
	return bs
end

return BarryFac