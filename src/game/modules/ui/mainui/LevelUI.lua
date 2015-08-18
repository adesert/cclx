
local LevelUI = class("LevelUI",require("game.base.BaseLayer"))

function LevelUI:ctor()
	self.super.ctor(self)
end

function LevelUI:_overrideInit()
    local ccbname = "levelui"
    self.ccb = self:loadCCB(ccbname)
    self.ccb:setCallFunc("entergame_func",handler(self,self._enterGame))
    self.ccb:initCCB()
    self:addChild(self.ccb)

    --    self.ccb:setScale(0.2)
    --    local s = cc.ScaleTo:create(0.5,1)
    --    local action1 = cc.EaseBackOut:create(s)
    --    self.ccb:runAction(action1)

    self:_init()
end

function LevelUI:_init()
end

function LevelUI:_enterGame()
    self:_openStartGame()
end

function LevelUI:_openStartGame()
	self.startUI = require("game.modules.ui.mainui.StartGameUI").new()
	self:addChild(self.startUI)
--	self.startUI:setPosition(define_centerx,define_centery)
end

function LevelUI:clear()
    if self.startUI then
        self.startUI:clear()
	end
end

return LevelUI