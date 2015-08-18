
local HardManager = class("HardManager",require("game/managers/BaseManager"))

function HardManager:ctor()
    self.super.ctor(self)
    
    self:_init()
end

function HardManager:_init()
    
end

return HardManager