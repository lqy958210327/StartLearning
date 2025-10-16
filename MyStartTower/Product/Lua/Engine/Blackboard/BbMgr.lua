
---@class BbMgr 黑板管理器
BbMgr = Class("BbMgr")

function BbMgr:ctor()
    ---@type BbMgr
    self._instance = nil
    ---@type table<number, BbBase>
    self._bbDict = {}
end

function BbMgr:Get()
    if self._instance == nil then
        self._instance = BbMgr()
    end
    return self._instance
end

function BbMgr:Init()

end

function BbMgr:Clear()
    for k, v in pairs(self._bbDict) do
        v:InternalClear()
    end
    self._bbDict = {}
end

---@param key number
---@param bb BbBase
function BbMgr:RegisterBB(key, bb)
    if self._bbDict[key] then
        return
    end
    bb:InternalInit(key)
    self._bbDict[key] = bb
end

function BbMgr:GetBB(key)
    if key then
        return self._bbDict[key]
    end
    return nil
end
