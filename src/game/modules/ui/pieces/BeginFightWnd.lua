
-- 挑战前准备（道具选择）
local BeginFightWnd = class("BeginFightWnd",require("game.base.BaseLayer"))

function BeginFightWnd:ctor()
	self.super.ctor(self)
end

function BeginFightWnd:_overrideInit()
    self:showMaskBG()
    self:setPassEvent(true)

    local ccbname = "begin_fight_ready"
    self.ccb = self:loadCCB(ccbname)
    --    self.ccb:setCallFunc("restart_func",handler(self,self._restartFunc))
    self.ccb:initCCB()
    self:addChild(self.ccb)

    self:_init()
end

function BeginFightWnd:_init()
    
end

return BeginFightWnd