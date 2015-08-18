
--[[
    登陆页面
]]--

local LoginWnds = class("LoginWnds",require("game.base.BaseLayer"))

function LoginWnds:ctor()
	self.super.ctor(self)
end

function LoginWnds:_overrideInit()
    self:setPassEvent(true)
    self:showMaskBG()
end

return LoginWnds