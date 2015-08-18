--
-- Author: dawn
-- Date: 2014-11-03 10:45:44
--
local LevelItem = class("LevelItem", function ( )
	return cc.Layer:create()
end)

function LevelItem:ctor(lyid,lvid)
	self.ly_id = lyid					-- 层级
	self.lv_id = lvid 					-- 	关卡id
end

function LevelItem:setData(data)
	self.m_data = data
	self:_setLevelState(self.m_data.state)
end

function LevelItem:_setLevelState(state)
	self.state = state
	local sp = nil
	if state == LEVEL_CONFIG.LEVEL_CLOSE then
        sp = cc.Sprite:createWithSpriteFrame(cc.SpriteFrameCache:getInstance():getSpriteFrame("map_level_disabled.png"))
        sp:setAnchorPoint(cc.p(0,0))
        self:addChild(sp)
	elseif state == LEVEL_CONFIG.LEVEL_OPEN then
        sp = cc.Sprite:createWithSpriteFrame(cc.SpriteFrameCache:getInstance():getSpriteFrame("map_level_nor.png"))
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

function LevelItem:_touchLevelFunc()
    global.mainMgr:applyFn(TOUCH_LEVEL_EVENT,self.ly_id,self.lv_id,LEVEL_CONFIG.LEVEL_NOR)
end

return LevelItem