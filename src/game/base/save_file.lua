require("lfs")

local save_file = {}
----------------------------------------------------------------------------------------------------------
--[[
--    @param filePath
    
--    @param fileContent
--    保存文件的内容
    
--    @return true/false
--    成功返回true,失败返回false
--]]--

function save_file.saveFileFromHttpResponse(filePath, response)
	if "string" == type(filePath) then
		local fileDir = save_file.pathinfo(filePath)
		-- 目录不存在，创建
		if nil ~= fileDir.dirname and 0 < string.len(fileDir.dirname)  then
			if false == save_file.dir_exist(fileDir.dirname) then
				save_file.createDir(filePath)
			end
		end
		
		local currDir = CONFIG_UPDATE_FILE_SAVE_PATH
		local savePath = CONFIG_UPDATE_FILE_SAVE_PATH .. filePath
		print("-------saveFileFromHttpResponse:savePath：" .. savePath .. "-------")
		
		--return io.writefile(savePath, fileContent)
		return 0 <= response:saveResponseData(savePath)
	end
	return false
end


function save_file.saveFile(filePath, fileContent)
	if "string" == type(filePath) and nil ~= fileContent then
		local fileDir = save_file.pathinfo(filePath)
		-- 目录不存在，创建
		if nil ~= fileDir.dirname and 0 < string.len(fileDir.dirname)  then
			if false == save_file.dir_exist(fileDir.dirname) then
				save_file.createDir(filePath)
			end
		end
		
		local currDir = CONFIG_UPDATE_FILE_SAVE_PATH
		local savePath = CONFIG_UPDATE_FILE_SAVE_PATH .. filePath
		print("-------savePath：" .. savePath .. "-------")
		
		return io.writefile(savePath, fileContent)
	end
	return false
end


function save_file.dir_exist(dirPath)
	local result = false
	local currDir = CONFIG_UPDATE_FILE_SAVE_PATH
	local makeDir = currDir .. dirPath
	print("------save_file.dir_exist:" .. makeDir .. "------")

	if lfs.chdir(makeDir) then
		lfs.chdir(currDir)
		result = true
	end
	return result 
end


function save_file.createDir(filePath)
	local fileDir = save_file.pathinfo(filePath)

	if nil ~= fileDir.dirname  then

		local currDir = CONFIG_UPDATE_FILE_SAVE_PATH
		local dirPathTable = save_file.pairsByDir(fileDir.dirname)
		for key, value in ipairs(dirPathTable) do
			-- device.directorySeparator，目录分隔符
			currDir = currDir .. device.directorySeparator .. value
			
			lfs.mkdir(currDir)
		end
	end
end

function save_file.pairsByDir(dirPath)
    local a = {}  

	for w in string.gmatch(dirPath, "[%s%w%p]-[\\/]") do
		local index = string.find(w, "[\\/]")
		local s = (string.sub(w,1, index - 1))
		if 0 < string.len(s) then
			table.insert(a, s)
		end
	end
	return a
end 

function save_file.pathinfo(path)
    local pos = string.len(path)
    local extpos = pos + 1
    while pos > 0 do
        local b = string.byte(path, pos)
        if b == 46 then -- 46 = char "."
            extpos = pos
        elseif b == 47 or b == 92 then --
            break
        end
        pos = pos - 1
    end

    local dirname = string.sub(path, 1, pos)
    local filename = string.sub(path, pos + 1)
    extpos = extpos - pos
    local basename = string.sub(filename, 1, extpos - 1)
    local extname = string.sub(filename, extpos)
    return {
        dirname = dirname,
        filename = filename,
        basename = basename,
        extname = extname
    }
end


return save_file


