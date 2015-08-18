
local Vitro = class("Vitro",require("game.creature.BaseEffect"))

function Vitro:ctor(id,parent,creature)
    self.super.ctor(self,id,parent,creature)
    
    self:_timerFunc()
end

function Vitro:_timerFunc()
    self.virtroPosx = nil
end

function Vitro:_overBaseAttackFn(i)
    combat_op.handleAttackByAirto(self,i)
end

function Vitro:_overrideUpdate( duration, curTime )
    local vx,vy = self:getPosition()
    local dir = self:getDirection()
    if not self.virtroPosx then
        self.virtroPosx = vx
    end
    if dir == DIRECTION.RIGHT then
        vx = vx+20
    else
        vx = vx-20
    end
    local rid = math.random(1,2)
    if rid == 1 then
    	vy = vy+2
    else
        vy = vy-2
    end
--    print("---->",vx+define_w,vx)
    if math.abs(vx-self.virtroPosx)>center_x then
        self:dispose()
    else
        self:setPosition(vx,vy)
        combat_op.handleAttackSkillsEffect(self)
    end
end

return Vitro