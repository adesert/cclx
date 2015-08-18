
--[[
    游戏需要的所有数据配置文件，以CSV的格式读取
    读取格式参考test,所有的配置文件加载完成之后会把表配置目录删除
]]--
local DataManager = class("DataManager")

function DataManager:ctor()
    self.configs = {}
	self:_init()
end

function DataManager:_init()
    local config = global.pathMgr:getDatas("config.txt")
    local configData = cc.FileUtils:getInstance():getStringFromFile(config)
    configData = string.split(configData,"\n")
    for key, var in pairs(configData) do
        var = string.gsub(var,"%s","")
        if var ~= "" then
            self:_loadCSV(var)    	
        end
    end    
--    local dataPath = cc.FileUtils:getInstance():fullPathForFilename("data/") --加载完成之后删除目录结构
--    cc.FileUtils:getInstance():removeDirectory(dataPath)
    print("data")
    
    local path = global.pathMgr:getDatas("test.csv")
    local kk = cc.FileUtils:getInstance():getStringFromFile(path)
    
    local t = {}
    local o = string.split(kk, "\013")
    local keys = o[2]
    keys = string.split(keys, ";")
    local fileName = tostring(keys[1])
    local data3 = keys[3]
    local index = string.find(data3,"]")
    if index and index>0 then
        local d = json.decode(data3)
        print(d)
    else
        local ds = data3
    end
    
    local str1 = "[1,2,3,[4,5,6],[10,20]]"
    local str2 = "hello"
    local sign = string.find(str2,"]")
    local d = json.decode(str1)
    print(d)
end

------------------------------------- get data ---------------------------------------
function DataManager:getConfigDatas(fileName,keys)
	local files = self.configs[tostring(fileName)]
	if not files then
		return nil
	end
	if not keys then
		return files
	end
	return files[tostring(keys)]
end

------------------------------------- end get data ---------------------------------------
function DataManager:stringToTable(str)
    local s = string.gsub(str,"{","")
    s = string.gsub(s,"}","")
    s = string.split(s,",")
    return s
end

function DataManager:_loadCSV(name)
    local path = global.pathMgr:getDatas(name .. ".csv")
    local kk = cc.FileUtils:getInstance():getStringFromFile(path)
    local t = {}
    local o = string.split(kk, "\013")
    local keys = o[1]
    keys = string.split(keys, ";")
    local fileName = tostring(keys[1])
    for i=2,#o do
        local os = o[i]
        os = string.split(os, ";")
        local keyName = tostring(os[1])
        local ot = {}
        for j = 2,#os do 
            local strX = os[j]
            local sign = string.find(os[j],"{")
            if sign and sign>0 then
            	strX = self:stringToTable(strX)
            end
            if type(strX) == "table" then
                for key, var in pairs(strX) do
                    local sign2 = string.find(var,"|")
                    if sign2 and sign2>0 then
                        var = string.split(var,"|")
                        strX[key] = var
                    end
                end
            end
            
            ot[tostring(keys[j])] = strX
        end
        t[keyName] = ot
    end
    self.configs[tostring(fileName)] = t
end

return DataManager