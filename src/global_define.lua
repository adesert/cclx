
-- 生物实体属性
--TODO 人物属性键值定义
-- 1~5000 	int
-- 5000以上	string
ATTR_DEFINE ={
	NAME = 10001,
	DESC = 10002,
	CCB = 10003,				--ccb资源 <<
	COLLIDER_Y = 10004,		--碰撞深度
	ICON = 10005,
	HALF_ICON = 10006,
	CLASS = 10007,				--职业
	MODEL_ID = 10008,			--模型表id
	ID = 10009,				--人物id 本地生成的id
	SKILLS = 10010,			-- 技能
	PARENT = 10011,			--是把特效放到哪个层上面
	POS = 10012,				-- {0,0}坐标
	TYPE = 10013,				--生物类型 <<
	USE_SKILLS = 10014,		-- 战斗的时候队长可使用的技能,已经激活的技能
	STARS = 10015,			-- 星级
	TEAM = 10016,			-- （1 为同一队伍）
	RANGE = 10017,			-- 攻击距离 像素
	NORMAL_SKILLS = 10018,	-- 普通攻击
	MOVE_SPEED = 10019,			--移动速度
	isCaptain = 10020,			-- 是否是队长（队长是属于英灵的）（0 不是队长，1是队长
	STAR = 10021,				-- 星级
	SPEED = 10022,             --移动速度
    HDX = 10023,               -- 成长系数
    
    
    --skill_config
    SKILLID = 20000,        -- 当前技能id
    SKILL_EFFECT = 20001,      -- 当前技能ccb
    SKILL_ICON = 20002,        -- 
    ACTION_NAME = 20003,       -- 技能动作
    SKILL_TYPE = 20004,        -- 技能类型
    ATTACK_RANGE = 20005,      -- 进攻距离
    SKILL_COLD_CD = 20006,     -- 技能冷却时间
    SKILL_BEATTACK_EFFECT = 20008,-- 被击特效
    AI_TYPE = 200009,               -- AI 类型
    SKILL_ACTION_TYPE = 2000010,    -- 技能动作类型
    SKILL_F_EFFECT = 2000011,       -- 发射特效
    MODEL_ID_X = 2000012,             -- 模型id
    
    -- 武器配置
    WEAPON_ATTACK_VALUE = 3000,         --攻击属性
    WEAPON_CRIT_VALUE = 3001,           -- 暴击百分比
    WEAPON_ZI_DAN = 3002,               -- 子弹数量
    WEAPON_SKILL_ID = 3003,             -- 技能id
    
    ---- spine config key
    SPINE_JSON_STR = 3004,               -- spine 的json 文件
    SPINE_ALAS_STR = 3005,               -- spine 的 alas 文件
}
--------------------生物体相关定义开始--------------------------
CREATURE_TYPE = {
	PLAYER = 1,
	MONSTER = 2,					--怪物
	BOSS = 3,						--BOSS
	XIANJING = 4,                   -- 陷阱
}

--生物朝向
DIRECTION = {
	LEFT = 1,
	RIGHT = 2,
}

--生物动作时间轴名字(除此之外还有数量不固定的skill_形式的技能时间轴)
CREATURE_ACTION_NAME = {
	STAND = "stand",	--待机动作（循环）
	MOVE = "run",		--移动动作（循环）
--	ATTACK = "attack",     -- 攻击
	HURT = "attacked",		--被击动作
	DIE = "die",		--死亡动作
--	SKILL1 = "skill1", -- 技能动作
}

---- 攻击类型
CREATURE_ATTACK_TYPE = {
    ATTACK = 1,     -- 普通攻击
    SKILL = 2,      -- 技能攻击
}

--- 飞行特效常量
VITRO_CONSTS_TYPE = {
    NO = 0,
    YES = 1,
}

-- 状态机
MACHINE_STATE_TYPE = {
    STAND = 1,
    MOVE = 2,
    ATTACK = 3,
    HURT = 4,
    DIE = 5,
    SKILL = 6,
}

--- 移动方向
CREATURE_MOVE_DIR = {
    RIGHT = 1,      -- 右
    UP = 2,         -- 上
    LEFT = 3,       -- 左
    DOWN = 4,       -- 下
}

-------------------------------特效相关定义开始----------------------------------

EFFECT_PARENT = {
	SLEF_DEFINE = 1,			--自定义层
	BOTTOM_LAYER = 2,			--底层特效层
	TOP_LAYER = 3,				--顶层特效层
	OBJECT_BOTTOM = 4,			--生物底层
	OBJECT_TOP = 5 				--生物顶层
}

EFFECT_STATE = {
	WAIT = 1,				--等待播放
	READY = 2,				--准备播放		
	RUNING = 3,				--正在播放		 
	RUBBISH = 4				--等待回收		
}

EFFECT_CALLBACK = {
    BEGIN = 0,
    END = 1,
}

-----------------------------------层类型定义开始--------------------------------------

LAYER_TYPE = {
	LOGIN_LAYER = 1000,							--登录,注册
	MAP_LAYER = 1001,							--地图层
	DOWN_EFF_LAYER = 1003,						--生物下层特效层
	THINGS_LAYER = 1004,						--生物层
	UP_EFF_LAYER = 1005,						--生物上层特效层（掉落等）
	TOUCH_LAYER = 1006,							-- 触摸层（战斗摇杆控制）
	MAIN_UI_LAYER = 1007,						--主UI层（主界面，战斗界面）
	WND_LAYER = 1008,							--面板层
	MSG_LAYER = 1009,							--消息层（HTTP请求层）
	LOADING_LAYER = 1010						--LOADING层
}

MAP_TYPE = {
    MAP_BG_LAYER = 1002,                       -- 地图背景层
    DOWN_EFF_LAYER = 1003,                      --生物下层特效层
    THINGS_LAYER = 1004,                        --生物层
    UP_EFF_LAYER = 1005,                        --生物上层特效层（掉落等）
}

--英灵颜色（根据英灵星级而定）
PLAYER_COLOR = {
    [1] = cc.c3b(255,255,255),      --白
    [2] = cc.c3b(0,255,0),          --绿
    [3] = cc.c3b(0,0,255),          --蓝
    [4] = cc.c3b(138,43,226),           --紫
    [5] = cc.c3b(255,215,0)         --金
}

---- 地图数据配置 --------
MAP_CONFIG = {
    RES = "RES",    -- 地图资源
    POS = "POS",    -- 出生位置
}

----$$$$#####$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
-------------------------------- 生物事件定义 ------------------------------
--生物事件类型
CREATURE_EVENT = {
	USE_SKILL = "USE_SKILL",							--收到使用技能指令
	HURT = "HURT",										--被击
	ACTION_HURT_COMPLETE = "ACTION_HURT_COMPLETE",		--被击动作播放完毕
	ACTION_SKILL_COMPLETE = "ACTION_SKILL_COMPLETE",	--技能动作播放完毕
	MOVE = "MOVE",										--人物移动指令
	HP_NULL = "HP_NULL",								--血量为0
	STOP_MOVE = "STOP_MOVE",							--停止移动指令
	POS_CHANGE = "POS_CHANGE",							--位置改变事件
	DIE_ACTION="DIE_ACTION"								-- 死亡动作播放完
}

--影响状态机的事件
CREATURE_STATE_EVENT = {
	CREATURE_EVENT.USE_SKILL,
	CREATURE_EVENT.HURT,
	CREATURE_EVENT.ACTION_HURT_COMPLETE,
	CREATURE_EVENT.ACTION_SKILL_COMPLETE,
	CREATURE_EVENT.MOVE,
	CREATURE_EVENT.HP_NULL,
	CREATURE_EVENT.STOP_MOVE,
	CREATURE_EVENT.POS_CHANGE,
	CREATURE_EVENT.DIE_ACTION
}

-- 事件和生物状态联系
CREATURE_COM = {
	[CREATURE_EVENT.USE_SKILL] = 4,
	[CREATURE_EVENT.HURT] = 3,
	[CREATURE_EVENT.MOVE] = 2,
	[CREATURE_EVENT.DIE_ACTION] = 1
}

--生物状态
CREATURE_STATE = {
	IDLE = 1,			--待机
	MOVE = 2,			--移动
	HURT = 3,			--僵直
	USE_SKILL = 4,		--攻击
	DIE = 6			    --死亡
}

----------------------------------------------------生物体相关定义结束----------------------------------------------
------- ai define
AI_DEFINE = {
    PLAYER_AI = 0,                  -- 玩家AI
    MONSTER_AI_1 = 1,               -- 怪物AI1
    MONSTER_AI_2 = 2,               -- 怪物AI2
    MONSTER_AI_3 = 3,               -- 怪物AI3
    MONSTER_AI_4 = 4,               -- 
    MONSTER_AI_5 = 5,               -- 
    XIANJING_AI_1 = 6,                -- 陷阱AI
}

------ 特效类型
EFFECT_TYPE = {
    COMMON_EFFECT = 0,          -- 普通特效
    COMMON_NO_EFFECT = 1,       -- 普通攻击无特效
    SKILL_EFFECT = 2,           -- 技能特效 普通攻击特效
    VITRO_EFFECT = 3,           -- 飞行特效
    CHUANSONGMEN_EFFECT=4,      -- 传送门
}

--- 关卡中 怪物触发条件
MONSTER_CONDITIONS = {
    TIME = 1,               --- 时间
    HP = 2,                 --- 血量
    SPACE = 3,              --- 到达某一点（触发）
}

GAME_SCREEN_TYPE = {
    ONE = 1,        --- 第一屏
    TWO = 2,        --- 第二屏
}


