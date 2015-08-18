
local PlatformManager = class("PlatformManager")

function PlatformManager:ctor()
    if platform == cc.PLATFORM_OS_IPAD or platform == cc.PLATFORM_OS_IPHONE then
        self.m_mgr = require("game.platform.ios.IOSManager").new()
    elseif platform == cc.PLATFORM_OS_ANDROID then
        self.m_mgr = require("game.platform.android.AndroidManager").new()
	else
        self.m_mgr = require("game.platform.android.AndroidManager").new()
	end
end

function PlatformManager:getPlatform()
	return self.m_mgr
end

return PlatformManager