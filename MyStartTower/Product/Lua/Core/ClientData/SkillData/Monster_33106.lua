local Data = {
["cueFile"] = "33106",
	[3310601] = {
		["bhEvent"] = "skill.3310601",
		["atkEvents"]= {
			[1]= {
				["unitDelay"] = 0.25,
				["flyCueId"] = 331060002,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3310601,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000063,331061002,},
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331060001,331061001,},
				},
			},
		},

	},
	[3310651] = {
		["bhEvent"] = "skill.3310651",
		["atkEvents"]= {
			[1]= {
				["targetChoose"] = 4,
				["delay"] = 0.8,
				["flyCueId"] = 331060016,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3310651,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331060014,331061010,},
				},
			},
			[100]= {
				["state"]= {
				},
			},
		},

		["actTime"] = 50,
	},
	[3310602] = {
		["bhEvent"] = "skill.3310602",
		["atkEvents"]= {
			[1]= {
				["targetChoose"] = 9,
				["unitDelay"] = 0.15,
				["flyCueId"] = 331060002,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3310601,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000063,331061002,},
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331060001,331061001,},
				},
			},
		},

	},
	[3310603] = {
		["bhEvent"] = "skill.3310603",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331060012,331061009,},
				},
			},
			[1]= {
				["targetChoose"] = 7,
				["unitDelay"] = 0.2,
				["flyCueId"] = 331060015,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3310603,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331060014,331061010,},
				},
				["randomTargetNumber"] = 3,
				["randomRule"] = 2,
			},
		},

	},
	[3310652] = {
		["bhEvent"] = "skill.3310652",
		["atkEvents"]= {
			[1]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 3310601,
					["duration"] = 8,
				},
			},
			[100]= {
				["state"]= {
				},
			},
			[1001]= {
				["targetChoose"] = 7,
				["state"]= {
					["stateId"] = 3310602,
					["duration"] = -999,
				},
			},
		},

		["actTime"] = 40,
		["skillTarget"] = 1,
	},
	[3310653] = {
		["bhEvent"] = "skill.3310653",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331060012,331061009,},
				},
			},
			[1]= {
				["delay"] = 0.8,
				["flyCueId"] = 331060015,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3310653,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331060014,331061010,},
				},
			},
		},

		["actTime"] = 45,
		["skillTarget"] = 2,
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
