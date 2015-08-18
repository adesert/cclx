
local SkillManager = class("SkillManager",require("game.managers.BaseManager"))

function SkillManager:ctor()
	self.super.ctor(self)
	
	self:_init()
end

function SkillManager:_init( )
    global.popWndMgr:register(SHOT_WNDS.GAME_SKILL_WND, handler(self,self._openSkillWnd),handler(self, self._closeSkillWnd))
    global.popWndMgr:register(SHOT_WNDS.SKILL_LEVEL_UI,handler(self,self._openLevelWnd),handler(self,self._closeLevelWnd))
    global.popWndMgr:register(SHOT_WNDS.SKILL_WEAPON_UI,handler(self,self._openWeaponWnd),handler(self,self._closeWeaponWnd))
end

function SkillManager:_openSkillWnd()
    if not self.m_wnd then
        self.m_wnd = require("game/modules/ui/skill/SkillWnd").new()
        global.sceneMgr:getLayer(LAYER_TYPE.WND_LAYER):addChild(self.m_wnd)
    end
end

function SkillManager:_closeSkillWnd()
    if self.m_wnd then
        self.m_wnd:clear()
        self.m_wnd:removeFromParent()
        self.m_wnd = nil
    end
end

function SkillManager:_openLevelWnd()
    if not self.m_level_wnd then
        self.m_level_wnd = require("game/modules/ui/skill/SkillWeaponWnd").new()
        global.sceneMgr:getLayer(LAYER_TYPE.WND_LAYER):addChild(self.m_level_wnd)
    end
end

function SkillManager:_closeLevelWnd()
    if self.m_level_wnd then
        self.m_weapon_wnd:clear()
        self.m_weapon_wnd:removeFromParent()
        self.m_weapon_wnd = nil
    end
end

function SkillManager:_openWeaponWnd()
    if not self.m_weapon_wnd then
        self.m_level_wnd = require("game/modules/ui/skill/SkillLevelWnd").new()
        global.sceneMgr:getLayer(LAYER_TYPE.WND_LAYER):addChild(self.m_weapon_wnd)
    end
end

function SkillManager:_closeWeaponWnd()
    if self.m_level_wnd then
        self.m_level_wnd:clear()
        self.m_level_wnd:removeFromParent()
        self.m_level_wnd = nil
    end
end

return SkillManager