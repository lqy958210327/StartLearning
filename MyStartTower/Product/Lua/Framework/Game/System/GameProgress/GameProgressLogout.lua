


---@class GameProgressLogout : GameProgressBase
GameProgressLogout = Class("GameProgressLogout", GameProgressBase)

function GameProgressLogout:OnInit()

end

function GameProgressLogout:OnClear()

end

function GameProgressLogout:OnEnter(lastProgress, code)

    local str = nil
    if code == 1 then
        --主动退出
        print("---   登出操作: 主动退出账号...")
    elseif code == 2 then
        --您的账号已经在异地登录!您的号可能被盗了...
        str = "你的账号已经在其他设备登录!你可能被盗了...   code:"..code
    elseif code == 3 then
        --作弊被发现了
        str = "你开挂被服务器发现了...   code:"..code
    elseif code == 5 or code == 6 then
        --与服务器断开连接
        str = "服务器断开链接，code = "..code
    elseif code == 9 then
        --您的账号被封停!
        str = "你被封号了...   code:"..code
    elseif code == 10 then
        --该账号已删除，如有疑问请联系客服
        str = "你的号被删了...   code:"..code
    elseif code == 12  then
        --您的账号在异地登录!您被别人顶号了...
        str = "你的账号在异地登录!你被别人顶号了...   code:"..code
    else
        str = "退出登录，原因未知...   code:"..code
    end

    if str then
        LuaCallCs.LogError("---   "..str)
        Util.MsgBox.OpenShowInfoAndCallBack(str, function() self:_onClickBtnYes() end)
    end

    Game.GameProgressStop()

    --老代码
    local NetService = require("Core/Network/NetService")
    NetService.StopHeartBeat()
    --老代码
end

function GameProgressLogout:OnExit()

end


function GameProgressLogout:_onClickBtnYes()
    -- 根据登出操作类型，有可能需要跳转到sdk流程
    EventManager.Global.Dispatch(EventType.GameProgressChange, GameProgressID.Blank)
end
