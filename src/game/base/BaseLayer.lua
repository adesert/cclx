
local BaseLayer = class("BaseLayer",function ()
	return cc.Layer:create()
end)

---------------------------
--@param
--@return
function BaseLayer:ctor()
    self:_overrideInit()
end

---------------------------
--@param
--@return
function BaseLayer:_overrideInit()

end


---------------------------
--@param
--@return
function BaseLayer:showMaskBG()
    self.maskLayer = cc.LayerColor:create(cc.c4b(0,0,0,130))
    self.maskLayer:setContentSize(cc.size(screen_w,screen_h))
    self:addChild(self.maskLayer,-1)
end

function BaseLayer:setMaskWH(w,h)
	if self.maskLayer then
	   self.maskLayer:setContentSize(cc.size(w,h))
	end
end

function BaseLayer:clearMask()
    if self.maskLayer then
        self.maskLayer:removeFromParent()
        self.maskLayer = nil
    end
end

---------------------------
--@param
--@return
function BaseLayer:loadCCB(ccbname)
	local ccb = require("game.base.BaseCell").new(ccbname)
	return ccb
end

---------------------------
--@param 是否屏蔽事件冒泡到下层
--@return
function BaseLayer:setPassEvent(s)
    if not s then
        return
    end
    local function onBegan(touch,event)
        return true
    end
	if s == true then
        self.listener = node_touchEvent(self,onBegan,nil,nil,nil)
	end
end

function BaseLayer:removePassEvent()
    if self.listener then
        self:getEventDispatcher():removeEventListener(self.listener)    
    end
end

---------------------------
--@param
--@return
function BaseLayer:clear()
	
end

return BaseLayer