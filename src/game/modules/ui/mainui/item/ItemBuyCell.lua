
local ItemBuyCell = class("ItemBuyCell",require("game.base.BaseLayer"))

function ItemBuyCell:ctor(sortID,data)
    self.m_id = sortID
    self.m_data = data
	self.super.ctor(self)
end

function ItemBuyCell:_overrideInit()
    local ccbname = "item_cell_c"
    self.ccb = self:loadCCB(ccbname)
    self.ccb:setCallFunc("buy_item_func",handler(self,self._buyItemFunc))
    self.ccb:initCCB()
    self:addChild(self.ccb)
    
    self:_init()
end

function ItemBuyCell:_init()
    node_touchEvent(self.ccb["cell_event"],handler(self,self._beganFunc),nil,handler(self,self._endFunc),nil)
end

function ItemBuyCell:_buyItemFunc()
	print("buy item")
end

function ItemBuyCell:_beganFunc(touch,event)
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

function ItemBuyCell:_endFunc(touch,event)
    local target = event:getCurrentTarget()
    target:setOpacity(255)
end

return ItemBuyCell