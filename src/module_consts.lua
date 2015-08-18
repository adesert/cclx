

WND_NAME = {
    SOCRE_AWARDS = "SOCRE_AWARDS",                  -- 分关分数结算界面
    LEVEL_ENTER_WNDS = "LEVEL_ENTER_WNDS",          -- 进入战斗前关卡进入界面
    SHOP_WNDS = "SHOP_WNDS",                        -- 商城
    TILI_BUYS = "TILI_BUYS",                        -- 体力快速购买
    LEVEL_MAP = "LEVEL_MAP",                        -- 关卡地图
    LOGIN_WNDS = "LOGIN_WNDS",                      -- 登陆界面
    FAILURE_WND = "FAILURE_WND",                    -- 通关失败
    WIN_WND = "WIN_WNDS",                           -- 成功
    FIGHTING_IN =  "FIGHTING_IN",                   -- 战斗中，let's go ,let's go
    test_ui = "test_ui",
}

--- 消息通信loading
GAME_HTTP_LOADING = "GAME_HTTP_LOADING"

----------------------------- game ----------------------------------
---------------- 加载页面 -------------
GAME_LOADING_UI = "GAME_LOADING_UI"


-----------------------------------------------------------

------------ 登陆 ------------------

GAME_LOGIN_WND = "GAME_LOGIN_WND"

------------ 游戏设置 ----------------

GAME_SET_WND = "GAME_SET_WND"

------------ 礼包 ------------

GAME_GIFT_WND = "GAME_GIFT_WND"

------------ 主界面 --------------

GAME_MAIN_UI = "GAME_MAIN_UI"

------------  打开关卡地图 ---------

GAME_LEVEL_MAP = "GAME_LEVEL_MAP"

-----------  开始游戏准备ui ---------

GAME_START_UI = "GAME_START_UI"
GAING_ON_UI = "GAING_ON_UI"				---- 游戏进行中得ui

GAME_SHOP_WND = "GAME_SHOP_WND"			-- 商城

SEVEN_DAY_WND = "SEVEN_DAY_WND" 		-- 每日登陆奖励
TASK_WND = "TASK_WND" 		-- 任务


----------------------------------- 存储本地数据的data key -------------------------------------------

MAP_DATA ="MAP_DATA"		-- 关卡数据key


----------------------------------- end 存储本地数据的data key -------------------------------------------

---------------###############################################################

KONG_WNDS = {
    CREATE_ROLE_WND = "CREATE_ROLE_WND",
    SELECTE_ROLE_WND = "SELECTE_ROLE_WND",
    MAIN_CITY_WND = "MAIN_CITY_WND",
    LEVEL_WND = "LEVEL_WND",
    CITY_MAP_WND = "CITY_MAP_WND",
    FIGHT_LAYER = "FIGHT_LAYER",
    ROLE_INFO_WND = "ROLE_INFO_WND",
    ROLE_INFO_TIPS_WND = "ROLE_INFO_TIPS_WND",
}

KONG_EVNET = {
    UPDATE_CITY_MAP_MOVE_DIR = "UPDATE_CITY_MAP_MOVE_DIR",
    UPDATE_CITY_MAP_END_DIR = "UPDATE_CITY_MAP_END_DIR",
    UPDATE_MAP_MOVE_DIR = "UPDATE_MAP_MOVE_DIR",
    UPDATE_MAP_MAP_END_DIR = "UPDATE_MAP_MAP_END_DIR",
}

--------------##################################################

---- 射击ui
SHOT_WNDS = {
    TEST_WND = "TEST_WNDxxxxxx",
    FIGHT_UI = "FIGHT_UI",
    FIGHT_WND = "FIGHT_WND",
    ROCKER_WND = "ROCKER_WND",
    GAME_FIGHT_WIN_WND = "GAME_FIGHT_WIN_WND",                      -- 战斗胜利
    GAME_FIGHT_FAIL_WND = "GAME_FIGHT_FAIL_WND",                    -- 战斗结束
    GAME_LOGIN_WND = "GAME_LOGIN_WND",                              -- 登陆
    GAME_SKILL_WND = "GAME_SKILL_WND",                              --  技能升级
    GAME_SHOP_WND = "GAME_SHOP_WND",                                -- 商店
    BEGAIN_GAME_WND = "BEGAIN_GAME_WND",                            -- 开始游戏UI
    BEGAIN_GAME_FIGHT = "BEGAIN_GAME_FIGHT",                        -- 开始战斗UI(站前准备UI)
    SKILL_LEVEL_UI = "SKILL_LEVEL_UI",                              -- 技能升级UI
    SKILL_WEAPON_UI = "SKILL_WEAPON_UI",                            -- 武器UI
    GAME_MAIN_UI = "GAME_MAIN_UI",                                  -- 主界面
    START_GAME_UI = "START_GAME_UI",                                -- 开始游戏ui
    FIGHT_FAILURE_WND = "FIGHT_FAILURE_WND",                        -- 失败结算
    FIGHT_WIN_WND = "FIGHT_WIN_WND",                                -- 胜利结算
}


GAME_EVENTS = {
    CHANGE_SHOT_MAN_DIR = "CHANGE_SHOT_MAN_DIR",    -- 改变移动方向
    WEAPON_SHOT_SKILLS = "WEAPON_SHOT_SKILLS",      -- 释放技能
    RESTART_GAME_TEST = "RESTART_GAME_TEST",        -- 重新开始测试
    UPDATE_ROLE_HD_VALUE = "UPDATE_ROLE_HD_VALUE",  -- 更新玩家血条
    UPDATE_LEVEL_LEFT_TIME = "UPDATE_LEVEL_LEFT_TIME_EX",  -- 更新关卡剩余时间
    OPEN_BAOYI_EVENT = "OPEN_BAOYI_EVENT",          -- 打开爆衣
    CLOSE_BAOYI_EVENT = "CLOSE_BAOYI_EVENT",        -- 关闭爆衣
    UPDATE_SKILL_PANNEL_DATA = "UPDATE_SKILL_PANNEL_DATA",-- 更新技能面板数据
}

----------------##########################################################################################

--- 关卡相关
LEVEL_CONFIGS = {
    STAR_CONDITIONS_0 = 0,          -- 通关一星的条件（杀死副本中所有怪物）
    STAR_CONDITIONS_1 = 1,          -- 剩余血量百分多少获得
    STAR_CONDITIONS_2 = 2,          -- 最短通关时间（秒）
}

--- 钱币
MONEY_KEY = {
    DIAMON = 0,     --钻石
    GOLD = 1,       -- 金币
    EXP = 2,        -- 经验
    PROP = 3,       -- 道具
}

--------------------------------------
SF_WNDS = {
    LOGIN_WNDS = "LOGIN_WNDS",
    HELPER_WND = "HELPER_WND",
    NORMAL_SF = "NORMAL_SF",
    SPECIAL_SF = "SPECIAL_SF",
}

