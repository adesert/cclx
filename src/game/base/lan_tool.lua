
---读取国际化文件
LanguageFile =  {}

local f = cc.FileUtils:getInstance():getStringFromFile("lan/zh_cn.txt")

assert(f,"打开国际化文件出错！！")

local lineNum = 1
for i,tmp in pairs(string.split(f, "\n")) do
	--去除空格
	tmp = string.gsub(tmp,"%s","")
	--无视注释 #开头的为注释
	if string.find(tmp,"#") ~= 1 then
		for i = 1,1 do
			local index = string.find(tmp, "=")
			if(index == nil) then
				break
			end
			local key = string.sub(tmp,1,index - 1)
			local value = string.sub(tmp,index + 1)
--			print(key,value)
			LanguageFile[key] = value
		end
	end
	lineNum = lineNum + 1
end

function getStr(key, ...)
	if LanguageFile[key]==nil then
		print("没有在国际化文件中定义此字符串！！！---->" .. key)
		return ""
	end
	local str = LanguageFile[key]
	return string.format(str, ...)
end
