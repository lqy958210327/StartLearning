local strClassName = "UrlGroupLegacy"
local UrlGroupLegacy = Class(strClassName)
-- 因为老版本c#没有URLGroup，为了逻辑统一，在lua层模仿UrlGroup实现一套机制
-- 构造函数。
function UrlGroupLegacy:ctor(urls)
    if nil == urls or nil == next(urls) then
        urls = {""}
    else
        urls = utils.copyTable(urls)
    end
    self.index = 1
    self.append = nil
    self.count = #urls
    self._urls = urls
end

function UrlGroupLegacy:Next()
    self.index = self.index % self.count + 1
    return self:Get()
end

function UrlGroupLegacy:Get()
    local url = self._urls[self.index]
    if self.append then
        url = url .. self.append
    end
    return url
end

function UrlGroupLegacy:SetUrlAppend(append)
    self.append = append
end

function UrlGroupLegacy:Concat(add)
    local urls = self._urls
    for i, url in ipairs(urls) do
        urls[i] = url .. add
    end
end

function UrlGroupLegacy:GetByTryTimes(times)
    if times ~= 1 then
        self:Next()
    end
    return self:Get()
end

function UrlGroupLegacy:GetClone()
    local dup = UrlGroupLegacy(self._urls)
    dup:SetUrlAppend(self.append)
    return dup
end

return UrlGroupLegacy
