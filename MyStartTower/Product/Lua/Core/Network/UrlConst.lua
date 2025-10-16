local UrlConst = {}

------------------- Login --------------------------
--UrlConst.ACCID_LOCAL = "accid"
UrlConst.Last_UID = "oc_game_last_uid"
UrlConst.Last_UNAME = "oc_game_last_uname"

------------------- NETWORK --------------------------
UrlConst.GM_FUNCTION_OPEN = GameInitialize.GM_FUNCTION_OPEN

local NETWORK_ADDRESS = GameInitialize.REMOTE_ADDRESS
UrlConst.NETWORK_ADDRESS_TABLE = {
    ACCOUNT = NETWORK_ADDRESS .. "/sdk/login",-- 快速登录地址 "/sdk/login_test"
    ACCOUNT_TOKEN = NETWORK_ADDRESS .. "/sdk/token/mode/release",
    SERVER = NETWORK_ADDRESS .. "/sdk/server",

    FRIEND_PULL_APP_FRIEND = NETWORK_ADDRESS .. "/cdn/namecard/uid/",
    NOTICE_REQUEST = NETWORK_ADDRESS .. "/cdn/notices",
    SERVER_GATEWAY = NETWORK_ADDRESS .. "/cdn/list",

    
    
    FRIEND_PULL_FRIEND = NETWORK_ADDRESS .. "/cdn/friends",
    FRIEND_ALL_PULL_APP_FRIEND = NETWORK_ADDRESS .. "/cdn/namecards",
    FRIEND_FIND_BY_NAME = NETWORK_ADDRESS .. "/cdn/search/name/",
}
UrlConst.NETWORK_ADDRESS = NETWORK_ADDRESS
--print("NETWORK_ADDRESS_TABLE", table.dump(UrlConst.NETWORK_ADDRESS_TABLE))

return UrlConst