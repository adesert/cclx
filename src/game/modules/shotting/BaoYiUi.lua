
local BaoYiUi = class("BaoYiUi",require("game.base.BaseLayer"))

function BaoYiUi:ctor()
	self.super.ctor(self)
end

function BaoYiUi:_overrideInit()
--    self:showMaskBG()
--    self:setPassEvent(true)
--	self.m_sp = cc.Sprite:create("img/role_baoyi_1.png")
--	local w = self.m_sp:getContentSize().width
--    self.m_sp:setPosition(-w,define_centery)
--	self:addChild(self.m_sp)
--	
--    local seq = cc.Sequence:create(cc.FadeIn:create(0.2),cc.EaseIn:create(cc.MoveTo:create(0.15,cc.p(define_centerx,define_centery)),0.2),cc.DelayTime:create(2),cc.FadeOut:create(0.2),cc.CallFunc:create(handler(self,self._closedUI)))
--	self.m_sp:runAction(seq)
    
    self:_init()
end

function BaoYiUi:_init()
    self.test = cc.LayerColor:create(cc.c4b(0,0,0,255))
    self.test:setContentSize(cc.size(screen_w,screen_h))
    self:addChild(self.test)
    
    self:setPassEvent(true)
    
    self.cell = require("game.base.BaseCell").new("ui_effect_1")
--    self.cell:setCallFunc("stop_game_func",handler(self, self._stopGameFunc))
--    self.cell:setCallFunc("shot_func",handler(self, self._shotFunc))
    self.cell:initCCB()

    self:addChild(self.cell)
    
    self.cell:runAction(cc.Sequence:create(cc.DelayTime:create(1),cc.CallFunc:create(handler(self,self._closedUI))))
end

function BaoYiUi:_closedUI()
    global.shotMgr:applyFn(GAME_EVENTS.CLOSE_BAOYI_EVENT)
end

return BaoYiUi