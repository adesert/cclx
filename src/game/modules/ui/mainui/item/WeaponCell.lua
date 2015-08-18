
local WeaponCell = class("WeaponCell",require("game.base.BaseLayer"))

function WeaponCell:ctor(data)
    self.m_data = data
	self.super.ctor(self)
end

function WeaponCell:_overrideInit()
    local ccbname = "weapon_item_ui"
    self.ccb = self:loadCCB(ccbname)
--    self.ccb:setCallFunc("buy_item_func",handler(self,self._buyItemFunc))
    self.ccb:initCCB()
    self:addChild(self.ccb)

    self:_init()	
end

function WeaponCell:_init()
    self.ccb["tf_sp"]:setVisible(false)
    self.ccb["selected_sp"]:setVisible(false)
    self.ccb["lock_sp"]:setVisible(false)
    self.ccb["lock_weapon_sp"]:setVisible(false)
--    self.ccb["weapon_item"]

    node_touchEvent(self.ccb["cell_event"],handler(self,self._beganFunc),nil,handler(self,self._endFunc),nil)
end

function WeaponCell:setCellSelected(s)
	self.ccb["selected_sp"]:setVisible(s)
end

function WeaponCell:isActivityState(s)
    self.ccb["lock_sp"]:setVisible(s)
end

function WeaponCell:setHidden(s)
	self.ccb["tf_sp"]:setVisible(false)
    self.ccb["selected_sp"]:setVisible(false)
    self.ccb["lock_sp"]:setVisible(true)
    self.ccb["lock_weapon_sp"]:setVisible(true)
end

function WeaponCell:setZhuangBeiState(s)
    self.ccb["tf_sp"]:setVisible(false)
    self.ccb["selected_sp"]:setVisible(false)
    self.ccb["lock_sp"]:setVisible(false)
    self.ccb["lock_weapon_sp"]:setVisible(false)
    self.ccb["weapon_item"]:setVisible(false)
end

function WeaponCell:_beganFunc(touch,event)
    local target = event:getCurrentTarget()

    local locationInNode = target:convertToNodeSpace(touch:getLocation())
    local s = target:getContentSize()
    local rect = cc.rect(0, 0, s.width, s.height)
    if cc.rectContainsPoint(rect, locationInNode) then
        target:setOpacity(128)
        return true
    end
    return false
end

function WeaponCell:_endFunc(touch,event)
    local target = event:getCurrentTarget()
    target:setOpacity(255)
end


return WeaponCell