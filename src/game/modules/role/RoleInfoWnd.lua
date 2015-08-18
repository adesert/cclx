
local RoleInfoWnd = class("RoleInfoWnd",require("game.base.BaseLayer"))

function RoleInfoWnd:ctor()
	self.super.ctor(self)
end

function RoleInfoWnd:_overrideInit()
    self:showMaskBG()
    self:setPassEvent(true)
    
    self.ccb = self:loadCCB("equ_ui")
    self.ccb:setCallFunc("close_func",handler(self,self._closeFunc))
    self.ccb:initCCB()
    self:addChild(self.ccb)
    
    self.ccb:setPosition(center_x,center_y)
--    self.ccb:setScale(0.4)
--    local seq = cc.ScaleTo:create(0.25,1)
--    seq = cc.EaseBackOut:create(seq)
--    self.ccb:runAction(seq)
    
    self:_testData()
    self:_initUI()
    self:_initData()
end

function RoleInfoWnd:_testData()
    self.m_data = {roleid = 1,rolename = "轩辕",lv = 20,money = 1999,gold = 99,chenghao="轩辕帝",zhanli=1000,gonghui="轩辕谷",currentexp=1000,maxexp=9999,
    role_attr = {s1=999,s2=20,s3=39,s4=20,s5=20,s6=20,s7=2015},
    equ_info={
            {id=1,lv = 10,pinzhi=1,icon="role_ui_38",icon_big="equ_tips_14",star=3,equ_name="黄金甲1",base_attr={s1=999,s2=20,s3=39,s4=20},gems_type=1,gems_nums = 2,gems_attr={s1=999,s2=20,s3=39,s4=20}},
            {id=2,lv = 2,pinzhi=2,icon="role_ui_38",icon_big="equ_tips_14",star=1,equ_name="黄金甲2",base_attr={s1=21,s2=20,s3=39,s4=20},gems_type=1,gems_nums = 2,gems_attr={s1=999,s2=20,s3=39,s4=20}},
            {id=3,lv = 30,pinzhi=3,icon="role_ui_38",icon_big="equ_tips_14",star=3,equ_name="黄金甲3",base_attr={s1=3,s2=20,s3=39,s4=20},gems_type=1,gems_nums = 2,gems_attr={s1=56,s2=20,s3=39,s4=20}},
            {id=4,lv = 50,pinzhi=4,icon="role_ui_38",icon_big="equ_tips_14",star=4,equ_name="黄金甲4",base_attr={s1=2,s2=20,s3=39,s4=20},gems_type=1,gems_nums = 2,gems_attr={s1=2,s2=10,s3=39,s4=20}},
            {id=5,lv = 3,pinzhi=5,icon="role_ui_38",icon_big="equ_tips_14",star=5,equ_name="黄金甲5",base_attr={s1=5,s2=2,s3=39,s4=20},gems_type=1,gems_nums = 2,gems_attr={s1=6,s2=20,s3=39,s4=20}},
            {id=6,lv = 0,pinzhi=2,icon="role_ui_38",icon_big="equ_tips_14",star=2,equ_name="黄金甲6",base_attr={s1=999,s2=5,s3=39,s4=20},gems_type=1,gems_nums = 2,gems_attr={s1=9,s2=20,s3=39,s4=20}},
            }}
end

function RoleInfoWnd:_initUI()
    local pos = {{104.5,376.5},{104.5,276.5},{104.5,176.5},{411.5,376.5},{411.5,276.5},{411.5,176.5}}
    
    local equ_info = self.m_data["equ_info"]
    for key, var in pairs(equ_info) do
    	local id = var.id
    	local pt = pos[id]
        local cell = require("game.modules.role.EquItem").new()
        cell:setData(var)
        cell:setPosition(cc.p(pt[1],pt[2]))
        self.ccb:addChild(cell)
    end
    
    self.ccb["tf_equ_name"]:setString("LV"..self.m_data["lv"].." "..self.m_data["rolename"])
    self.ccb["tf_binggan_value"]:setString(self.m_data["money"].."")
    self.ccb["tf_zuanshi_value"]:setString(self.m_data["gold"].."")
    self.ccb["tf_role_name"]:setString(self.m_data["rolename"])
    self.ccb["tf_chenghao_value"]:setString(self.m_data["chenghao"])
    self.ccb["tf_zhanli"]:setString(self.m_data["zhanli"].."")
    self.ccb["tf_gonghui"]:setString(self.m_data["gonghui"])
    self.ccb["tf_exp"]:setString(self.m_data["currentexp"].."/"..self.m_data["maxexp"])
    
    local role_attr = self.m_data["role_attr"]
    self.ccb["tf_life_value"]:setString(role_attr["s1"].."") -- 生命
    self.ccb["tf_gongji"]:setString(role_attr["s2"].."") -- 攻击
    self.ccb["tf_fangyu"]:setString(role_attr["s3"].."") -- 防御
    self.ccb["tf_baoji"]:setString(role_attr["s4"].."") -- 暴击
    self.ccb["tf_mingzhong"]:setString(role_attr["s5"].."") -- 命中
    self.ccb["tf_shanbi"]:setString(role_attr["s6"].."") -- 闪避
    self.ccb["tf_xuanyuan"]:setString(role_attr["s7"].."") -- 能量
end

function RoleInfoWnd:_initData()
	
end

function RoleInfoWnd:_closeFunc()
    global.popWndMgr:close(KONG_WNDS.ROLE_INFO_WND)
end

function RoleInfoWnd:clear()
	
end

return RoleInfoWnd