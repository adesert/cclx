
cc.FileUtils:getInstance():addSearchPath("src")
cc.FileUtils:getInstance():addSearchPath("res")

--cc.FileUtils:getInstance():getSearchPaths() -- 可写路径
-- cclog
local cclog = function(...)
    print(string.format(...))
end

-- for CCLuaEngine traceback
function __G__TRACKBACK__(msg)
    cclog("----------------------------------------")
    cclog("LUA ERROR: " .. tostring(msg) .. "\n")
    cclog(debug.traceback())
    cclog("----------------------------------------")
    return msg
end

require ("cocos.init")
require("ex_framework.init")
require("config")
require("NodeEx")
require("game/base/VisibleRect")

local status, msg = xpcall(function ( )
	collectgarbage("collect")
    -- avoid memory leak
    collectgarbage("setpause", 100)
    collectgarbage("setstepmul", 5000)

	require("game").update()
end, __G__TRACKBACK__)

if not status then
    error(msg)
end
