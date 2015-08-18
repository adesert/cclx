--游戏钩子  关键节点的准备工作
local game_hook = {}

--游戏更新钩子
function game_hook.on_update()
	 SCHE_MGR = require("ex_framework.scheduler")
end

--进入游戏钩子
function game_hook.on_enterGame()
	require("global")
	 global.initBase()
	 global.initModules()
end

return game_hook