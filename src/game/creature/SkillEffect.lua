
local SkillEffect = class("SkillEffect",require("game.creature.BaseEffect"))

function SkillEffect:ctor(id,parent,creature)
    self.super.ctor(self,id,parent,creature)
end

function SkillEffect:_overrideUpdate( duration, curTime )
--    combat_op.handleAttackSkillsEffect(self)
end

function SkillEffect:_overBaseAttackFn(i)
    combat_op.handleAttackSkillsEffect(self)
end

return SkillEffect