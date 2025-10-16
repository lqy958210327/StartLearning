local className = "SkillTimeMgr"
---@class SkillTimeMgr : SystemBase 战斗技能渲染帧事件管理器
SkillTimeMgr = Class(className, SystemBase)

---------------- Public ----------------
function SkillTimeMgr:ctor()
    self._skillEventDict = {} ---@type table<number, table<number, SkillTimeComponent>> key:entityUid, value:<number, SkillTimeComponent>
end

function SkillTimeMgr:OnInit()
    self._evtRegisterSkillEvent = function(entId, skillId) self:RegisterSkillEvent(entId, skillId) end
    self._evtUnRegisterSkillEvent = function(entId, skillId, isEnd) self:UnRegisterSkillEvent(entId, skillId, isEnd) end
    self._evtUnRegisterAll = function() self:UnRegisterAll() end
    self._evtPauseAll = function() self:PauseAll() end
    self._evtContinueAll = function() self:ContinueAll() end
    GameUpdate:Get():AddUpdate(GameUpdateID.SkillTimeMgr , self.OnFrameUpdate, self)
    EventManager.Global.RegisterEvent(EventType.RegisterSkillTimeEvent, self._evtRegisterSkillEvent)
    EventManager.Global.RegisterEvent(EventType.UnRegisterSkillTimeEvent, self._evtUnRegisterSkillEvent)
    EventManager.Global.RegisterEvent(EventType.UnRegisterAll, self._evtUnRegisterAll)
    EventManager.Global.RegisterEvent(EventType.PauseAllSkillTimeEvent, self._evtPauseAll)
    EventManager.Global.RegisterEvent(EventType.ContinueAllSkillTimeEvent, self._evtContinueAll)
end

function SkillTimeMgr:OnClear()
    GameUpdate:Get():RemoveUpdate(GameUpdateID.SkillTimeMgr)
    EventManager.Global.UnRegisterEvent(EventType.RegisterSkillTimeEvent, self._evtRegisterSkillEvent)
    EventManager.Global.UnRegisterEvent(EventType.UnRegisterSkillTimeEvent, self._evtUnRegisterSkillEvent)
    EventManager.Global.UnRegisterEvent(EventType.UnRegisterAll, self._evtUnRegisterAll)
    EventManager.Global.UnRegisterEvent(EventType.PauseAllSkillTimeEvent, self._evtPauseAll)
    EventManager.Global.UnRegisterEvent(EventType.ContinueAllSkillTimeEvent, self._evtContinueAll)
    self:OnDispose()
end

---@type fun(self:SkillTimeMgr, entityUid:number, skillTag:number) 注册技能事件
---@param entityUid number 实体UID
---@param skillTag number 技能ID
function SkillTimeMgr:RegisterSkillEvent(entityUid, skillTag)
    if not SkillHelper.HasTimeline(skillTag) then
        return
    end

    local coms = self._skillEventDict[entityUid]
    if coms == nil then
        coms = {}
        self._skillEventDict[entityUid] = coms
    end

    if coms[skillTag] ~= nil then
        LuaCallCs.ThrowException("RegisterSkillEvent Exception! entityUid:"..entityUid.."; skillTag:"..skillTag.."; is already exist")
    end

    local com = SkillTimeComponent(entityUid, skillTag)
    coms[skillTag] = com:Begin()
     --LuaCallCs.LogError("RegisterSkillEvent: "..com:ToString())
end

---@type fun(self:SkillTimeMgr, entityUid:number, skillTag:number, isEnd:boolean) 移除技能事件
---@param entityUid number 实体UID
---@param skillTag number 技能ID
---@param isEnd boolean 是否结束
function SkillTimeMgr:UnRegisterSkillEvent(entityUid, skillTag, isEnd)
    local coms = self._skillEventDict[entityUid]
    if coms == nil then
        return
    end
    local com = coms[skillTag] ---@type SkillTimeComponent
    if com ~= nil then
        com:Dispose(isEnd)
         --LuaCallCs.LogError("UnRegisterSkillEvent: "..com:ToString())
    end
    coms[skillTag] = nil
end

---@type fun(self:SkillTimeMgr) 释放全部事件
function SkillTimeMgr: UnRegisterAll()
    local event = self._skillEventDict
    if event == nil then
        return
    end

    for entityUid, _ in ipairs(event) do
        local coms = self._skillEventDict[entityUid] ---@type table<number, SkillTimeComponent>
        if coms ~= nil then
            for skillTag, _ in pairs(coms) do
                local com = coms[skillTag] ---@type SkillTimeComponent
                if com ~= nil then
                    com:Dispose(false)
                end
            end
        end
    end

    self:OnDispose()
end

---@type fun(self:SkillTimeMgr) 暂停
function SkillTimeMgr:PauseAll()
    local event = self._skillEventDict
    if event == nil then
        return
    end

    for entityUid, _ in ipairs(event) do
        local coms = self._skillEventDict[entityUid] ---@type table<number, SkillTimeComponent>
        if coms ~= nil then
            for skillTag, _ in pairs(coms) do
                local com = coms[skillTag] ---@type SkillTimeComponent
                if com ~= nil then
                    com:Pause()
                end
            end
        end
    end
end

---@type fun(self:SkillTimeMgr) 继续
function SkillTimeMgr:ContinueAll()
    local event = self._skillEventDict
    if event == nil then
        return
    end

    for entityUid, _ in ipairs(event) do
        local coms = self._skillEventDict[entityUid] ---@type table<number, SkillTimeComponent>
        if coms ~= nil then
            for skillTag, _ in pairs(coms) do
                local com = coms[skillTag] ---@type SkillTimeComponent
                if com ~= nil then
                    com:Continue()
                end
            end
        end
    end
end




---------------- Private ----------------
---@private 释放
function SkillTimeMgr:OnDispose()
    self._skillEventDict = {}
end

function SkillTimeMgr:OnFrameUpdate(deltaTime)
    for entityUid, _ in pairs(self._skillEventDict) do
        local coms = self._skillEventDict[entityUid] ---@type table<number, SkillTimeComponent>
        if coms ~= nil then
            for skillTag, _ in pairs(coms) do
                local com = coms[skillTag] ---@type SkillTimeComponent
                if com ~= nil then
                    com:OnFrameUpdate(deltaTime)
                end
            end
        end
    end
end