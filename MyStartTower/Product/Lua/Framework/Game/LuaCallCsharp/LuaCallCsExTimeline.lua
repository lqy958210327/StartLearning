
local tab = {}


function tab.Play(go, endAction)
    CS_LuaCallCs.TimelinePlay(go)
    if endAction then
        CS_LuaCallCs.WithEndAction(go, endAction)
    end
end

function tab.Stop(go)
    CS_LuaCallCs.TimelineStop(go)
end

function tab.Pause(go)
    CS_LuaCallCs.TimelinePause(go)
end

function tab.Resume(go)
    CS_LuaCallCs.TimelineResume(go)
end

function tab.WithEndAction(go, endAction)
    CS_LuaCallCs.WithEndAction(go, endAction)
end


LuaCallCs.Timeline = tab
