
local ChuanSongMenEffect = class("ChuanSongMenEffect",require("game.creature.BaseEffect"))

function ChuanSongMenEffect:ctor(id,parent,creature)
    self.super.ctor(self,id,parent,creature)
end

function ChuanSongMenEffect:_overrideUpdate( duration, curTime )
--    combat_op.handleAttackSkillsEffect(self)
end

function ChuanSongMenEffect:_overBaseAttackFn(i)
--    combat_op.handleAttackSkillsEffect(self)
end

return ChuanSongMenEffect