--
-- Author: dawn
-- Date: 2014-10-21 15:23:10
--
local LoadingWnd = class("LoadingWnd", require("game/base/BaseLayer"))

function LoadingWnd:ctor()
    self.super.ctor(self)
	self:_init()
end

function LoadingWnd:_init()

end

function LoadingWnd:clear()
	
end

return LoadingWnd