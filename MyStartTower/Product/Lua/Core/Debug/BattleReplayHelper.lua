-- 战场回放记录工具
-- 包括记录   读取记录相关的接口

-- zh  2017-7-27


local TablePickle = require("Core/Debug/TablePickle")
local FileUtils = Framework.Tools.FileUtils

local BattleReplayHelper = {}

BattleReplayHelper.filterDict = {" kCSMsgRelayInputNotify", "kCSMsgObjMoveNotify", "kCSMsgObjMove", "kCSMsgHeartBeat",}
--"kCSMsgAOIEnterNotify",  "kCSMsgAOILeaveNotify"
function BattleReplayHelper.initRecorder(fileKey)
    local recorder = {}
    local filename = string.format("%s", os.date("%d_%H_%M_%S"))
    filename = filename.."_"..fileKey
    filename = FileUtils.GetAndCreatePathInDoc("//Replay").."/"..filename..".replay"
    recorder.file = io.open(filename, "a")
    if not recorder.file then
       return nil, string.format("file `%s' could not be opened for writing", filename)
    end
    recorder.file:setvbuf("line")

    recorder.Record = function (self, data)
        local strData = TablePickle.pickle(data)
        if strData then
            self.file:write(strData.."\n")
            self.file:flush()
        end
    end
    recorder.Close = function (self)
        self.file:flush()
        self.file:close()
    end
    return recorder
end

function BattleReplayHelper.getAllRecorder()
    local allReplay = {"无", }
    local path = FileUtils.GetAndCreatePathInDoc("//Replay")
    local strList = FileUtils.GetFilesName(path)
    local a = strList:ToTable()
    for index = 0, strList.Length-1 do
        local fileName = strList[index]
        fileName = string.sub(fileName, #path, -8)
        table.insert(allReplay, fileName)
    end
    return allReplay
end

function BattleReplayHelper.getRecorderData(recordName)
    local filename = FileUtils.GetAndCreatePathInDoc("//Replay").."/"..recordName..".replay"
    local f = io.open(filename, "r")
    if not f then
       return nil
    end
    local dataStr = ""
    for line in f:lines() do
        dataStr = dataStr..line
    end
    local data = TablePickle.unpickle(dataStr)
    --print("zh------------- data", data.maxFrame, data.frameData, data.battleServerInfo)
    return data
end

function BattleReplayHelper.getRecorderData1(recordName)
    -- local filename = FileUtils.GetAndCreatePathInDoc("//Replay").."/"..recordName..".replay"
    local filename = "D:/ThorWindows/Replay/"..recordName
    local f = io.open(filename, "r")
    if not f then
       return nil
    end
    local dataStr = ""
    for line in f:lines() do
        dataStr = dataStr..line
    end
    local data = TablePickle.unpickle(dataStr)
    return data
end

return BattleReplayHelper