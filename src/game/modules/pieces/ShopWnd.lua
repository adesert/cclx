
--[[ 
    商店: 宝石购买
]]--

local ShopWnd = class("ShopWnd",require("game.base.BaseLayer"))

function ShopWnd:ctor()
    self.super.ctor(self)
end

function ShopWnd:_overrideInit()
    self:setPassEvent(true)
    self:showMaskBG()
end

return ShopWnd