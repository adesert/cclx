

----------------- 游戏配置数据 ------------------------


-- design resolution
CONFIG_SCREEN_WIDTH = 1136
CONFIG_SCREEN_HEIGHT = 640

--CONFIG_SCREEN_WIDTH = 800
--CONFIG_SCREEN_HEIGHT = 480

-- auto scale mode
--CONFIG_SCREEN_AUTOSCALE = "FIXED_WIDTH"

cc.Director:getInstance():setDisplayStats(true) 					-- 显示FPS
cc.Director:getInstance():setAnimationInterval(1.0 / 60)			-- 刷新频率
cc.Director:getInstance():getOpenGLView():setDesignResolutionSize(CONFIG_SCREEN_WIDTH, CONFIG_SCREEN_HEIGHT, cc.ResolutionPolicy.EXACT_FIT)

local winSize = cc.Director:getInstance():getWinSize()
center_x = winSize.width / 2
center_y = winSize.height / 2
screen_w = winSize.width
screen_h = winSize.height
screen_left = 0
screen_right = winSize.width
screen_top = winSize.height
screen_bottom = 0

-------------------------------------------------------------
define_centerx = CONFIG_SCREEN_WIDTH/2
define_centery = CONFIG_SCREEN_HEIGHT/2

define_w = CONFIG_SCREEN_WIDTH
define_h = CONFIG_SCREEN_HEIGHT
define_left = 0
define_right = CONFIG_SCREEN_WIDTH
define_top = CONFIG_SCREEN_HEIGHT
define_bottom = 0
--------------------------------------------------------------

language = cc.Application:getInstance():getCurrentLanguage() --cc.LANGUAGE_ENGLISH
platform = cc.Application:getInstance():getTargetPlatform()

print("language,platform--->",language,platform)
--print(string.format("# CONFIG_SCREEN_AUTOSCALE      = %s", CONFIG_SCREEN_AUTOSCALE))
print(string.format("# CONFIG_SCREEN_WIDTH          = %0.2f", CONFIG_SCREEN_WIDTH))
print(string.format("# CONFIG_SCREEN_HEIGHT         = %0.2f", CONFIG_SCREEN_HEIGHT))
--print(string.format("# display.widthInPixels        = %0.2f", display.widthInPixels))
--print(string.format("# display.heightInPixels       = %0.2f", display.heightInPixels))
--print(string.format("# display.contentScaleFactor   = %0.2f", display.contentScaleFactor))
print(string.format("# screen_w                = %0.2f", screen_w))
print(string.format("# screen_h               = %0.2f", screen_h))
print(string.format("# center_x                   = %0.2f", center_x))
print(string.format("# center_y                   = %0.2f", center_y))
print(string.format("# screen_left                 = %0.2f", screen_left))
print(string.format("# screen_right             = %0.2f", screen_right))
print(string.format("# screen_top                 = %0.2f", screen_top))
print(string.format("# screen_bottom             = %0.2f", screen_bottom))
--print(string.format("# display.c_left               = %0.2f", display.c_left))
--print(string.format("# display.c_right              = %0.2f", display.c_right))
--print(string.format("# display.c_top                = %0.2f", display.c_top))
--print(string.format("# display.c_bottom             = %0.2f", display.c_bottom))
print("#")

