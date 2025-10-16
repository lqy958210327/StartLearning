


local SvrListManager = {}
local self = SvrListManager

-- local RECENT_GROUP_ID = -999
-- local RECOMMEND_GROUP_ID = -998
-- 目前svrlistManager的作用主要有三个
-- a. 登录的时候给玩家选择一个推荐服务器
-- b. 在游戏中将serverID转为serverName
-- c. 提供推荐服务器列表和全服务器列表

-- 经过服务器迭代后，服务器发给客户端的数据分成了三个部分
-- 1. 角色相关数据，包含推荐节点（完整信息）、chat和file等服务的url、该账号的已有角色服务器节点（只有节点和头像等信息）
-- 2. 服务器节点和服务器名称的映射表，用于游戏中将服务器ID转为名称。
-- 3. 全服务器节点信息，用于打开服务器列表（包括推荐和已有角色的页签）时，显示对应的服务器信息。
-- 这三个都需要在本地缓存，因为服务器可能返回响应让客户端使用本地缓存，同时这三部分数据的请求都需要设置CD。
-- 另外，在请求的时候都需要带上当前缓存的时间戳，当服务器建议使用本地缓存的时候，会返回相同的时间戳。
-- 调整：2的数据改为放在1的节点中，用|分隔。



-- 不会调用
function SvrListManager.destroy()
end

function SvrListManager.getServerName(id)
    local info = self._svrDict[id]
    return info and info.name
end

function SvrListManager.getSelectedSvrID()
    return self._selectedSvrID
end

function SvrListManager.getChatSvr()
    return self._chatSvr
end

function SvrListManager.getFileSvr()
    return self._fileSvr
end

function SvrListManager.getRaidersSvr()
    return self._raiders
end

return self
