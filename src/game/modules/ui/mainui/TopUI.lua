
local TopUI = class("MainUI",require("game.base.BaseLayer"))

function TopUI:ctor()
    self.super.ctor(self)
end

function TopUI:_overrideInit()
    local ccbname = "topui"
    self.ccb = self:loadCCB(ccbname)
    self.ccb:setCallFunc("role_func",handler(self,self._openRole))
    self.ccb:setCallFunc("weapon_func",handler(self,self._openWeapon))
    self.ccb:setCallFunc("skill_func",handler(self,self._openSkill))
    self.ccb:setCallFunc("shop_func",handler(self,self._openShop))
    self.ccb:setCallFunc("fight_func",handler(self,self._openFight))
    self.ccb:initCCB()
    self:addChild(self.ccb)

    --    self.ccb:setScale(0.2)
    --    local s = cc.ScaleTo:create(0.5,1)
    --    local action1 = cc.EaseBackOut:create(s)
    --    self.ccb:runAction(action1)

    self:_init()
end

function TopUI:_init()
    self.m_id = 1
    self.m_wnd = nil
    
    self.ccb["tf_name_value"]:setString("习大大")
    self.ccb["tf_lv_value"]:setString("99")
    self.ccb["tf_exp_value"]:setString("99999999")
    self.ccb["tf_gold_value"]:setString("999999")
    self.ccb["tf_diamon_value"]:setString("999999")
--    self.ccb["exp_loading"]:setContentSize(cc.size(10,36))
    self.ccb["exp_loading"]:setScaleX(0.5)
    
    self:setSelectedWnd()
end

function TopUI:_openRole()
    self.m_id = 1
    self:setSelectedWnd()
end

function TopUI:_openWeapon()
    self.m_id = 2
    self:setSelectedWnd()
end

function TopUI:_openSkill()
    self.m_id = 3
    self:setSelectedWnd()
end

function TopUI:_openShop()
    self.m_id = 4
    self:setSelectedWnd()
end

function TopUI:_openFight()
    self.m_id = 5
    self:setSelectedWnd()
end

function TopUI:setSelectedWnd()
	if self.m_wnd then
	   self.m_wnd:clear()
	   self.m_wnd:removeFromParent()
	   self.m_wnd = nil
	end
	
	if self.m_id == 1 then
		self.m_wnd = require("game.modules.ui.mainui.RoleUI").new()
	elseif self.m_id == 2 then
	   self.m_wnd = require("game.modules.ui.mainui.WeaponUI").new()
    elseif self.m_id == 3 then
        self.m_wnd = require("game.modules.ui.mainui.SkillUI").new()
    elseif self.m_id == 4 then
	   self.m_wnd = require("game.modules.ui.mainui.ShopUI").new()
	elseif self.m_id == 5 then
	   self.m_wnd = require("game.modules.ui.mainui.LevelUI").new()
	end
	
	self:addChild(self.m_wnd)
end

return TopUI