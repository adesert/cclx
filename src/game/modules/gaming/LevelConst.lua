
--createEdgeBox函数的第一个参数指定矩形的大小。
--第二个参数是设置材质，PHYSICSBODY_MATERIAL_DEFAULT常量是默认材质，
--材质是由结构体PhysicsMaterial定义的，
--结构体PhysicsMaterial成员有：density（密度）、friction（磨擦系数）和restitution（弹性系数）。
--密度可以用来计算物体的质量，密度可以为零或者为正数。
--摩擦系数经常会设置在0.0~1.0之间，0.0表示没有摩擦力，1.0会产生强摩擦。
--弹性系数的值通常设置到0.0~1.0之间，0.0表示物体不会弹起，1.0表示物体会完全反弹，
--即称为弹性碰撞。createEdgeBox函数的第三个参数是设置边的宽度。

--local MATERIAL_DEFAULT = cc.PhysicsMaterial(0.1, 0.5, 0.5)

--body:setCategoryBitmask(1)
--body:setContactTestBitmask(1)
--body:setCollisionBitmask(1)

--    1 0001
--    2 0010
--    4 0100
--    6 0110
--    8 1000
--    15 1111

---- 障碍物类型
BARRYS_TYPE = {
    BALL_TYPE = 0,                      -- 发射求的类型
    BARRY_CIRCLE = 1,                   -- 圆形
    BARRY_RECT = 2,                     -- 长方形
    BARRY_TRA = 3,                      -- 梯形
    BARRY_QT_CIRCLE = 4,                -- 其他不可消除障碍物 (障碍物1，障碍物2)
    BARRY_QT_RECT = 5,                  -- 方形障碍物
    BARRY_WOOD = 6,                     -- 墙壁障碍物
    BARRY_JAR_TARGET = 7,               -- 目标罐子
    BARRY_DOT = 8,                      -- dot
    BARRY_Triangle = 9,                 -- 三角形障碍物
    BARRY_GOAL = 10,                    -- 进球啦
    BARRY_LINEBODY = 11,                -- 直线
    BARRY_COMBAT_BLOCK = 12,            -- 疯狂奖励
    BARRY_BLOCK_T = 13,                 -- 块碰撞
}

BARRY_COLOR = {
    NORMAL = 1,                  -- 正常 100
    YELLOW = 2,                 -- 黄色 1000
    BLUE = 3,                   -- 蓝色 500 而且有特效（不同的关卡可消除不同的区域障碍物）
    RED = 4                     -- 红色 500
}

BARRY_SCORES = {sc_1 = 100,sc_2 = 1000,sc_3 = 500,sc_4 = 500}

-------------------- ccb 配置参数 -----------------------------
-- circle_normal_1; circle_red_1  circle_yellow_1 circle_blue_1 圆形
-- rect_normal_1; rect_red_1; rect_yellow_1; rect_blue_1;  方形
-- tra_normal_1; tra_red_1; tra_yellow_1; tra_blue_1;      梯形
--BARRY_COLORS = {"normal","red","yellow","blue"}
BARRY_COLORS_TYPE = {normal = BARRY_COLOR.NORMAL,red = BARRY_COLOR.RED,yellow = BARRY_COLOR.YELLOW,blue = BARRY_COLOR.BLUE}

BARRY_COLOR_NAME = {"normal","yellow","blue","red"}
---------------------END CCB ---------------------------------

--- 小球发射速度
BALL_SHOT_SPEED = 10

--- 碰撞的时候给他一个速度，通过角度得到速度的x,y
BALL_MOVE_SPEED_V = 1000

---- 处理碰撞小球事件 ---------
BALL_CONTACTED_EVENT = "BALL_CONTACTED_EVENT"

---- 小球在罐子上得半径
BALL_G_RS = 51  -- 发射小球在发射台上的位置

--------------------------------------- 关卡事件 ------------------------------------------
LEVEL_EVENT = {
    UPDATE_MY_SCORE = "UPDATE_MY_SCORE",                        -- 更新分数
    COLLISION_EVENTS = "COLLISION_EVENTS",                      -- 碰撞事件
    UPDATE_TASK_BARRY_NUMS = "UPDATE_TASK_BARRY_NUMS",          -- 更新剩余目标数量
    RESTART_GAME = "RESTART_GAME",                              -- 重新开始游戏
    UPDATE_STEP_NUMS = "UPDATE_STEP_NUMS",                      -- 更新剩余步数
    UPDATE_LEFT_PROPS_NUMS = "UPDATE_LEFT_PROPS_NUMS",          -- 更新剩余道具数量
    CLICK_PROPS_EVENT = "CLICK_PROPS_EVENT",                    -- 点击道具
--    XIAOQIU_XIALUO_PINGMUZHIWAI = "XIAOQIU_XIALUO_PINGMUZHIWAI",-- 消除小球
    REMOVE_BODYS_EVENT = "REMOVE_BODYS_EVENT",                  -- 删除障碍物
}

------ 碰撞类型 --------
COLLISION_EVENT = {
    BEGAIN = 1,         -- 开始接触
    SOVE = 2,           -- 持续接触
    SEPERATE = 3,       -- 分离
}

------ 罐子移动的最大角度 -------
GOLD_BALL_MAX_DU = 70

-----------------------------------------------------
-- 小球
ball_x_1 = 1
ball_x_2 = 1
ball_x_3 = 1
ball_x_4 = 8000

circle_x_1 = 1
circle_x_2 = 1
circle_x_3 = 1
circle_x_4 = 8000

rect_x_1 = 0.7
rect_x_2 = 0.7
rect_x_3 = 0.7
rect_x_4 = 200

tars_x_1 = 1
tars_x_2 = 1
tars_x_3 = 1
tars_x_4 = 200

tar_x_1 = 1
tar_x_2 = 1
tar_x_3 = 1
tar_x_4 = 200

