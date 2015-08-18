local MonsterVitro = class("MonsterVitro",require("game.creature.BaseEffect"))

function MonsterVitro:ctor(id,parent,creature)
    self.super.ctor(self,id,parent,creature)
end

function MonsterVitro:_overrideUpdate( duration, curTime )
    local vx,vy = self:getPosition()
    local dir = self:getDirection()
    if dir == DIRECTION.RIGHT then
        vx = vx+20
    else
        vx = vx-20
    end
    if vx < define_left or vx > define_right then
        self:dispose()        
    else
        self:setPosition(vx,vy)    
        combat_op.handleAttackSkillsEffect(self)
    end
end

--function MonsterVitro:setDirection(dir)
--    self.m_direction = dir
--    if dir == DIRECTION.LEFT and self:getScaleX() ~= 1 then
--        self:setScaleX(1)                                                                                                                                                                                                       
--    elseif dir == DIRECTION.RIGHT and self:getScaleX() ~= -1 then
--        self:setScaleX(-1)
--    end
--end

return MonsterVitro