
local RoleUI = class("RoleUI",require("game.base.BaseLayer"))

function RoleUI:ctor()
	self.super.ctor(self)
end

function RoleUI:_overrideInit()
    local ccbname = "role_ui"
    self.ccb = self:loadCCB(ccbname)
    --    self.ccb:setCallFunc("enter_func",handler(self,self._enterGame))
    self.ccb:initCCB()
    self:addChild(self.ccb)

    --    self.ccb:setScale(0.2)
    --    local s = cc.ScaleTo:create(0.5,1)
    --    local action1 = cc.EaseBackOut:create(s)
    --    self.ccb:runAction(action1)

    self:_init()
end

function RoleUI:_init()
	self.selectedID = 0
	
    self.ccb["role_1"].id = 1
    self.ccb["role_2"].id = 2
    node_touchEvent(self.ccb["role_1"],handler(self,self._beganFunc),nil,handler(self,self._endFunc),nil)
    node_touchEvent(self.ccb["role_2"],handler(self,self._beganFunc),nil,handler(self,self._endFunc),nil)
--    node_touchEvent(self.ccb["role"],handler(self,self._beganFunc),nil,handler(self,self._endFunc),nil)

    self:_changeRole(1)
end

function RoleUI:_beganFunc(touch,event)
    local target = event:getCurrentTarget()
    local locationInNode = target:convertToNodeSpace(touch:getLocation())
    local s = target:getContentSize()
    local rect = cc.rect(0, 0, s.width, s.height)
    local id = target.id
    if cc.rectContainsPoint(rect, locationInNode) then
--        print(string.format("sprite began... x = %f, y = %f", locationInNode.x, locationInNode.y))
        target:setOpacity(180)
--        print(id)
        return true
    end
    return false
end

function RoleUI:_endFunc(touch,event)
    local target = event:getCurrentTarget()
    target:setOpacity(255)
    local id = target.id
    print(id)
--    if target == sprite2 then
--        sprite1:setLocalZOrder(100)
--    elseif target == sprite1 then
--        sprite1:setLocalZOrder(0)
--    end
    self:_changeRole(id)
end

function RoleUI:_changeRole(id)
	if self.selectedID == id then
	   return
	end
	
    
	local sp
    if self.selectedID >0 then
        sp = self.ccb["role_"..self.selectedID]
        global.commonFunc:changePic(sp,global.pathMgr:getImagesByID("role_hidde_"..self.selectedID))
	end
	
    self.selectedID = id
	
    sp = self.ccb["role_"..self.selectedID]
    global.commonFunc:changePic(sp,global.pathMgr:getImagesByID("role_show_selected_"..self.selectedID))
    
    sp = self.ccb["role"]
    local zorder = sp:getLocalZOrder()
    local x,y = sp:getPosition()
    
    sp:removeFromParent()
    sp = cc.Sprite:create(global.pathMgr:getImagesByID("role_show_"..self.selectedID))
    sp:setLocalZOrder(zorder)
    sp:setPosition(cc.p(x,y))
    self.ccb:addChild(sp)
    sp:setOpacity(0)
    
    sp:runAction(cc.FadeTo:create(0.2,255))
    
    self.ccb["role_fing"]:setLocalZOrder(zorder+1)
    
    self.ccb["role"] = sp
end

return RoleUI