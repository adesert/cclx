local GlobalSceneManager = class("GlobalSceneManager")

function GlobalSceneManager:ctor()
	self.m_scene = nil
	self.game_stage = nil
end

function GlobalSceneManager:enterGame()
	self.m_scene = require("game.global_scene.GlobalScene").new()
	self:_initLayers()

    global.uicenterMgr:init()

	if cc.Director:getInstance():getRunningScene() then
        cc.Director:getInstance():replaceScene(self.m_scene)
    else
        cc.Director:getInstance():runWithScene(self.m_scene)
    end
end

function GlobalSceneManager:getLayer(type)
	return self.m_stage:getChildByTag(type)
end

-- 得到地图的层级
function GlobalSceneManager:getMapLayer(type)
	local map = self:getLayer(LAYER_TYPE.MAP_LAYER)
	return map:getChildByTag(type)
end

function GlobalSceneManager:_initLayers()
    --  self.m_stage = cc.Sprite:create("game_stage.png")
    --  self.m_stage:setPosition(center_x,center_y)
    --  self.m_scene:addChild(self.m_stage)

	-- self.m_stage = self.m_scene
	
    self.m_stage = cc.Layer:create()
--    self.m_stage = cc.ClippingRectangleNode:create(cc.rect(0,0,CONFIG_SCREEN_WIDTH,CONFIG_SCREEN_HEIGHT))
    self.m_stage:setPosition(0, (screen_h-CONFIG_SCREEN_HEIGHT)/2)
	self.m_scene:addChild(self.m_stage)
    
	local layer = cc.Layer:create()
	layer:setTag(LAYER_TYPE.LOGIN_LAYER)
	self.m_stage:addChild(layer) 
    
    local map = cc.Layer:create()
    map:setTag(LAYER_TYPE.MAP_LAYER)
    self.m_stage:addChild(map)
    
    local mapBg = cc.Layer:create()
    mapBg:setTag(MAP_TYPE.MAP_BG_LAYER)
    map:addChild(mapBg)
    
    local mape = cc.Layer:create() -- 地图特效层
    mape:setTag(MAP_TYPE.DOWN_EFF_LAYER)
    map:addChild(mape)
    
    local mapt = cc.Layer:create()  -- 地图人物
    mapt:setTag(MAP_TYPE.THINGS_LAYER)
    map:addChild(mapt)
    
    local mapue = cc.Layer:create() -- 上层特效
    mapue:setTag(MAP_TYPE.UP_EFF_LAYER)
    map:addChild(mapue)

    local layer = cc.Layer:create()
	layer:setTag(LAYER_TYPE.DOWN_EFF_LAYER)
	self.m_stage:addChild(layer)
	
    local layer = cc.Layer:create()
    layer:setTag(LAYER_TYPE.THINGS_LAYER)
    self.m_stage:addChild(layer)

    local layer = cc.Layer:create()
	layer:setTag(LAYER_TYPE.UP_EFF_LAYER)
	self.m_stage:addChild(layer)
	
    local layer = cc.Layer:create()
    layer:setTag(LAYER_TYPE.TOUCH_LAYER)
    self.m_stage:addChild(layer)

    local layer = cc.Layer:create()
	layer:setTag(LAYER_TYPE.MAIN_UI_LAYER)
	self.m_stage:addChild(layer)

    local layer = cc.Layer:create()
	layer:setTag(LAYER_TYPE.WND_LAYER)
	self.m_stage:addChild(layer)

    local layer = cc.Layer:create()
	layer:setTag(LAYER_TYPE.MSG_LAYER)
	self.m_stage:addChild(layer)

    local layer = cc.Layer:create()
	layer:setTag(LAYER_TYPE.LOADING_LAYER)
	self.m_stage:addChild(layer)
end

return GlobalSceneManager