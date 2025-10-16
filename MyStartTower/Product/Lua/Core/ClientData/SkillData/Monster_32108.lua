local Data = {
["cueFile"] = "32108",
	[3210801] = {
		["bhEvent"] = "skill.3210801",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {321080001,321081001,},
				},
			},
			[1]= {
				["unitDelay"] = 0.2,
				["flyCueId"] = 321080002,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3210801,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {321080003,321081002,},
				},
			},
			[2]= {
				["targetChoose"] = 7,
				["unitDelay"] = 0.25,
				["flyCueId"] = 321080002,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3210801,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {321080003,321081002,},
				},
				["randomTargetNumber"] = 1,
				["excludeTarget"] = 1,
			},
		},

	},
	[3210802] = {
		["bhEvent"] = "skill.3210802",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {321080013,321081005,},
				},
			},
			[1]= {
				["eventType"] = 1,
				["boxId"] = 3210802,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {321080015,},
				},
			},
		},

	},
	[3210803] = {
		["bhEvent"] = "skill.3210803",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {321080014,321081006,},
				},
			},
			[1]= {
				["targetChoose"] = 3,
				["eventType"] = 1,
				["boxId"] = 3210803,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {321080015,},
				},
				["controlTime"] = 1,
				["controlAniName"] = "Float",
			},
		},

	},
	[3210821] = {
		["bhEvent"] = "skill.3210821",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {321080016,321081007,},
				},
			},
			[1]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 3210801,
					["duration"] = 9.5,
				},
			},
			[1001]= {
				["eventType"] = 1,
				["state"]= {
					["stateId"] = 1000006,
					["duration"] = 2,
				},
				["hitCue"]= {
					["cueList"] = {321080004,321081003,321080022,},
				},
			},
			[1002]= {
				["delay"] = 0.5,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3210821,
				["state"]= {
				},
				["subEventSkill"] = 3210821,
				["subEventId"] = 1003,
			},
			[1003]= {
				["delay"] = 0.6,
				["boxType"] = 1,
				["boxId"] = 3210821,
				["state"]= {
				},
			},
		},

		["actTime"] = 60,
		["skillTarget"] = 1,
	},
	[3210851] = {
		["bhEvent"] = "skill.3210851",
		["atkEvents"]= {
			[100]= {
				["targetChoose"] = 19,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {321080008,321080009,321080010,321080011,321080012,321081004,},
				},
				["hitCue"]= {
					["cueList"] = {321080005,321080006,321080007,},
				},
			},
			[1]= {
				["targetChoose"] = 19,
				["unitDelay"] = 0.15,
				["flyCueId"] = 321080020,
				["eventType"] = 1,
				["boxId"] = 3210852,
				["state"]= {
				},
			},
			[2]= {
				["targetChoose"] = 19,
				["state"]= {
				},
				["hitedAnim"] = "Hit",
			},
			[90]= {
				["targetChoose"] = 19,
				["state"]= {
				},
				["hitedAnim"] = "end",
			},
		},

		["actTime"] = 70,
	},
	[3210852] = {
		["bhEvent"] = "skill.3210852",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {321080019,321081008,},
				},
			},
			[1]= {
				["targetChoose"] = 18,
				["unitDelay"] = 0.15,
				["flyCueId"] = 321080020,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3210851,
				["state"]= {
					["stateId"] = 3210807,
					["duration"] = 2,
				},
				["hitCue"]= {
					["cueList"] = {321081009,321080021,},
				},
			},
			[2]= {
				["targetChoose"] = 9,
				["unitDelay"] = 0.15,
				["flyCueId"] = 321080020,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3210851,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {321080021,321081009,},
				},
			},
		},

		["actTime"] = 45,
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
