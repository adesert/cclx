
local EquTipsWnd = class("EquTipsWnd",require("game.base.BaseLayer"))

function EquTipsWnd:ctor(data)
    self.m_data = data
    self.super.ctor(self)
end

function EquTipsWnd:_overrideInit()
    self:showMaskBG()
    self:setPassEvent(true)

    self.ccb = self:loadCCB("equ_tips_ui")
    self.ccb:setCallFunc("close_func",handler(self,self._closeFunc))
    self.ccb:initCCB()
    self:addChild(self.ccb)
    
    self.ccb:setPosition(center_x,center_y)

    self:_initData()
end

function EquTipsWnd:_initData()
--{id=1,lv = 10,pinzhi=1,icon="role_ui_38",star=3,equ_name="黄金甲1",base_attr={s1=999,s2=20,s3=39,s4=20},gems_type=1,gems_nums = 2,gems_attr={s1=999,s2=20,s3=39,s4=20}},

    self.ccb["tf_equ_name"]:setString(self.m_data["equ_name"])
    
    local star_pos = {cc.p(45,88),cc.p(65,88),cc.p(85,88),cc.p(104,88),cc.p(123,88)}
    local star = tonumber(self.m_data["star"])
    local sp = nil
    for i=1,star do
        sp = cc.Sprite:create("imgs/role_ui/equ_tips/equ_tips_5.png")
        sp:setPosition(star_pos[i])
        self.ccb:addChild(sp)
    end    
    
    local gems_pos = {cc.p(40,42),cc.p(72,43),cc.p(104,43),cc.p(135,43)}
    local gem_num = tonumber(self.m_data["gems_nums"])
    for i=1,gem_num do
        sp = cc.Sprite:create("imgs/role_ui/equ_tips/equ_tips_7.png")
        sp:setPosition(gems_pos[i])
        self.ccb:addChild(sp)
    end
    
    --- 白，蓝，绿，紫，橙
    local pinzhi_res = {"equ_tips_13.png","equ_tips_12.png","equ_tips_11.png","equ_tips_9.png","equ_tips_10.png"}
    local str = pinzhi_res[self.m_data["pinzhi"]]
    sp = cc.Sprite:create("imgs/role_ui/equ_tips/"..str)
    sp:setPosition(86,171)
    self.ccb:addChild(sp)
    
    sp = cc.Sprite:create("imgs/role_ui/equ_tips/"..self.m_data["icon_big"]..".png")
    sp:setPosition(87,171)
    self.ccb:addChild(sp)
    
    ---------- propery
    local att_name = {s1="生 命:",s2="攻 击:",s3="防 御:",s4="暴 击:",s5="命 中:",s6="闪 避:",s7="能 量:"}
    local attr = self.m_data["base_attr"]
    local tf_t = {{self.ccb["tf_s_1_1"],self.ccb["tf_s_1_2"]},{self.ccb["tf_s_2_1"],self.ccb["tf_s_2_2"]},{self.ccb["tf_s_3_1"],self.ccb["tf_s_3_2"]},{self.ccb["tf_s_4_1"],self.ccb["tf_s_4_2"]}}
    local counts = 0
    for key, var in pairs(attr) do
        local str = att_name[key]
        counts = counts + 1
        local tfs = tf_t[counts]
        tfs[1]:setString(str)
        tfs[2]:setString(var.."")
    end
    
    local tf_t_m = {{self.ccb["tf_m_1_1"],self.ccb["tf_m_1_2"]},{self.ccb["tf_m_2_1"],self.ccb["tf_m_2_2"]},{self.ccb["tf_m_3_1"],self.ccb["tf_m_3_2"]},{self.ccb["tf_m_4_1"],self.ccb["tf_m_4_2"]}}
    attr = self.m_data["gems_attr"] 
    counts = 0
    for key, var in pairs(attr) do
        local str = att_name[key]
        counts = counts + 1
        local tfs = tf_t_m[counts]
        tfs[1]:setString(str)
        tfs[2]:setString(var.."")
    end
end

function EquTipsWnd:_closeFunc()
	global.popWndMgr:close(KONG_WNDS.ROLE_INFO_TIPS_WND)
end

function EquTipsWnd:clear()
    
end

return EquTipsWnd