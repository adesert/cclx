
--- 被击特效
local CommonEffect = class("CommonEffect",require("game.creature.BaseEffect"))

function CommonEffect:ctor(id,parent,creature)
    self.super.ctor(self,id,parent,creature)
end

function CommonEffect:_overrideUpdate( duration, curTime )
    	
end

function CommonEffect:_overrideActionComplete()
	self:dispose()
end

return CommonEffect