
local SkillWnd = class("SkillWnd",require("game.base.BaseLayer"))

function SkillWnd:ctor()
	self.super.ctor(self)
end

function SkillWnd:_overrideInit()
    self:showMaskBG()
    self:setPassEvent(true)

    local ccbname = "skill_wnd"
    self.ccb = self:loadCCB(ccbname)
    self.ccb:setCallFunc("closed_func",handler(self,self._closeWnd))
    self.ccb:initCCB()
    self:addChild(self.ccb)
end

function SkillWnd:_enterGame()

end

function SkillWnd:_closeWnd()
    global.popWndMgr:close(SHOT_WNDS.GAME_SKILL_WND)
end

return SkillWnd