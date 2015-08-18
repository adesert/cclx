
local XianJing = class("XianJing",require("game.creature.BaseObject"))

function XianJing:ctor(data)
    self.super.ctor(self,data)
end

function XianJing:_overrideBaseObjectInit()
    local ai_type = self:getAttr(ATTR_DEFINE.AI_TYPE)
    self.ai = require("game.creature.machine.ai.AIFactory").getAI(ai_type)
    self.ai:init(self)
end

function XianJing:getAI()
    return self.ai
end

function XianJing:_overrideBaseObjectUpdate(duration, curTime)
    self.ai:handler()
end

function XianJing:_overrideBaseObjectAttackCall(i)
end

function XianJing:pause()
    if self.ai then
        self.ai:pause()
    end
    self.super.pause(self)
end

function XianJing:resume()
    if self.ai then
        self.ai:resume()
    end
    self.super.resume(self)
end

function XianJing:clear()
    if self.ai then
        self.ai:clear()
    end
end

return XianJing