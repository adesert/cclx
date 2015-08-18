
local WinGameWnd = class("WinGameWnd",require("game.base.BaseLayer"))

function WinGameWnd:ctor()
	self.super.ctor(self)
end

function WinGameWnd:_overrideInit()
    self:showMaskBG()
    self:setPassEvent(true)

    local ccbname = "win_awards_ui"
    self.ccb = self:loadCCB(ccbname)
    self.ccb:setCallFunc("fangqi_func",handler(self,self._fangqi_func))
    self.ccb:setCallFunc("jixu_func",handler(self,self._jixu_func))
    self.ccb:initCCB()
    self:addChild(self.ccb)

    self:_init()
end

function WinGameWnd:_init()
	
end

function WinGameWnd:_fangqi_func()
	
end

function WinGameWnd:_jixu_func()
    
end

return WinGameWnd