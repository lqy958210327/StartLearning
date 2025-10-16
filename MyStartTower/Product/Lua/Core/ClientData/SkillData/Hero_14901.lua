local Data = {
["cueFile"] = "14012",
	[1490101] = {
		["bhEvent"] = "skill.1490101",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {140120001,},
				},
			},
			[1]= {
				["unitDelay"] = 0.15,
				["flyCueId"] = 140120002,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1490101,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {140120003,},
				},
			},
		},

	},
	[1490121] = {
		["bhEvent"] = "skill.1490101",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
			},
			[1001]= {
				["targetChoose"] = 7,
				["unitDelay"] = 0.15,
				["flyCueId"] = 140120002,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1490121,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {140120007,},
				},
			},
			[1]= {
				["state"]= {
				},
			},
		},

	},
	[1490151] = {
		["bhEvent"] = "skill.1490151",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {140120009,},
				},
			},
			[1]= {
				["eventType"] = 1,
				["boxId"] = 1490151,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {140120010,},
				},
			},
			[2]= {
				["targetArea"] = 3,
				["targetChoose"] = 7,
				["state"]= {
					["stateId"] = 1490101,
					["duration"] = 5,
				},
			},
		},

		["actTime"] = 70,
		["videoActTime"] = 60,
		["videoActCue"]= {
			["cueList"] = {140128001,140121005,},
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
