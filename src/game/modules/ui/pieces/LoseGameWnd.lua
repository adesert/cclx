
local LoseGameWnd = class("LoseGameWnd",require("game.base.BaseLayer"))

function LoseGameWnd:ctor()
	self.super.ctor(self)
end

function LoseGameWnd:_overrideInit()
    self:showMaskBG()
    self:setPassEvent(true)

    local ccbname = "lose_ui"
    self.ccb = self:loadCCB(ccbname)
    self.ccb:setCallFunc("fangqi_func",handler(self,self._fangqi_func))
    self.ccb:setCallFunc("zailaiyici_func",handler(self,self._zailaiyici_func))
    self.ccb:initCCB()
    self:addChild(self.ccb)

    self:_init()
end

function LoseGameWnd:_init()

end

function LoseGameWnd:_fangqi_func()
	
end

function LoseGameWnd:_zailaiyici_func()

end

return LoseGameWnd