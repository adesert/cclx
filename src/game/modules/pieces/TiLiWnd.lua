
--[[
    体力 购买
]]--

local TiLiWnd = class("TiLiWnd",require("game.base.BaseLayer"))

function TiLiWnd:ctor()
    self.super.ctor(self)	
end

function TiLiWnd:_overrideInit()
    self:setPassEvent(true)
    self:showMaskBG()
end

return TiLiWnd
