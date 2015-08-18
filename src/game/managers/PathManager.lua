--路径管理
local PathManager = class("PathManager")

function PathManager:ctor()

end

-- ccb
function PathManager:getCCB(name)
    return "ccb/" .. name .. ".ccbi"
end

-- 数据
function PathManager:getDatas(name)
	return "data/" .. name
end

-- pics
function PathManager:getPics(name)
    return "pics/" .. name
end

--ui路径
function PathManager:getUI(id)
    return "ui/" .. id .. ".ccbi"
end

-- map
function PathManager:getMap(id)
    return "map/"..id ..".png"
end

function PathManager:getMapTmx(id)
    return "map/" .. id .. ".tmx"
end

-- 特效，技能
function PathManager:getEffect(id)
    return "effects/" .. id .. ".ccbi"
end

------##########################################################################

-- fight img
function PathManager:getFightImg(name)
    return "pics/fight/"..name ..".png"
end

-- 数字
function PathManager:getNums(name)
    return "pics/numbers/"..name .. ".png"
end
--
function PathManager:getWinImg(name)
    return "pics/win/" .. name .. ".png"
end

-- level ccbi
function PathManager:getLevelCCB(id)
	return "level/" .. id .. ".ccbi"
end


function PathManager:getCircleRes(id)
    return "pics/bodys/circle/" ..id .. ".png"
end
function PathManager:getladderRes(id)   -- 梯形
    return "pics/bodys/ladder/" .. id ..".png"
end
function PathManager:getBodyOtherRes(id)   -- 其他
    return "pics/bodys/other/" .. id ..".png"
end
function PathManager:getRectRes(id) -- 矩形
    return "pics/bodys/rect/" .. id .. ".png"
end
function PathManager:getTriangleRes(id) -- 三角形
    return "pics/bodys/triangle/" .. id .. ".png"
end

function PathManager:getGameFont(id)
	return "pics/font/" .. id 
end

function PathManager:getPicUI(id)
	return "pics/ui/"..id .. ".png"
end

---------------------------------------------------------

--- MainMap
function PathManager:getMainMapImg(id )
	return "MainMap/" .. id .. ".png"
end

function PathManager:getTileMapTmx(id)
	return "MainMap/" .. id .. ".tmx"
end

--creatures
function PathManager:getCreature(id)
	return "creatures/" .. id .. ".ccbi"
end


-- 地图
function PathManager:getMap(id )
	return "map/" .. id .. ".png"
end

--特效声音文件
function PathManager:getEffectSound(id)
	return "sound/effect/" .. id .. ".mp3"
end

-- 场景声音
function PathManager:getMusicSound(id )
	return "sound/music/" .. id .. ".mp3"
end

--- 新资源
function PathManager:getImagesByID(id)
	return "images/" .. id .. ".png"
end


return PathManager