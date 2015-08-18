
local BeginGameWnd = class("BeginGameWnd",require("game.base.BaseLayer"))

function BeginGameWnd:ctor()
	self.super.ctor(self)
end

function BeginGameWnd:_overrideInit()
    self:showMaskBG()
    self:setPassEvent(true)

    local ccbname = "begin_game_ui"
    self.ccb = self:loadCCB(ccbname)
    --    self.ccb:setCallFunc("restart_func",handler(self,self._restartFunc))
    self.ccb:initCCB()
    self:addChild(self.ccb)

    self:_init()
end

function BeginGameWnd:_init()
    
end

return BeginGameWnd