local Data = {
["cueFile"] = "33001",
	[3300101] = {
		["bhEvent"] = "skill.3300101",
		["atkEvents"]= {
			[1]= {
				["unitDelay"] = 0.1,
				["flyCueId"] = 330010002,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3300101,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {330010003,330011002,},
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {330010001,330011001,},
				},
			},
		},

	},
	[3300102] = {
		["bhEvent"] = "skill.3300102",
		["atkEvents"]= {
			[2]= {
				["state"]= {
				},
			},
			[1]= {
				["unitDelay"] = 0.1,
				["flyCueId"] = 330010005,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3300102,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {330010006,330011004,},
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {330010004,330011003,},
				},
			},
		},

	},
	[3300151] = {
		["bhEvent"] = "skill.3300151",
		["atkEvents"]= {
			[1]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 3300101,
					["duration"] = 5,
				},
			},
			[1001]= {
				["targetArea"] = 3,
				["targetChoose"] = 7,
				["state"]= {
					["stateId"] = 3200101,
					["duration"] = -999,
				},
				["hitCue"]= {
					["cueList"] = {10000001,},
				},
				["excludeTarget"] = 1,
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {330010007,330010008,330010009,330011005,},
				},
			},
			[0]= {
				["state"]= {
				},
			},
		},

		["actTime"] = 40,
		["skillTarget"] = 1,
	},
	[3300152] = {
		["bhEvent"] = "skill.3300152",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {330010007,330010008,330010009,330011005,},
				},
			},
			[1]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 3300101,
					["duration"] = 5,
				},
			},
		},

		["actTime"] = 40,
		["skillTarget"] = 1,
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
