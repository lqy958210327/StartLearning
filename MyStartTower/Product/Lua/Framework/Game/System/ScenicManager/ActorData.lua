
---@enum 表演者类型
ActorType = {
    Model = 0, ---@type number 模型
    Timeline = 1, ---@type number 时间轴
}

local className = "ActorData"
---@class ActorData 表演者数据
ActorData = Class(className)

function ActorData:ctor()
    self._actorTag = 0 ---@type number 表演者id(用于读取ResCommonModel表)
    self._suggest = "" ---@type string 用于读取模型表的字段名称。
    self._enterClip = "" ---@type string 进入动画名称
end

---@type fun(assetPath: string): ActorData 配置资源路径
function ActorData:WithTag(actorTag)
    self._actorTag = actorTag
    return self
end

---@type fun(): number 表演者id(用于读取ResCommonModel表)
function ActorData:GetTag()
    return self._actorTag
end

---@type fun(suggest: string): ActorData 配置表演者的推荐类型
function ActorData:WithSuggest(suggest)
    self._suggest = suggest
    return self
end

---@type fun(): "" 获取表演者的推荐类型
function ActorData:GetSuggest()
    return self._suggest
end

---@type fun(clipName: string): ActorData 配置进入动画名称
function ActorData:WithEnterClip(clipName)
    self._enterClip = clipName or ""
    return self
end

---@type fun(): string 获取进入动画名称
function ActorData:GetEnterClip()
    return self._enterClip
end

---@type fun(other: ActorData): boolean 比较表演者数据
function ActorData:Equal(other)
    if not other then
        return false
    end
    if self._actorTag ~= other:GetTag() then
        return false
    end

    if self._suggestType ~= other:GetType() then
        return false
    end

    if self._enterClip ~= other:GetEnterClip() then
        return false
    end

    return true
end