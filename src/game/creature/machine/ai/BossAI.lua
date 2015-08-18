
local BossAI = class("BossAI",require("game.creature.machine.ai.IAI"))

function BossAI:ctor()
	self.super.ctor(self)
	
	self:_initBoss()
end

function BossAI:_initBoss()
    self.currentSkill = nil
end

function BossAI:_randomSkills()
    local monster = self:getOwner()
    local skills = monster:getAttr(ATTR_DEFINE.SKILLS)
    local len = #skills
    local rad = math.random(1,len)
    local selectSkill = skills[rad]
    return selectSkill
end

function BossAI:completeAction()
    self.isUseSkill = true
    self.currentSkill = nil
end

function BossAI:handler()
    
    if true then
        return
    end
    
    if global.currentPlayer == nil then
        return
    end
    local player = global.currentPlayer
    local monster = self:getOwner()
    local cPlayer = player:getMachine():getCurrentState()
    local cMonster = monster:getMachine():getCurrentState()
    if cPlayer == MACHINE_STATE_TYPE.DIE or cMonster == MACHINE_STATE_TYPE.DIE then
        return
    end
    
    if cMonster == MACHINE_STATE_TYPE.HURT then
        return
    end

    local move_speed = monster:getAttr(ATTR_DEFINE.SPEED)
    
    if self.currentSkill == nil then
        self.currentSkill = self:_randomSkills()
    end
    local data = global.dataMgr:getConfigDatas("skill_config",self.currentSkill)
    local attack_range = tonumber(data.attack_range)

    local vx,vy = player:getPosition()
    local cx,cy = monster:getPosition()
    local gapx = math.abs(vx-cx)
    local gapy = math.abs(vy-cy)
    local gap = gapx*gapx + gapy * gapy

    if cx < vx then
        monster:setDirection(DIRECTION.RIGHT)
    else
        monster:setDirection(DIRECTION.LEFT)       
    end

    local actionState = monster:getMachine():getCurrentState()

    if gap<attack_range*attack_range then
        if actionState == MACHINE_STATE_TYPE.MOVE or self.isUseSkill then
            monster:useSkillAttack(self.currentSkill)
            self.isUseSkill = nil
        end
        return
    end

    if actionState ~= MACHINE_STATE_TYPE.MOVE then
        monster:changeActionState(MACHINE_STATE_TYPE.MOVE)
    end

    local moveSpeed = 1 --移动速度
    local angle = math.atan((cy-vy)/(cx-vx))
    local zx = moveSpeed * math.cos(angle)
    local zy = moveSpeed * math.sin(angle)

    zx = math.abs(zx)
    zy = math.abs(zy)
    if cx > vx then
        zx = -zx
    end

    if cy > vy then
        zy = -zy
    end

    cx = cx+zx
    cy = cy+zy
    monster:setPosition(cc.p(cx,cy))
end

return BossAI