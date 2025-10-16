local Data = {
["cueFile"] = "32001",
	[3200101] = {
		["bhEvent"] = "skill.3200101",
		["atkEvents"]= {
			[1]= {
				["eventType"] = 1,
				["boxId"] = 3200101,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {320010002,},
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {320010001,320011001,},
				},
			},
		},

	},
	[3200102] = {
		["bhEvent"] = "skill.3200102",
		["atkEvents"]= {
			[1]= {
				["eventType"] = 1,
				["boxId"] = 3200101,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {320010004,},
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {320010003,320011002,},
				},
			},
		},

	},
	[3200151] = {
		["bhEvent"] = "skill.3200151",
		["atkEvents"]= {
			[0]= {
				["eventType"] = 1,
				["boxId"] = 3200151,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {320010007,},
				},
			},
			[100]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {320010006,320011003,},
				},
			},
			[1001]= {
				["state"]= {
					["stateId"] = 3200101,
					["duration"] = -999,
				},
				["hitCue"]= {
					["cueList"] = {320010005,},
				},
			},
		},

		["actTime"] = 55,
	},
	[3200152] = {
		["bhEvent"] = "skill.3200152",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {320010006,320011003,},
				},
			},
			[0]= {
				["boxId"] = 3200151,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {320010007,},
				},
			},
		},

		["actTime"] = 55,
	},
	[3200153] = {
		["bhEvent"] = "skill.3200153",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {320010006,320011003,},
				},
			},
			[0]= {
				["eventType"] = 1,
				["boxId"] = 3200151,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {320010007,},
				},
			},
			[1]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 3200103,
					["duration"] = 5,
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
