--[[
    数字
]]--

local ImgNumber = class("ImgNumber",function ()
	return cc.Node:create()
end)

function ImgNumber:ctor(n)
    self.n = n
    self.sp = {}
    self.ws = 0
    self:_init()
end

function ImgNumber:_init()
    self:clear()
    
    local str = tostring(self.n)
    local len = string.len(str)
    for i=1,len do
        local c = string.sub(str,i,i)
        local path = global.pathMgr:getNums("num_"..c)
        local sp = cc.Sprite:create(path)
        sp:setPosition(self.ws,0)
        self.ws = sp:getBoundingBox().width + self.ws + 10
        self:addChild(sp)
        table.insert(self.sp,sp)
    end
end

function ImgNumber:clear()
    for key, var in pairs(self.sp) do
    	var:removeFromParent()
    end
    self.sp = {}
end

return ImgNumber