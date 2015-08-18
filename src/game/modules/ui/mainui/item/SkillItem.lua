
local SkillItem = class("SkillItem",require("game.base.BaseLayer"))

function SkillItem:ctor(data)
    self.m_data = data
	self.super.ctor(self)
end

function SkillItem:_overrideInit()
    local ccbname = "skill_item_cell"
    self.ccb = self:loadCCB(ccbname)
--    self.ccb:setCallFunc("buy_item_func",handler(self,self._buyItemFunc))
    self.ccb:initCCB()
    self:addChild(self.ccb)

    self:_init()
end

function SkillItem:_init()
    
    self.m_state = 0
    self.can_touch = false
    
    node_touchEvent(self.ccb["cell_event"],handler(self,self._beganFunc),nil,handler(self,self._endFunc),nil)
    
    self.is_selected = false
    self:_updateUI()
--    ccui.ScrollView:create()
end

function SkillItem:_beganFunc(touch,event)
    local target = event:getCurrentTarget()
    
    if self.m_state ~= 1 then
        return false
    end

    local locationInNode = target:convertToNodeSpace(touch:getLocation())
    local s = target:getContentSize()
    local rect = cc.rect(0, 0, s.width, s.height)
    if cc.rectContainsPoint(rect, locationInNode) then
        target:setOpacity(128)
        return true
    end
    return false
end

function SkillItem:_endFunc(touch,event)
    local target = event:getCurrentTarget()
    target:setOpacity(255)
    global.mainUIMgr:applyFn(GAME_EVENTS.UPDATE_SKILL_PANNEL_DATA,self.m_data)
end

function SkillItem:clearCells()
    self.can_touch = false
	self.ccb["skill_item"]:setVisible(false)
    self.ccb["lock_sp"]:setVisible(false)
    self.ccb["selected_sp"]:setVisible(false)
    self.ccb["tf_sp"]:setVisible(false)
    
    local sp = self.ccb["skill_item"]
    global.commonFunc:changePic(sp,global.pathMgr:getImagesByID("skill_ui/skill_empty_bg"))
end

function SkillItem:updateData(data)
	self.m_data = data
	self:_updateUI()
end

function SkillItem:_updateUI()
    if not self.m_data then
        return
    end
    
--    {type =2,id = 1001,state = 3,lv = 1,name = "test1",desc = "hello world",money = 300}}
    local type = self.m_data["type"]
    local id = self.m_data["id"]
    local state = self.m_data["state"]
    
    local icon = "skill_icon_"..id
    local sp = self.ccb["skill_item"]
    global.commonFunc:changePic(sp,global.pathMgr:getImagesByID("skill_ui/"..icon))
    
    if state == 1 then
        self.ccb["lock_sp"]:setVisible(false)
        self.ccb["selected_sp"]:setVisible(false)
        self.ccb["tf_sp"]:setVisible(false)
    elseif state == 2 then
        self.ccb["lock_sp"]:setVisible(true)
        self.ccb["selected_sp"]:setVisible(false)
        self.ccb["tf_sp"]:setVisible(false)
    elseif state == 3 then
        self.ccb["lock_sp"]:setVisible(true)
        self.ccb["selected_sp"]:setVisible(false)
        self.ccb["tf_sp"]:setVisible(true)
        self.ccb["tf_money_value"]:setString(self.m_data["money"].."")
    end
    
    self.m_state = state
    
    global.mainUIMgr:applyFn(GAME_EVENTS.UPDATE_SKILL_PANNEL_DATA,self.m_data)
end

return SkillItem