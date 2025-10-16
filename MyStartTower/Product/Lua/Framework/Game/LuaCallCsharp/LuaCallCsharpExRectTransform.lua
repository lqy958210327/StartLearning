
local tab = {}

--RectTransform扩展接口
function tab.GetRectTransform(obj, path)
    return CS_LuaCallCs.GetRectTransform(obj, path)
end

function tab.RectTransformSetRight(tran, value)
    CS_LuaCallCs.RectTransformSetRight(tran, value)
end

function tab.SetAnchoredPosition(obj,x,y)
    CS_LuaCallCs.SetAnchoredPosition(obj,x,y)
end

function tab.RectTransformSetAnchorsPivot(rect, type)
    -- 0 中
    -- 1 左
    -- 2 右
    -- 3 左上
    -- 4 右上
    -- 5 左下
    -- 6 右下
    -- 7 上
    -- 8 下
    local x = 0
    local y = 0
    if type == 0 then
        x = 0.5
        y = 0.5
    elseif type == 1 then
        x = 0
        y = 0.5
    elseif type == 2 then
        x = 1
        y = 0.5
    elseif type == 3 then
        x = 0
        y = 1
    elseif type == 4 then
        x = 1
        y = 1
    elseif type == 5 then
        x = 0
        y = 0
    elseif type == 6 then
        x = 1
        y = 0
    elseif type == 7 then
        x = 0.5
        y = 1
    elseif type == 8 then
        x = 0.5
        y = 0
    end
    CS_LuaCallCs.RectTransformSetAnchorsPivot(rect, x, y)
end

function tab.RectTransformSetAnchoredPosition(tran, x, y)
    CS_LuaCallCs.RectTransformSetAnchoredPosition(tran, x, y)
end

---@type fun(go:GameObject, angleX:number, angleY:number, angleZ:number):void 设置RectTransform的本地旋转
function tab.RectTransformLocalRotation(go, angleX, angleY, angleZ)
    CS_LuaCallCs.RectTransformLocalRotation(go, angleX, angleY, angleZ)
end

---@type fun(go:GameObject, angleX:number):void 设置RectTransform的本地旋转X轴
function tab.RectTransformLocalRotationX(go, angleX)
    CS_LuaCallCs.RectTransformLocalRotationX(go, angleX)
end

---@type fun(go:GameObject, angleY:number):void 设置RectTransform的本地旋转Y轴
function tab.RectTransformLocalRotationY(go, angleY)
    CS_LuaCallCs.RectTransformLocalRotationY(go, angleY)
end

---@type fun(go:GameObject, angleZ:number):void 设置RectTransform的本地旋转Z轴
function tab.RectTransformLocalRotationZ(go, angleZ)
    CS_LuaCallCs.RectTransformLocalRotationZ(go, angleZ)
end

LuaCallCs.RectTransform = tab
