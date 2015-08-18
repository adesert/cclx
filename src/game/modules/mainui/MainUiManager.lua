--
-- Author: dawn
-- Date: 2014-10-30 11:32:15
--
local MainUiManager = class("MainUiManager", require("game.managers.BaseManager"))

require("game.modules.mainui.item.MapConsts")

function MainUiManager:ctor()
	MainUiManager.super.ctor(self)

	self.mapData = require("game.modules.mainui.MapData").new()
	
	self:_init()
end

function MainUiManager:_init()
	global.popWndMgr:register(GAME_MAIN_UI, handler(self,self._openMainUI),handler(self, self._closeMainUI))
	global.popWndMgr:register(GAME_LEVEL_MAP,handler(self, self._openLvMap),handler(self, self._closeLvMap))
	global.popWndMgr:register(GAME_START_UI,handler(self, self._openStartUI),handler(self, self._closeStartUI))

	self:registerFn(TOUCH_LEVEL_EVENT,handler(self, self._touchLevelFunc))
end

function MainUiManager:_openMainUI( )
	if not self.main_ui then
		self.main_ui = require("game.modules.mainui.MainUI").new()
		global.sceneMgr:getLayer(LAYER_TYPE.MAIN_UI_LAYER):addChild(self.main_ui)
	end
end

function MainUiManager:_closeMainUI( )
	if self.main_ui then
		self.main_ui:removeFromParent()
		self.main_ui = nil
	end
end

--------- 关卡 -----------
function MainUiManager:_openLvMap( )
	if not self.lv_map then
		self.lv_map = require("game.modules.mainui.LevelMap").new()
		global.sceneMgr:getLayer(LAYER_TYPE.MAP_LAYER):addChild(self.lv_map)
	end
end

function MainUiManager:_closeLvMap( )
	if self.lv_map then
		self.lv_map:clear()
		self.lv_map:removeFromParent()
		self.lv_map = nil
	end
end

----------------- 开始游戏准备界面 ----------------------

function MainUiManager:_openStartUI( )
	if not self.start_ui then
		self.start_ui = require("game.modules.mainui.StartUI").new()
		global.sceneMgr:getLayer(LAYER_TYPE.MAIN_UI_LAYER):addChild(self.start_ui)
	end
	
	self:_closeMainUI()
end

function MainUiManager:_closeStartUI( )
	if self.start_ui then
		self.start_ui:clear()
		self.start_ui:removeFromParent()
		self.start_ui = nil
	end

	self:_openMainUI()
end

-------------------- 点击关卡事件 --------------------
function MainUiManager:_touchLevelFunc(lyid,lvid,lytype)
	print(lyid,lvid,lytype)
--	self:_openStartUI()
	
--    self:_closeMainUI()
    
    global.popWndMgr:open(WND_NAME.LEVEL_ENTER_WNDS,lyid,lvid,lytype)
end

return MainUiManager