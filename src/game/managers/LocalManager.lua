
require("json")
--本地数据管理
local LocalManager = class("LocalManager")

LOCAL_DATA_KEY = {
    ID = "id",          -- ID
    GOLD = "gold",      -- 宝石
    PROPS = "props",    -- 道具
    TILI = "tili",      -- 体力
    LEVEL_DATA = "level_data",-- 关卡数据（每个关卡得分，星级）
    ROLE_INFO = "ROLE_INFO",    -- 玩家信息
}

local DATA_KEY = "xx_antxxaaaxaaxa"

function LocalManager:ctor()
    self:_init()
end

function  LocalManager:_init()
--    print(cc.FileUtils:getInstance():getWritablePath())
    local data = self:getDataValue(DATA_KEY)
    if data == "" then
        self:_initData()
    else
        self.m_data = data
    end
--    self:_initData()
end

function LocalManager:_initData()
    local dpi = cc.Device:getDPI()
    local gold = 0
    local props = {
        p_1 = {id = 1,nums = 3,state = 0},
        p_2 = {id = 2,nums = 3,state = 0},
        p_3 = {id = 3,nums = 3,state = 0}
    }
    local roleInfo = {{lv=0,roleid=0,rolename="",id =1},{lv=0,roleid=0,rolename="",id=2}}
    local tili = 5
    local level_data = {
        level_1 = {id = 1,score = 0,star = 0,state = 0}
    }
    local data = {
        id = dpi,
        gold = gold,
        props = props,
        tili = tili,
        level_data = level_data,
        ROLE_INFO = roleInfo,
    }
    self.m_data = data
    self:setDataValue(DATA_KEY,self.m_data)
end

function LocalManager:_flush()
    cc.UserDefault:getInstance():flush()
end

function LocalManager:getDataValue(key)
    local data = cc.UserDefault:getInstance():getStringForKey(key)
    if not data or data == "" then
        return ""
    end
    data = json.decode(data)
    return data
end

function LocalManager:setDataValue(key,value)
    value = json.encode(value)
    cc.UserDefault:getInstance():setStringForKey(key,value)
    self:_flush()
end
--------------------------------------------------------------
function LocalManager:setDataByKey(key,value)
    self.m_data[key] = value
    self:setDataValue(DATA_KEY,self.m_data)
end

function LocalManager:getDataByKey(key,keyname)
    local data = self.m_data[key]
    if keyname then
        data = data[keyname]
    end
    return data
end

--function LocalManager:_encode(str)
--	return crypto.encryptAES256(str,ENCODE_STR)
--end
--
--function LocalManager:_decode(str)
--	return crypto.decryptAES256(str,ENCODE_STR)
--end

return LocalManager