
local EquItem = class("EquItem",require("game.base.BaseLayer"))

function EquItem:ctor()
    self.super.ctor(self)
end

function EquItem:_overrideInit()
--{id=1,lv = 10,pinzhi=1,icon="role_ui_38",star=3,equ_name="黄金甲1",base_attr={s1=999,s2=20,s3=39,s4=20},gems_type=1,gems_nums = 2,gems_attr={s1=999,s2=20,s3=39,s4=20}},
    self.ccb = self:loadCCB("equ_item")
    --    self.ccb:setCallFunc("create_role_func",handler(self,self.create_role_func))
    self.ccb:initCCB()
    self:addChild(self.ccb)
    
    local ly = cc.Layer:create()
    self:addChild(ly)
    
    node_touchEvent(self.ccb["equ_pinzhi"],handler(self,self._beginFunc),nil,nil,nil)
end

function EquItem:setData(data)
    self.m_data = data
    self:_initUI()
end

function EquItem:getData()
	return self.m_data
end

function EquItem:_initUI()
	local goup = cc.Sprite:create("imgs/role_ui/role_ui_6.png")
    goup:setPosition(0,0)
    self:addChild(goup)
	
    --{id=1,lv = 10,pinzhi=1,icon="role_ui_38",star=3,equ_name="黄金甲1",base_attr={s1=999,s2=20,s3=39,s4=20},gems_type=1,gems_nums = 2,gems_attr={s1=999,s2=20,s3=39,s4=20}},
    
	--- 
	local sp = nil
    local eque = {"role_ui_13.png","role_ui_15.png","role_ui_13.png","role_ui_16.png","role_ui_14.png","role_ui_17.png"}
    local s = eque[self.m_data["id"]]
	sp = cc.Sprite:create("imgs/role_ui/"..s)
	sp:setPosition(44,43)
    goup:addChild(sp)
	
	local lv = self.m_data["lv"]
	if lv == 0 then
		return
	end
	
	--- 白，蓝，绿，紫，橙
	local pinzhi_res = {"role_ui_11.png","role_ui_9.png","role_ui_8.png","role_ui_10.png","role_ui_7.png"}
    s = pinzhi_res[self.m_data["pinzhi"]]
	sp = cc.Sprite:create("imgs/role_ui/"..s)
	sp:setPosition(44,43)
    goup:addChild(sp)
    
    sp = cc.Sprite:create("imgs/role_ui/"..self.m_data["icon"]..".png")
    sp:setPosition(44,43)
    goup:addChild(sp)
    
    local star_pos = {cc.p(20,17),cc.p(32,17),cc.p(44,17),cc.p(56,17),cc.p(68,17)}
    local star=self.m_data["star"]
    for i=1,star do
        sp = cc.Sprite:create("imgs/role_ui/role_ui_12.png")
        sp:setPosition(star_pos[i])
        goup:addChild(sp)
    end
    
    local tf = cc.Label:createWithSystemFont(self.m_data["lv"].."", "", 13)
    tf:setAnchorPoint(cc.p(0.5,0.5))
    tf:setPosition(68.6,70.6)
    goup:addChild(tf)
    
    node_touchEvent(goup,handler(self,self._beginFunc),nil,nil,nil)
end

function EquItem:_beginFunc(touch,event)
    local target = event:getCurrentTarget()
    local locationInNode = target:convertToNodeSpace(touch:getLocation())
    local s = target:getContentSize()
    local rect = cc.rect(0, 0, s.width, s.height)
    if cc.rectContainsPoint(rect, locationInNode) then
--        print(string.format("sprite began... x = %f, y = %f", locationInNode.x, locationInNode.y))
        local lv = self.m_data["lv"]
        if lv == 0 then
            return
        end
        global.popWndMgr:open(KONG_WNDS.ROLE_INFO_TIPS_WND,self.m_data)
    end
    return false
end

function EquItem:clear()
    
end

return EquItem