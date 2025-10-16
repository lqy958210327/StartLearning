


-- 简化接口:获取账号相关的信息，只负责取值，不负责赋值
local tab = {}

function tab.PlayerUid()--玩家Uid
    ---@type BBClassAccountInfo
    local data = Blackboard.ReadBBItemTable(BbKey.Global, BbItemKey.AccountInfo)
    return data.Uid
end

function tab.PlayerName()--玩家名字
    ---@type BBClassAccountInfo
    local data = Blackboard.ReadBBItemTable(BbKey.Global, BbItemKey.AccountInfo)
    return data.Name
end

function tab.PlayerNameCD()--玩家改名字CD
    ---@type BBClassAccountInfo
    local data = Blackboard.ReadBBItemTable(BbKey.Global, BbItemKey.AccountInfo)
    return data.TimeModifyName
end

function tab.PlayerLv()--玩家等级
    ---@type BBClassAccountInfo
    local data = Blackboard.ReadBBItemTable(BbKey.Global, BbItemKey.AccountInfo)
    return data.Level
end

function tab.PlayerPower()--玩家战斗力
    ---@type BBClassAccountInfo
    local data = Blackboard.ReadBBItemTable(BbKey.Global, BbItemKey.AccountInfo)
    return data.Power
end

function tab.PlayerExp()--玩家当前经验
    ---@type BBClassAccountInfo
    local data = Blackboard.ReadBBItemTable(BbKey.Global, BbItemKey.AccountInfo)
    return data.Exp
end

function tab.PlayerExpMax()--玩家经验最大值
    ---@type BBClassAccountInfo
    local data = Blackboard.ReadBBItemTable(BbKey.Global, BbItemKey.AccountInfo)
    return data.ExpMax
end

function tab.PlayerExpProgress()--玩家经验进度百分比
    ---@type BBClassAccountInfo
    local data = Blackboard.ReadBBItemTable(BbKey.Global, BbItemKey.AccountInfo)
    return data.ExpProgress
end

function tab.PlayerSignature()--玩家签名
    ---@type BBClassAccountInfo
    local data = Blackboard.ReadBBItemTable(BbKey.Global, BbItemKey.AccountInfo)
    return data.Signature
end

function tab.PlayerSignatureCD()--玩家改签名CD
    ---@type BBClassAccountInfo
    local data = Blackboard.ReadBBItemTable(BbKey.Global, BbItemKey.AccountInfo)
    return data.TimeModifySignature
end

function tab.PlayerHeadID()--玩家当前佩戴的头像ID
    ---@type BBClassAccountInfo
    local data = Blackboard.ReadBBItemTable(BbKey.Global, BbItemKey.AccountInfo)
    return data.HeadID
end

function tab.PlayerFrameID()--玩家当前佩戴的头像框ID
    ---@type BBClassAccountInfo
    local data = Blackboard.ReadBBItemTable(BbKey.Global, BbItemKey.AccountInfo)
    return data.FrameID
end

function tab.PlayerTitleID()--玩家当前佩戴的称号ID
    ---@type BBClassAccountInfo
    local data = Blackboard.ReadBBItemTable(BbKey.Global, BbItemKey.AccountInfo)
    return data.TitleID
end

function tab.PlayerNameCardID()--玩家当前佩戴的名片ID
    ---@type BBClassAccountInfo
    local data = Blackboard.ReadBBItemTable(BbKey.Global, BbItemKey.AccountInfo)
    return data.NameCardID
end

function tab.PlayerMedalIDs()--玩家当前佩戴的勋章列表
    ---@type BBClassAccountInfo
    local data = Blackboard.ReadBBItemTable(BbKey.Global, BbItemKey.AccountInfo)
    return data.MedalIDs
end

function tab.PlayerServerName()--玩家所在服务器
    ---@type BBClassAccountInfo
    local data = Blackboard.ReadBBItemTable(BbKey.Global, BbItemKey.AccountInfo)
    return data.ServerName
end

function tab.PlayerGuildID()--玩家所在工会ID
    ---@type BBClassAccountInfo
    local data = Blackboard.ReadBBItemTable(BbKey.Global, BbItemKey.AccountInfo)
    return data.GuildID
end

function tab.PlayerGuildName()--玩家所在工会名字
    ---@type BBClassAccountInfo
    local data = Blackboard.ReadBBItemTable(BbKey.Global, BbItemKey.AccountInfo)
    return data.GuildName
end

function tab.PlayerHeadList()--玩家已有的头像列表
    ---@type BBClassAccountInfo
    local data = Blackboard.ReadBBItemTable(BbKey.Global, BbItemKey.AccountInfo)
    return data.HeadList
end

function tab.PlayerFrameList()--玩家已有的头像框列表
    ---@type BBClassAccountInfo
    local data = Blackboard.ReadBBItemTable(BbKey.Global, BbItemKey.AccountInfo)
    return data.FrameList
end

function tab.PlayerTitleList()--玩家已有的称号列表
    ---@type BBClassAccountInfo
    local data = Blackboard.ReadBBItemTable(BbKey.Global, BbItemKey.AccountInfo)
    return data.TitleList
end

function tab.PlayerNameCardList()--玩家已有的名片列表
    ---@type BBClassAccountInfo
    local data = Blackboard.ReadBBItemTable(BbKey.Global, BbItemKey.AccountInfo)
    return data.NameCardList
end

function tab.PlayerMedalList()--玩家已有的勋章列表
    ---@type BBClassAccountInfo
    local data = Blackboard.ReadBBItemTable(BbKey.Global, BbItemKey.AccountInfo)
    return data.MedalList
end

function tab.PlayerMainStory()--玩家主线进度
    ---@type BBClassAccountInfo
    local data = Blackboard.ReadBBItemTable(BbKey.Global, BbItemKey.AccountInfo)
    return data.MainStageID
end

function tab.PlayerHardMainStory()--玩家困难主线进度
    ---@type BBClassAccountInfo
    local data = Blackboard.ReadBBItemTable(BbKey.Global, BbItemKey.AccountInfo)
    return data.HardMainStageID
end
---@param msg SC_AvatarData[]
function tab.SetDecorateList(msg)--玩家装饰数据
    ---@type BBClassAccountInfo
    local bbItem = Blackboard.ReadBBItemTable(BbKey.Global, BbItemKey.AccountInfo)
    bbItem:SetDecorateList(msg)
end
---@param msg SC_AvatarData[]
function tab.DelDecorateList(msg)--删除玩家装饰数据
    ---@type BBClassAccountInfo
    local bbItem = Blackboard.ReadBBItemTable(BbKey.Global, BbItemKey.AccountInfo)
    bbItem:DelDecorateList(msg)
end

Util.Account = tab
