
local MonsterAI3 = class("MonsterAI2",require("game.creature.machine.ai.IAI"))

function MonsterAI3:ctor()
    self.is_detection = false
    self.movePt = nil   
    self.frame_handler = nil
	self.super.ctor(self)
end

local GAP_TIME = 1  -- 间隔时间秒
local D_R = 200     -- 距离半径（搜索半径）
local ANGLE_S = 30  -- 度数
local ATTACK_RANGE = 30-- 攻击距离像素

function MonsterAI3:handler()
    if self.is_detection == true then
        return
    end
    
    local owner = self:getOwner()
--    local seque = cc.Sequence:create(cc.DelayTime:create(GAP_TIME),cc.CallFunc:create(handler(self,self._onFunc)))
    
    owner:runAction(cc.Sequence:create(cc.DelayTime:create(GAP_TIME),cc.CallFunc:create(handler(self,self._onFunc))))
    
	self.is_detection = true
end

function MonsterAI3:getRectX(vx)
    local move_rect = global.mapMgr:getCurrentMoveSpeed()
    if vx<=0 then
        vx = 0
    end
    if vx >= move_rect.width then
        vx = move_rect.width
    end
    return vx
end

function MonsterAI3:getRectY(vy)
    local move_rect = global.mapMgr:getCurrentMoveSpeed()
    if vy <=0 then
        vy = 0
    end
    if vy >= move_rect.height then
        vy = move_rect.height
    end
    return vy
end

function MonsterAI3:_onFunc()
    if self.is_pause == true then
        return
    end

    if global.currentPlayer == nil then
        return
    end
    
    local owner = self:getOwner()
    local speed = owner:getAttr(ATTR_DEFINE.SPEED)
    local player = global.currentPlayer

    local cPlayer = player:getMachine():getCurrentState()
    local cMonster = owner:getMachine():getCurrentState()
    if cPlayer == MACHINE_STATE_TYPE.DIE or cMonster == MACHINE_STATE_TYPE.DIE then
        return
    end
    
    local px,py = player:getPosition()
    local ange = ANGLE_S*math.pi/180
    local cdr = math.abs(D_R * math.cos(ange))
    local sdr = math.abs(D_R * math.sin(ange))
    
    local move_rect = global.mapMgr:getCurrentMoveSpeed()
    
    local a1x = px- cdr
    local a1y = py + sdr
    a1x = self:getRectX(a1x)
    a1y = self:getRectY(a1y)
    local a1 = cc.p(a1x,a1y)
    
    local b1x = px - D_R
    local b1y = py
    b1x = self:getRectX(b1x)
    b1y = self:getRectY(b1y)
    local b1 = cc.p(b1x,b1y)
    
    local c1x = px - cdr
    local c1y = py - sdr
    c1x = self:getRectX(c1x)
    c1y = self:getRectY(c1y)
    local c1 = cc.p(c1x,c1y)
    
    local a2x = px + cdr
    local a2y = py + sdr
    a2x = self:getRectX(a2x)
    a2y = self:getRectY(a2y)
    local a2 = cc.p(a2x,a2y)
    
    local b2x = px + D_R
    local b2y = py
    b2x = self:getRectX(b2x)
    b2y = self:getRectY(b2y)
    local b2 = cc.p(b2x,b2y)
    
    local c2x = px + cdr
    local c2y = py - sdr
    c2x = self:getRectX(c2x)
    c2y = self:getRectY(c2y)
    local c2 = cc.p(c2x,c2y)
    
    local a = {a1,b1,c1,a2,b2,c2}
    local rad = math.random(1,6)
    local pt = a[rad]
    
    self.movePt = pt
    
    if self.frame_handler then
        SCHE_MGR.unscheduleGlobal(self.frame_handler)
    end
    self.frame_handler = SCHE_MGR.scheduleUpdateGlobal(handler(self,self._render))
    
--    if self.move_action then
--        owner:stopAction(self.move_action)
--    end
--    self.move_action = cc.MoveTo:create(2,self.movePt)
--    owner:runAction(self.move_action)
end

function MonsterAI3:_render(dt)
    if self.is_pause == true then
        return
    end
    
    if self.is_gap_time == true then
        return
    end
    if not self.movePt then
        return
    end
    if global.currentPlayer == nil then
        return
    end

    local owner = self:getOwner()
    local speed = owner:getAttr(ATTR_DEFINE.SPEED)
    local player = global.currentPlayer

    local cPlayer = player:getMachine():getCurrentState()
    local cMonster = owner:getMachine():getCurrentState()
    if cPlayer == MACHINE_STATE_TYPE.DIE or cMonster == MACHINE_STATE_TYPE.DIE then
        return
    end
--    local px,py = player:getPosition()
    local px = self.movePt.x
    local py = self.movePt.y
    local mx,my = owner:getPosition()
    local angle = math.atan((my-py)/(mx-px))
    
    local zx = speed * math.cos(angle)
    local zy = speed * math.sin(angle)
--    print("move sppeed --->",angle,speed,zx,zy)
    zx = math.abs(zx)
    zy = math.abs(zy)
    if mx > px then
        zx = -zx
    end

    if my > py then
        zy = -zy
    end

    mx = mx+zx
    my = my+zy
    owner:setPosition(cc.p(mx,my))
    
    if cMonster ~= MACHINE_STATE_TYPE.MOVE then
        owner:getMachine():changeState(MACHINE_STATE_TYPE.MOVE)
    end
    
    if mx < px then
        owner:setDirection(DIRECTION.RIGHT)
    else
        owner:setDirection(DIRECTION.LEFT)      
    end
    
    local len = global.commonFunc:twoPointDistance(cc.p(mx,my),cc.p(px,py))
    
    if len<=15*15 then
        self.movePt = nil
        if self.frame_handler then
            SCHE_MGR.unscheduleGlobal(self.frame_handler)
            self.frame_handler = nil
        end
        owner:getMachine():changeState(MACHINE_STATE_TYPE.STAND)
       
        local mmx = owner:getPositionX()
        local ppx = player:getPositionX()
--        print(mmx,ppx)
        if mmx < ppx then
            owner:setDirection(DIRECTION.RIGHT)
        else
            owner:setDirection(DIRECTION.LEFT)      
        end
        self.is_gap_time = true
        
        local seque = cc.Sequence:create(cc.DelayTime:create(1),cc.CallFunc:create(handler(self,self.reBackFn)))
        owner:runAction(seque)
    end
end

function MonsterAI3:reBackFn()
    if self.is_pause == true then
        return
    end
    
	self.is_gap_time = nil
--	print("attack")
    local owner = self:getOwner()
    local skills = owner:getAttr(ATTR_DEFINE.SKILLS)
    local skillid = skills[1]
    owner:useSkillAttack(skillid)
--    owner:useSkillAttack("7")
--    local player = global.currentPlayer
--    local px,py = player:getPosition()
--    local len = global.commonFunc:getNodePointLength(owner,player)
--    local data = global.dataMgr:getConfigDatas("skill_config",self.currentSkill) -- 先支持配一个技能id
--    local attack_range = tonumber(data.attack_range)
end

function MonsterAI3:completeAction()
    local owner = self:getOwner()
    owner:runAction(cc.Sequence:create(cc.DelayTime:create(GAP_TIME),cc.CallFunc:create(handler(self,self._onFunc))))
end

function MonsterAI3:clear()
    if self.frame_handler then
        SCHE_MGR.unscheduleGlobal(self.frame_handler)
    end
end

return MonsterAI3