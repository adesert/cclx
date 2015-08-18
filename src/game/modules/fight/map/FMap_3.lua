
local FMap_3 = class("FMap_3",require("game.base.BaseLayer"))

function FMap_3:ctor(id)
    self.m_id = id
    self.m_data = nil
	self.super.ctor(self)
end

function FMap_3:clear()

end

return FMap_3