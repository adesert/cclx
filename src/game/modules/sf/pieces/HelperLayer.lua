
local HelperLayer = class("HelperLayer",require("game.base.BaseLayer"))

function HelperLayer:ctor()
	self.super.ctor(self)
end

function HelperLayer:_overrideInit()
--    self.ccb = self:loadCCB("help_ui")
--    self.ccb:setCallFunc("create_role_func",handler(self,self.create_role_func))

--    self.ccb:initCCB()
--    self:addChild(self.ccb)

    self:setPassEvent(true)

    local sp = cc.Sprite:create("images/background/help.jpg")
    sp:setPosition(center_x,center_y)
    self:addChild(sp)
    
    sp:setOpacity(0)
    local act = cc.FadeIn:create(0.25)
    sp:runAction(act)
    
    local layer = cc.Layer:create()
    self:addChild(layer)
    node_touchEvent(layer,handler(self,self._touchBegin),nil,nil,nil)
end

function HelperLayer:_touchBegin(event,touch)
    global.popWndMgr:close(SF_WNDS.HELPER_WND)
	return false
end

function HelperLayer:clear()
	
end

return HelperLayer