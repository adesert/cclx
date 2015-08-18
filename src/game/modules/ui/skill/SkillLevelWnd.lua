
local SkillLevelWnd = class("SkillLevelWnd",require("game.base.BaseLayer"))

function SkillLevelWnd:ctor()
	self.super.ctor(self)
end

function SkillLevelWnd:_overrideInit()
    self:showMaskBG()
    self:setPassEvent(true)

    local ccbname = "skill_level_item"
    self.ccb = self:loadCCB(ccbname)
    --    self.ccb:setCallFunc("enter_game_func",handler(self,self._enterGame))
    self.ccb:initCCB()
    self:addChild(self.ccb)
end

function SkillLevelWnd:_enterGame()

end

return SkillLevelWnd