--存储全局变量

require("global_define")
require("module_consts")
require("game.base.lan_tool")
require("game.combat.combat_op")

global = {
	proto = nil,
	sceneMgr = nil,			--场景管理（全局只有一个场景）
	httpMgr = nil,
	timeUtil = nil,
	mathUtil = nil,
	commonFunc = nil,
	pathMgr = nil,
	mapMgr = nil,
	uicenterMgr = nil,
	localMgr = nil,
--	gameStateMgr = nil,
	platformMgr = nil,
	flyWordMgr = nil,
	popWndMgr = nil,
	objMgr = nil,
	effectMgr = nil,
	soundMgr = nil,
	dataMgr = nil,
	AIMgr = nil,
	currentPlayer = nil,
	cameraMgr = nil,
	frameCacheMgr = nil,
	httpMgr = nil,
	loadingMgr = nil,
}

--TODO  初始化基础模块 程序一运行即初始化 
function global.initBase()
	global.httpMgr = require("network.http.HttpManager").new()
	global.mathUtil = require("tools.MathUtil").new()
	global.timeUtil = require("tools.TimeUtil").new()
	-- math.randomseed(global.timeUtil:getTime())
	global.commonFunc = require("tools.CommonFunc").new()
	global.pathMgr = require("game.managers.PathManager").new()	
	global.proto = require("proto.test_data")
	global.popWndMgr = require("game.managers.PopWindowManager").new()
--	global.gameStateMgr = require("game.managers.GameStateManager").new()
	global.sceneMgr = require("game.global_scene.GlobalSceneManager").new()
	global.uicenterMgr = require("game.uicenter.UICenterManager").new()
	global.mapMgr = require("game.map.MapManager").new()
	global.effectMgr = require("game.managers.EffectManager").new()
	global.effectMgr:start()
	global.objMgr = require("game.managers.ObjectsManager").new()
	global.objMgr:start()
	global.soundMgr = require("game.managers.SoundManager").new()
    global.localMgr = require("game.managers.LocalManager").new()
    global.dataMgr = require("game.managers.DataManager").new()
--    global.AIMgr = require("game.managers.AIManager").new()
    global.cameraMgr = require("game.map.CameraManager").new()
    global.frameCacheMgr = require("game.managers.FrameSpriteCacheManager").new()
	-----------------------
	global.flyWordMgr = require("game.managers.FlyWordManager").new()
	global.platformMgr = require("game.platform.PlatformManager").new()
	global.httpMgr = require("game.managers.HttpManager").new()
end

--TODO  各模块的manager在此定义(进入主场景之前初始化)
function global.initModules()
	global.loginMgr = require("game.modules.login.LoginManager").new()
--	global.mainMgr  = require("game.modules.mainui.MainUiManager").new()
--	global.gamingMgr = require("game.modules.gaming.GamingManager").new()
--	global.shopMgr = require("game.modules.shop.ShopManager").new()
--	global.taskMgr = require("game.modules.task.TaskManager").new()
--	
--    global.piecesMgr = require("game.modules.pieces.PiecesManager").new()
--    global.mapLevelMgr = require("game.modules.map.LevelMapManager").new()

--    global.loginMgr = require("game.modules.login.LoginManager").new()
    global.shotMgr = require("game/modules/shotting/ShottingManager").new()
--    global.loginMgr = require("game.modules.ui.login.LoginManager").new()
    global.skillMgr = require("game.modules.ui.skill.SkillManager").new()
    global.pieceMgr = require("game.modules.ui.pieces.PiecesManager").new()
    global.shopMgr = require("game.modules.ui.shop.ShopManager").new()
    global.mainUIMgr = require("game.modules.ui.mainui.MainUIManager").new()
    
    global.testMgr = require("game.modules.test.TestManager").new()
    
    global.hardMgr = require("game.modules.hard.HardManager").new()
    global.mainCityMgr = require("game/modules/maincity/MainCityManager").new()
    global.levelMgr = require("game.modules.level.LevelManager").new()
    global.cityMgr = require("game.modules.citymap.CityMapManager").new()
    global.fightMgr = require("game.modules.fight.FightManager").new()
    global.loadingMgr = require("game.modules.loading.LoadingManager").new()
    global.roleMgr = require("game.modules.role.RoleInfoManager").new()
end
