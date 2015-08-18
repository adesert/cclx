local socket = require("socket")
--毫秒定时器
local TimeUtil = class("TimeUtil")

--得到毫秒级时间
function TimeUtil:getTime()
--	return global.mathUtil:getIntPart(socket.gettime() * 1000)
end

-- 得到 00:00:00 时间格式 
function TimeUtil:getTimeString(second)
	local s = second%60
	local min = math.floor(second / 60) % 60
	local h = math.floor(second/3600)
	local secondBody
	local minuteBody 
	local  hourBody 
	if h == 0 and min == 0 and s == 0 then 
		secondBody = "00"
	elseif s < 10 then
		secondBody = "0"..s 
	else 
		secondBody = s
	end
	if h == 0 and min == 0 then
		minuteBody = "00:"
	elseif min < 10 then
		minuteBody = "0"..min..":"
	else
		minuteBody = min..":"
	end
	if h == 0  then
		hourBody = "00:"
	elseif h < 10  then
		hourBody = "0"..h..":"
	else 
		hourBody = h..":"
	end
	return hourBody..minuteBody..secondBody
end 

-- 得到 00:00 时间格式 
function TimeUtil:getShortTimeString(second)
	if second >= 3600 then
		return TimeUtil:getTimeString(second)
	else
		local s = second%60
		local min = math.floor(second / 60) % 60
		local secondBody
		local minuteBody 
		local  hourBody 
		if min == 0 and s == 0 then 
			secondBody = "00"
		elseif s < 10 then
			secondBody = "0"..s 
		else 
			secondBody = s
		end
		if min == 0 then
			minuteBody = "00:"
		elseif min < 10 then
			minuteBody = "0"..min..":"
		else
			minuteBody = min..":"
		end
		return minuteBody..secondBody
    end
end 

-- 得到 0 天 0 小时 0 分 0 秒
function TimeUtil:getDateString(seconds)
	local days  = math.floor(seconds / (60 * 60 * 24))
	seconds = seconds % (60 * 60 * 24)
	local hours  = math.floor(seconds / (60 * 60))
	seconds = seconds % (60 * 60)
	local minites = math.floor(seconds / 60)
	seconds = seconds % 60;
	return days .. getStr("specialactivity_day") .. hours .. getStr("specialactivity_hour") .. minites .. getStr("specialactivity_minute") .. seconds .. getStr("specialactivity_second");
end

return TimeUtil