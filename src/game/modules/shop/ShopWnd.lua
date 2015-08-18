--
-- Author: dawn
-- Date: 2014-11-06 10:03:02
--
local ShopWnd = class("ShopWnd",require("game.base.BaseWindow"))

function ShopWnd:ctor()
	local ccbname  = "shop_ui"
	self.super.ctor(self,ccbname)
	
    local function onBegan(touch,event)
        return true
    end
    node_touchEvent(self,onBegan,nil,nil,nil)

	self:_init()
	self:_initData()
end

function ShopWnd:overrideInitCallFunc()
	self.m_callbacks["back_func"] = handler(self, self._closeFn)
	self.m_callbacks["zuanshi_func"] = handler(self, self._zuanshiFunc)
	self.m_callbacks["boketang_func"] = handler(self,self._boketangFunc)
	self.m_callbacks["daoju_func"] = handler(self, self._daojuFunc)
	self.m_callbacks["jixu_func"] = handler(self, self._jixuFunc)
end

function ShopWnd:_init()
	self.tf_zuanshi_value:setString("0")
	self.btn_zuanshi:selected()
end

function ShopWnd:_initData()
	local t = {}

	for i=1,5 do
		local cell = require("game.modules.shop.ShopCell").new(1,i)
		table.insert(t, cell)
	end
	local tableView = require("controls.component.DawnTable").new(display.width,460,294,210,2)
	tableView:setCells(t, 0, 2)
	self.content_layer:addChild(tableView)
	tableView:setPosition(0, 100)
end

function ShopWnd:_closeFn( )
	global.popWndMgr:close(GAME_SHOP_WND)
end
function ShopWnd:_zuanshiFunc()
	if self.btn_zuanshi:isSelected() then
		return
	end

	self.btn_zuanshi:selected()
	self.btn_boketang:unselected()
	self.btn_daoju:unselected()
	self.btn_jixubao:unselected()
end
function ShopWnd:_boketangFunc( )
	if self.btn_boketang:isSelected() then
		return
	end

	self.btn_zuanshi:unselected()
	self.btn_boketang:selected()
	self.btn_daoju:unselected()
	self.btn_jixubao:unselected()
end
function ShopWnd:_daojuFunc( )
	if self.btn_daoju:isSelected() then
		return
	end

	self.btn_zuanshi:unselected()
	self.btn_boketang:unselected()
	self.btn_daoju:selected()
	self.btn_jixubao:unselected()
end
function ShopWnd:_jixuFunc()
	if self.btn_jixubao:isSelected() then
		return
	end

	self.btn_zuanshi:unselected()
	self.btn_boketang:unselected()
	self.btn_daoju:unselected()
	self.btn_jixubao:selected()
end

return ShopWnd