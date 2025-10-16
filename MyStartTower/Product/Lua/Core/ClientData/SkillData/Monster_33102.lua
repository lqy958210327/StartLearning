local Data = {
["cueFile"] = "33102",
	[3310201] = {
		["bhEvent"] = "skill.3310201",
		["atkEvents"]= {
			[100]= {
				["unitDelay"] = 0.15,
				["flyCueId"] = 140070001,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331020003,},
				},
			},
			[1]= {
				["unitDelay"] = 0.1,
				["flyCueId"] = 331020001,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3310201,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331020002,331021001,},
				},
			},
		},

	},
	[3310251] = {
		["bhEvent"] = "skill.3310251",
		["atkEvents"]= {
			[1]= {
				["targetArea"] = 3,
				["targetChoose"] = 12,
				["flyCueId"] = 331020001,
				["boxId"] = 3310251,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331020002,},
				},
			},
			[2]= {
				["targetArea"] = 3,
				["targetChoose"] = 4,
				["state"]= {
					["stateId"] = 3310201,
					["duration"] = 1.5,
				},
				["randomTargetNumber"] = 1,
				["randomRule"] = 1,
				["recordSkillTargets"] = 1,
			},
			[1001]= {
				["targetChoose"] = 3,
				["eventType"] = 1,
				["boxId"] = 3310252,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331020002,},
				},
				["excludeTarget"] = 1,
			},
		},

		["actTime"] = 55,
		["skillTarget"] = 1,
	},
	[3310202] = {
		["bhEvent"] = "skill.3310202",
		["atkEvents"]= {
			[0]= {
				["unitDelay"] = 0.2,
				["flyCueId"] = 331020001,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3310302,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331020002,331021001,},
				},
			},
			[100]= {
				["state"]= {
				},
			},
		},

	},
	[3310252] = {
		["bhEvent"] = "skill.3310252",
		["atkEvents"]= {
			[2]= {
				["state"]= {
				},
			},
			[1]= {
				["targetArea"] = 3,
				["targetChoose"] = 18,
				["state"]= {
					["stateId"] = 3310202,
					["duration"] = 5,
				},
				["hitCue"]= {
					["cueList"] = {331020007,},
				},
			},
			[1001]= {
				["targetArea"] = 1,
				["boxId"] = 3310253,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000047,},
				},
			},
		},

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
