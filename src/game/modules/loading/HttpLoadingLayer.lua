
local HttpLoadingLayer = class("HttpLoadingLayer",require("game.base.BaseLayer"))

function HttpLoadingLayer:ctor()
	self.super.ctor(self)
end

function HttpLoadingLayer:_overrideInit()
    self:showMaskBG()
    self:setPassEvent(true)
    
    local path = "loading_msg.png"
    local sp = cc.Sprite:create(path)
    sp:setPosition(center_x,center_y)
    self:addChild(sp)
    local action = cc.RotateBy:create(0.3, 40)
    local actionInterval = cc.RepeatForever:create(action)
    sp:runAction(actionInterval)
end

function HttpLoadingLayer:clear()
	
end

return HttpLoadingLayer