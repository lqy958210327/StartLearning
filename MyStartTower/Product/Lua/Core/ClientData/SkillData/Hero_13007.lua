local Data = {
["cueFile"] = "13008",
	[1300701] = {
		["bhEvent"] = "skill.1300701",
		["atkEvents"]= {
			[1]= {
				["unitDelay"] = 0.1,
				["flyCueId"] = 130080002,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1300701,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {130080001,},
				},
			},
		},

	},
	[1300751] = {
		["bhEvent"] = "skill.1300751",
		["atkEvents"]= {
			[1]= {
				["targetArea"] = 3,
				["unitDelay"] = 0.05,
				["flyCueId"] = 130070001,
				["state"]= {
					["stateId"] = 1300701,
					["duration"] = 8,
				},
				["hitCue"]= {
					["cueList"] = {130080001,},
				},
			},
			[100]= {
				["state"]= {
				},
			},
			[2]= {
				["state"]= {
				},
			},
			[1001]= {
				["state"]= {
					["stateId"] = 1000003,
					["duration"] = 5,
				},
			},
		},

		["actTime"] = 35,
		["skillTarget"] = 1,
	},
	[1300702] = {
		["bhEvent"] = "skill.1300702",
		["atkEvents"]= {
			[2]= {
				["state"]= {
				},
			},
			[1]= {
				["unitDelay"] = 0.15,
				["flyCueId"] = 130080005,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1300702,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {130080004,},
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
