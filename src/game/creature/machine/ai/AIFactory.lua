
local AIFactory = {}

function AIFactory.getAI(type)
	local ai
    if type == AI_DEFINE.PLAYER_AI  then
		ai = require("game/creature/machine/ai/PlayerAI").new()
    elseif type == AI_DEFINE.MONSTER_AI_1 then
        ai = require("game.creature.machine.ai.MonsterAI").new()
    elseif type == AI_DEFINE.MONSTER_AI_2 then
        ai = require("game.creature.machine.ai.BossAI").new()
    elseif type == AI_DEFINE.MONSTER_AI_3 then
        ai = require("game.creature.machine.ai.MonsterAI3").new()
    elseif type == AI_DEFINE.MONSTER_AI_4 then
        ai = require("game.creature.machine.ai.MonsterAI4").new()
    elseif type == AI_DEFINE.MONSTER_AI_5 then
        ai = require("game.creature.machine.ai.MonsterAI5").new()
    elseif type == AI_DEFINE.XIANJING_AI_1 then
        ai = require("game.creature.machine.ai.XianJingAI").new()
	end
	
	ai:setType(type)
	
	return ai
	
end

return AIFactory