local Data = {
["cueFile"] = "11002",
	[1190101] = {
		["bhEvent"] = "skill.1190101",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {110020005,},
				},
			},
			[1]= {
				["boxId"] = 1190101,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000062,},
				},
			},
		},

	},
	[1190121] = {
		["bhEvent"] = "skill.1190101",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
			},
			[1001]= {
				["targetArea"] = 2,
				["targetChoose"] = 3,
				["boxId"] = 1190121,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {110020010,},
				},
			},
			[1002]= {
				["targetArea"] = 3,
				["boxId"] = 1190122,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000008,},
				},
			},
		},

	},
	[1190151] = {
		["bhEvent"] = "skill.1190151",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {110020002,},
				},
			},
			[1]= {
				["targetArea"] = 2,
				["targetChoose"] = 3,
				["boxId"] = 1190151,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000062,},
				},
			},
			[2]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1190101,
					["duration"] = 12,
				},
			},
		},

		["actTime"] = 90,
		["videoActTime"] = 55,
		["videoActCue"]= {
			["cueList"] = {110028001,110021004,},
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
