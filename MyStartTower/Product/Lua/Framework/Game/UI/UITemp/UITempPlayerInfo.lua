


local tab = {}

function tab.SetHead(obj, headConfigId, frameConfigId, moduleId, defaultClick, customClick)
    -- 设置玩家头像（包含头像框）
    if obj then
        if defaultClick == nil then defaultClick = true end
        headConfigId = PlayerHelper.HeadIDToHeadConfigID(headConfigId)
        frameConfigId = PlayerHelper.FrameIDToFrameConfigID(frameConfigId)

        LuaCallCs.UI.UGUISetRawImage(obj, "img_PlayerHead", PlayerHelper.GetPlayerInfoCfgIcon(headConfigId), moduleId)
        LuaCallCs.SimpleFxComponentPlayAsync(obj, "eff_PlayerHead", PlayerHelper.GetPlayerInfoCfgEffect(headConfigId))

        LuaCallCs.UI.UGUISetRawImage(obj, "img_Frame", PlayerHelper.GetPlayerInfoCfgIcon(frameConfigId), moduleId)
        LuaCallCs.SimpleFxComponentPlayAsync(obj, "eff_Frame", PlayerHelper.GetPlayerInfoCfgEffect(frameConfigId))

        LuaCallCs.UI.SetJButton(obj, "BtnPlayer", function()
            if customClick then
                customClick()
            elseif defaultClick then
                -- 打开提示界面
            end
        end)

    end
end

function tab.SetTitle(obj, configId, moduleId, defaultClick, customClick)
    -- 设置玩家称号
    if obj then
        if defaultClick == nil then defaultClick = true end
        configId = PlayerHelper.TitleIDToTitleConfigID(configId)

        LuaCallCs.UI.UGUISetRawImage(obj, "Raw_PlayerTitle", PlayerHelper.GetPlayerInfoCfgIcon(configId), moduleId)
        LuaCallCs.UI.UGUISetTextMeshPro(obj, "txt_PlayerTitle", PlayerHelper.GetPlayerInfoCfgName(configId))

        LuaCallCs.UI.SetJButton(obj, "BtnTitle", function()
            if customClick then
                customClick()
            elseif defaultClick then
                -- 打开提示界面
                UIJump.ToOpenTitleTips(configId)
            end
        end)
    end
end

function tab.SetMedal(obj, configId, moduleId, defaultClick)
    -- 设置玩家勋章
    if obj then
        LuaCallCs.SetGameObjectActive(obj, "isNull", configId ~= nil)
        if configId then
            LuaCallCs.UI.UGUISetRawImage(obj, "raw_PlayMedal", PlayerHelper.GetPlayerInfoCfgIcon(configId), moduleId)
        end
        LuaCallCs.UI.SetJButton(obj, "BtnMedal", function()
            if defaultClick then
                -- 打开提示界面
                defaultClick()
            end
        end)
    end
end

function tab.SetMedalGroup(obj, configIdList, moduleId, defaultClick, customClick)
    -- 设置玩家勋章组
    if obj and configIdList then
        for i = 1, 8 do
            local medalObj = LuaCallCs.GetObject(obj, "item_medal_"..i)
            local clickFunction = nil
            if defaultClick then
                clickFunction = function()
                    if configIdList and #configIdList > 0 then
                        UIJump.ToOpenMedalTips(configIdList, i)
                    end
                end
            end
            if customClick then
                clickFunction = function()
                    customClick(configIdList, i)
                end
            end
            UITemp.PlayerInfo.SetMedal(medalObj, configIdList[i], moduleId, clickFunction)
        end
    end
end


function tab.SetNameCardFull(obj, configId, moduleId)
    -- 设置玩家名片底板(完整样式)
    if obj then
        configId = PlayerHelper.NameCardIDToNameCardConfigID(configId)
        LuaCallCs.UI.UGUISetRawImage(obj, "", PlayerHelper.GetPlayerInfoCfgIcon(configId), moduleId)
    end
end

function tab.SetNameCardMini(obj, configId, moduleId)
    -- 设置玩家名片底板(缩略图样式)
    if obj then
        configId = PlayerHelper.NameCardIDToNameCardConfigID(configId)
        LuaCallCs.UI.UGUISetRawImage(obj, "", PlayerHelper.GetPlayerInfoCfgIconType2(configId), moduleId)
    end
end

function tab.SetNameCardLong(obj, configId, moduleId)
    -- 设置玩家名片底板(横板长条样式样式)
    if obj then
        configId = PlayerHelper.NameCardIDToNameCardConfigID(configId)
        LuaCallCs.UI.UGUISetRawImage(obj, "", PlayerHelper.GetPlayerInfoCfgIconType3(configId), moduleId)
    end
end


UITemp.PlayerInfo = tab