
local LoginLayer = class("LoginLayer",require("game.base.BaseLayer"))

function LoginLayer:ctor()
	self.super.ctor(self)
end

function LoginLayer:_overrideInit()
--    self.ccb = self:loadCCB("login_ui")
--    self.ccb:setCallFunc("create_role_func",handler(self,self.create_role_func))

--    self.ccb:initCCB()
--    self:addChild(self.ccb)
    
    self:_init()
end

function LoginLayer:_init()
    local sp = cc.Sprite:create("images/background/main.jpg")
    sp:setAnchorPoint(cc.p(0,0))
    self:addChild(sp)
    
    sp = cc.Sprite:create("images/ui/logo.png")
    sp:setPosition(define_centerx,define_top+100)
    self:addChild(sp)
    local seq = cc.Sequence:create(cc.DelayTime:create(0.5),cc.MoveTo:create(0.5,cc.p(define_centerx,define_centery+100)))
    sp:runAction(seq)
    
    local menu = cc.Menu:create()
    menu:setAnchorPoint(cc.p(0,0))
    menu:setPosition(cc.p(0,0))
    self:addChild(menu)
    
    local btn1 = cc.MenuItemImage:create("images/ui/begin_01.png",nil)
    btn1:registerScriptTapHandler(handler(self,self._startFunc1))
    menu:addChild(btn1)
    btn1:setPosition(399.8,160.0)
    
    local btn2 = cc.MenuItemImage:create("images/ui/chaoJiYuChi_01.png",nil)
    btn2:registerScriptTapHandler(handler(self,self._startFunc2))
    menu:addChild(btn2)
    btn2:setPosition(397.8,69.0)
end

function LoginLayer:_startFunc1(sender)
    print(sender)
end
function LoginLayer:_startFunc2(sender)
    print(sender)
end

function LoginLayer:clear()
	
end

return LoginLayer