--
-- Author: dawn
-- Date: 2014-11-03 10:49:58
--

local LevelStation = class("LevelStation", function ( )
	return cc.Layer:create()
end)

function LevelStation:ctor(lyid,lvid,data)
	self.ly_id = lyid 					-- 层级
	self.station_id = lvid 				-- 大关卡id
	self.m_data = data

	self:_init()
end

function LevelStation:_init()
	self:_setState(self.m_data.state)
end

function LevelStation:_setState(state)
	local sp = nil
	local path = nil
	
	if state == LEVEL_CONFIG.LEVEL_CLOSE then 
        sp = cc.Sprite:createWithSpriteFrame(cc.SpriteFrameCache:getInstance():getSpriteFrame("map_space_station_disabled.png"))
        sp:setAnchorPoint(cc.p(0,0))
        self:addChild(sp)
	elseif state == LEVEL_CONFIG.LEVEL_OPEN then
		sp = display.newSprite("#map_space_station_nor.png")
        sp = cc.Sprite:createWithSpriteFrame(cc.SpriteFrameCache:getInstance():getSpriteFrame("map_space_station_nor.png"))
        
        local  item = cc.MenuItemSprite:create(sp,nil,nil)
        item:setEnabled(true)
        item:setAnchorPoint(cc.p(0,0))
        --        item:setPosition(100,100)
        item:registerScriptTapHandler(handler(self,self._touchLevelFunc))
        local pMenu = cc.Menu:create(item)
        self:addChild(pMenu)
        pMenu:setPosition(0,0)
	end
	
end

function LevelStation:_touchLevelFunc()
    global.mainMgr:applyFn(TOUCH_LEVEL_EVENT,self.ly_id,self.station_id,LEVEL_CONFIG.LEVEL_BOSS)
end

return LevelStation