local FlyWordManager = class("FlyWordManager")

local START_POS = cc.p(center_x,center_y - 100)
local STOP_POS = cc.p(center_x,center_y + 200)

function FlyWordManager:ctor()
end

--错误码飘字(ERROR_NO_)
function FlyWordManager:error(erro_num)
	local error = getStr("ERROR_NO_" .. erro_num)
	self:_center(error)
end

--自定义飘字(SELF_DEF_KEY)
function FlyWordManager:self(self_key)
	local  self_def = getStr("SELF_DEF_" .. self_key)
	self._center(self_def)
end

--直接飘字
function FlyWordManager:show(str)
	self:_center(str)
end

function FlyWordManager:_center(str,color)
    local label = cc.Label:create()
    label:setString(str)
    
    local ttfConfig  = {}
--    ttfConfig.fontFilePath="fonts/arial.ttf"
    ttfConfig.fontSize = 30
    
--	local label = ui.newTTFLabel({
--				text = str,
--				font = nil,
--				size = 28,
--				color = ccc3(255,0,0),
--				x = START_POS.x,
--				y = START_POS.y,
--				align = ui.TEXT_ALIGN_CENTER,
--				valign = ui.TEXT_VALIGN_CENTER
--		})
	-- label:setFontName("tmp/fonts/DFYuanW7-GBK.ttf")
	label:setPosition(START_POS)
    label:setTTFConfig(ttfConfig)
	label:setColor(cc.c3b(255,0,0))
    local action = cc.EaseExponentialIn:create(cc.MoveTo:create(1,STOP_POS))
	local call = cc.CallFunc:create(function() label:removeFromParent() end)
	global.sceneMgr:getLayer(LAYER_TYPE.MSG_LAYER):addChild(label)
	label:runAction(cc.Sequence:create({action,call}))
end

return FlyWordManager