--
-- Author: dawn
-- Date: 2014-11-06 11:34:39
--
local ShopCell = class("ShopCell", function ( )
	return cc.Layer:create()
end)

function ShopCell:ctor(type,id)
	self.m_type = type
	self.m_id = id
	self:_init()
end

function ShopCell:_init( )
	self.cell = require("game.base.BaseCell").new("shop_ui_item")
	self.cell.m_callbacks["touch_cell_func"] = handler(self, self._touchItem)
	self.cell:initCCB()
	self:addChild(self.cell)
	self.cell:setAnchorPoint(cc.p(0,0))
end

function ShopCell:_touchItem()
	print(self.m_type,self.m_id)
end

return ShopCell