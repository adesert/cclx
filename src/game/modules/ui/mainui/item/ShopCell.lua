
local ShopCell = class("ShopCell",require("game.base.BaseLayer"))

function ShopCell:ctor(data)
    self.m_data = data
	self.super.ctor(self)
end

function ShopCell:_overrideInit()
    local ccbname = "shop_cell_item"
    self.ccb = self:loadCCB(ccbname)
    self.ccb:setCallFunc("shop_func",handler(self,self._buyItemFunc))
    self.ccb:initCCB()
    self:addChild(self.ccb)

    self:_init()
end

function ShopCell:_init()
--	self.ccb["cell_left_icon"]
--    self.ccb["cell_middle_icon"]
    self.ccb["tf_num_value"]:setString("x"..self.m_data["value"])
    self.ccb["tf_money_value"]:setString(self.m_data["money"].."")
    
    local type = self.m_data["type"]
    local icon = self.m_data["icon"]
    
    local vx,vy = self.ccb["cell_left_icon"]:getPosition()
    self.ccb["cell_left_icon"]:removeFromParent()
    local t = cc.Sprite:create(global.pathMgr:getImagesByID("shop_ui/"..icon))
    t:setPosition(vx,vy)
    self.ccb:addChild(t)
    self.ccb["cell_left_icon"]=t
    
    vx,vy = self.ccb["cell_middle_icon"]:getPosition()
    self.ccb["cell_middle_icon"]:removeFromParent()
    if type == 1 then
        t = cc.Sprite:create(global.pathMgr:getImagesByID("shop_ui/img_gold_1"))
    elseif type == 2 then
        t = cc.Sprite:create(global.pathMgr:getImagesByID("shop_ui/img_diamon_1"))
    end
    t:setPosition(vx,vy)
    self.ccb:addChild(t)
    self.ccb["cell_middle_icon"]=t
end

function ShopCell:_buyItemFunc()
	print("buy item")
end

return ShopCell