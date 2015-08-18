
local SelectedItemCell = class("SelectedItemCell",require("game.base.BaseLayer"))

function SelectedItemCell:ctor(id)
    self.m_id = id
	self.super.ctor(self)
end

function SelectedItemCell:_overrideInit()
    local ccbname = "cell_item"
    self.ccb = self:loadCCB(ccbname)
--    self.ccb:setCallFunc("entergame_func",handler(self,self._enterGame))
    self.ccb:initCCB()
    self:addChild(self.ccb)
    
    self:_init()
end

function SelectedItemCell:getID()
    return self.m_id
end

function SelectedItemCell:setItemValueByID(n,id)
    self.is_show = true
    self.ccb["tf_num_value"]:setString("x"..n)
    
    self.ccb["item"]:setVisible(self.is_show)
    self.ccb["tf_num_value"]:setVisible(self.is_show)
end

function SelectedItemCell:_init()
    self.is_show = false
    self.ccb["tf_num_value"]:setString("x1")
    self.ccb["item"]:setVisible(self.is_show)
    self.ccb["tf_num_value"]:setVisible(self.is_show)
--    self.ccb["select_event"]
    
    node_touchEvent(self.ccb["select_event"],handler(self,self._beganFunc),nil,handler(self,self._endFunc),nil)
end

function SelectedItemCell:_beganFunc(touch,event)
    local target = event:getCurrentTarget()
    if self.is_show == false then
        return false
    end
    
    local locationInNode = target:convertToNodeSpace(touch:getLocation())
    local s = target:getContentSize()
    local rect = cc.rect(0, 0, s.width, s.height)
    if cc.rectContainsPoint(rect, locationInNode) then
--        print(string.format("sprite began... x = %f, y = %f", locationInNode.x, locationInNode.y))
        self.is_show = false
        self.ccb["item"]:setVisible(self.is_show)
        self.ccb["tf_num_value"]:setVisible(self.is_show)
        target:setOpacity(128)
        return true
     end
     return false
end

function SelectedItemCell:getSelectedState()
	return self.is_show
end

function SelectedItemCell:_endFunc(touch,event)
    local target = event:getCurrentTarget()
    target:setOpacity(255)
end

return SelectedItemCell