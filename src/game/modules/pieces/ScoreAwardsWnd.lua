
--- 游戏结算奖励
local ScoreAwardsWnd = class("ScoreAwardsWnd",require("game.base.BaseLayer"))

function ScoreAwardsWnd:ctor()
    self.super.ctor(self)
end

function ScoreAwardsWnd:_overrideInit()
    self:setPassEvent(true)
    self:showMaskBG()
end

return ScoreAwardsWnd