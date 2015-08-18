
local MainUI = class("MainUI",require("game.base.BaseLayer"))

function MainUI:ctor()
    self.top_ui = nil
	self.super.ctor(self)
end

function MainUI:_overrideInit()
    self.bg = cc.Sprite:create("images/main_ui_bg.png")
    self:addChild(self.bg)
    self.menu_bg = cc.Sprite:create("images/menu_bg.png")
    self:addChild(self.menu_bg)
    self.menu_bg:setAnchorPoint(cc.p(0,0))
    self.menu_bg:setPosition(cc.p(0,0))
    self.bg:setPosition(cc.p(define_centerx,define_centery))
    self.top_ui = require("game/modules/ui/mainui/TopUI").new()
    self:addChild(self.top_ui)
end

function MainUI:clear()
	if self.top_ui then
	   self.top_ui:clear()
	end
end

return MainUI