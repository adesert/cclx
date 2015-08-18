local HttpManager = class("HttpManager")

require("network.http.HttpMsg")

function HttpManager:ctor()
	self.msg_deals = {}
    self.m_server_url = nil
end

function HttpManager:initServer(server)
    self.m_server_url = server
end

function HttpManager:register(msg,func)
	if not self.msg_deals[msg] then
		self.msg_deals[msg] = {}
	end
	table.insert(self.msg_deals[msg],func)
end

function HttpManager:send(msgname,msgbody,lock_msg)
    
end

function HttpManager:unRegister(msg)
	local m = self.msg_deals[msg]
	if not m then
	   return
	end
	
	self.msg_deals[msg] = nil
end

------------ 简单直接的一种HTTP通信方式 ----------------
function HttpManager:sendMsgJson(msg,func)
    msg = json.encode(msg)
    global.popWndMgr:open(GAME_HTTP_LOADING)
    local xhr = cc.XMLHttpRequest:new()
    xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_JSON
    xhr:open("POST", "http://httpbin.org/post")
    local function onReadyStateChange()
        global.popWndMgr:close(GAME_HTTP_LOADING)
        if xhr.readyState == 4 and (xhr.status >= 200 and xhr.status < 207) then
            local response   = xhr.response
            local output = json.decode(response,1)
--            table.foreach(output,function(i, v) print (i, v) end)
--            print("headers are")
--            table.foreach(output.headers,print)
            func(output)
        else
            print("xhr.readyState is:", xhr.readyState, "xhr.status is: ",xhr.status)
        end
    end

    xhr:registerScriptHandler(onReadyStateChange)
    xhr:send(msg)
end

return HttpManager