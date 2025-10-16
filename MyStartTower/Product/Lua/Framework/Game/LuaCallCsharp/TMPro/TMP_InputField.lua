
---@class TMP_InputField 扩展
local TMP_InputField = {}

---@type fun(go:GameObject, text:string) : void 设置文本
function TMP_InputField.SetText(go, text)
    CS_TMP_InputField.SetText(go, text)
end

---@type fun(go:GameObject) : string 获取文本
function TMP_InputField.GetText(go)
    return CS_TMP_InputField.GetText(go)
end

---@type fun(go:GameObject) : boolean 获取是否可交互
function TMP_InputField.GetInteractable(go)
    return CS_TMP_InputField.GetInteractable(go)
end

---@type fun(go:GameObject, value:boolean) : void 设置是否可交互
function TMP_InputField.SetInteractable(go, value)
    CS_TMP_InputField.SetInteractable(go, value)
end

---@type fun(go:GameObject) : string 获取占位符文本
function TMP_InputField.GetPlaceholderText(go)
    return CS_TMP_InputField.GetPlaceholderText(go)
end

---@type fun(go:GameObject, text:string) : void 设置占位符文本
function TMP_InputField.SetPlaceholderText(go, text)
    CS_TMP_InputField.SetPlaceholderText(go, text)
end

return TMP_InputField
