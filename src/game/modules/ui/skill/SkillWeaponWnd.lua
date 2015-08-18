
local SkillWeaponWnd = class("SkillWeaponWnd",require("game.base.BaseLayer"))

function SkillWeaponWnd:ctor()
	self.super.ctor(self)
end

function SkillWeaponWnd:_overrideInit()
    self:showMaskBG()
    self:setPassEvent(true)

    local ccbname = "skill_weapon_ui"
    self.ccb = self:loadCCB(ccbname)
    --    self.ccb:setCallFunc("enter_game_func",handler(self,self._enterGame))
    self.ccb:initCCB()
    self:addChild(self.ccb)
end

function SkillWeaponWnd:_enterGame()
end

return SkillWeaponWnd