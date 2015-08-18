
local XianJingAI = class("XianJingAI",require("game.creature.machine.ai.IAI"))

function XianJingAI:ctor()
    self.is_counts = false
    self.super.ctor(self)
end

local TIME_GAP = 3
function XianJingAI:handler()
    if self.is_counts == true then
        return
    end
    
    local owner = self:getOwner()
    local seque = cc.Sequence:create(cc.DelayTime:create(TIME_GAP),cc.CallFunc:create(handler(self,self._onFunc)))

--    owner:runAction(cc.Sequence:create(cc.DelayTime:create(TIME_GAP),cc.CallFunc:create(handler(self,self._onFunc))))
    
    owner:runAction(cc.RepeatForever:create(seque))
    self.is_counts = true
end

function XianJingAI:_onFunc()
    
    if self.is_pause == true then
        return
    end
    
    local owner = self:getOwner()
    local vx,vy = owner:getPosition()
    local sp = owner:getSprite()
    local gx,gy = sp:getPosition()
    
    local mx = vx+gx
    local my = vy+gy
    
    local layer =  global.sceneMgr:getMapLayer(MAP_TYPE.THINGS_LAYER)
    local skills = owner:getAttr(ATTR_DEFINE.SKILLS)
    local skillid = skills[1]
    local layer = global.sceneMgr:getMapLayer(MAP_TYPE.THINGS_LAYER)
    local effect = global.effectMgr:createCommonEff(skillid,layer)
    effect:play()
    effect:setPosition(mx,my)
end

return XianJingAI