local Data = {
["cueFile"] = "12002",
	[1610109] = {
		["bhEvent"] = "skill.1610109",
		["atkEvents"]= {
			[0]= {
				["unitDelay"] = 0.22,
				["flyCueId"] = 120020002,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1610109,
				["state"]= {
					["stateId"] = 1200202,
					["duration"] = 2,
				},
				["hitCue"]= {
					["cueList"] = {120020003,},
				},
			},
		},

	},
	[1610110] = {
		["bhEvent"] = "skill.1610110",
		["atkEvents"]= {
			[0]= {
				["unitDelay"] = 0.22,
				["flyCueId"] = 120020002,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1610110,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {120020003,},
				},
			},
			[10]= {
				["targetArea"] = 3,
				["eventType"] = 1,
				["boxId"] = 1610111,
				["state"]= {
				},
			},
			[11]= {
				["targetArea"] = 3,
				["targetChoose"] = 15,
				["boxId"] = 1610112,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000008,},
				},
			},
		},

	},
}
local skillDefault = {
}
local atkEventsDefault = {
["delay"] = 0,
["eventProbId"] = 0,
["randomTargetNumber"] = 0,
["flyCueId"] = 0,
["boxType"] = 0,
["eventType"] = 0,
["boxId"] = 0,
["stateCondition"] = 0,
}

for k,skillData in pairs(Data) do
    if k~='cueFile' then
        setmetatable(skillData, {__index = skillDefault} ) 
        for skillKey,skillInfo in pairs(skillData) do 
            if skillKey == 'atkEvents' then 
        	    for eventsKey, event in pairs(skillInfo) do 
            	    setmetatable(event, {__index = atkEventsDefault} ) 
        	    end 
            end 
        end
    end
end

return Data
