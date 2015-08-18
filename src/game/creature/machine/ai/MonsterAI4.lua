
local MonsterAI4 = class("MonsterAI4",require("game.creature.machine.ai.IAI"))

function MonsterAI4:ctor()
    self.is_turn = false
	self.super.ctor(self)
end

local ATTACKI_DISTANCE = 400    -- 攻击距离

function MonsterAI4:handler()
    
	if global.currentPlayer == nil then
	   return
	end
	
    local owner = self:getOwner()
--    local speed = owner:getAttr(ATTR_DEFINE.SPEED)
    local player = global.currentPlayer
    

    local cPlayer = player:getMachine():getCurrentState()
    local cMonster = owner:getMachine():getCurrentState()
    if cPlayer == MACHINE_STATE_TYPE.DIE or cMonster == MACHINE_STATE_TYPE.DIE then
        return
    end
    
    local px,py = player:getPosition()
    local mx,my = owner:getPosition()
    
    local distance = global.commonFunc:twoPointDistance(cc.p(px,py),cc.p(mx,my))
--    print(distance-ATTACKI_DISTANCE * ATTACKI_DISTANCE)
    if distance <= ATTACKI_DISTANCE * ATTACKI_DISTANCE then
        if cMonster ~= MACHINE_STATE_TYPE.SKILL then
            local skills = owner:getAttr(ATTR_DEFINE.SKILLS)
            local skillid = skills[1]
            owner:useSkillAttack(skillid)
            self.is_turn = true
        end
    end
end

function MonsterAI4:completeAction()
    local owner = self:getOwner()
    owner:getMachine():changeState(MACHINE_STATE_TYPE.STAND)
    self.is_turn = false
end

return MonsterAI4