
local LoginWnd = class("LoginWnd",require("game.base.BaseLayer"))

function LoginWnd:ctor()
	self.super.ctor(self)
end

function LoginWnd:_overrideInit()
--    self:showMaskBG()
--    self:setPassEvent(true)

    local ccbname = "login_ui"
    self.ccb = self:loadCCB(ccbname)
    self.ccb:setCallFunc("enter_func",handler(self,self._enterGame))
    self.ccb:initCCB()
    self:addChild(self.ccb)

--    self.ccb:setScale(0.2)
--    local s = cc.ScaleTo:create(0.5,1)
--    local action1 = cc.EaseBackOut:create(s)
--    self.ccb:runAction(action1)
    self:_initFire()
end

function LoginWnd:_initFire()
--    local ccbname = "fireui"
--    local ccb = self:loadCCB(ccbname)
--    ccb:initCCB()
--    self:addChild(ccb)
--    ccb:setPosition(cc.p(define_centerx,define_centery))
--    
--    local csb = ccs.GUIReader:getInstance():widgetFromBinaryFile("testcsb.csb")
--    local csb = ccs.GUIReader:getInstance():widgetFromBinaryFile("")
--    csb:setPosition(cc.p(define_centerx,define_centery))
--    self:addChild(csb)
    
--    local par = global.commonFunc:getParticleSystems("defaultParticle.plist")
--    par:setPosition(cc.p(define_centerx,define_centery))
--    self:addChild(par)    
end

function LoginWnd:_enterGame()
    global.popWndMgr:close(SHOT_WNDS.GAME_LOGIN_WND)
    global.popWndMgr:open(SHOT_WNDS.GAME_MAIN_UI)
end

function LoginWnd:clear()
end

return LoginWnd