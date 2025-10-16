local Data = {
["cueFile"] = "33119",
	[3311901] = {
		["bhEvent"] = "skill.3311901",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331190001,331190002,331191001,},
				},
			},
			[1]= {
				["delay"] = 0.1,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3311901,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000062,},
				},
			},
			[2]= {
				["delay"] = 0.1,
				["boxType"] = 1,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000062,},
				},
			},
			[3]= {
				["delay"] = 0.1,
				["boxType"] = 1,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000062,},
				},
			},
		},

	},
	[3311902] = {
		["bhEvent"] = "skill.3311902",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331190003,331190004,331191002,},
				},
			},
			[1]= {
				["targetChoose"] = 7,
				["unitDelay"] = 0.25,
				["flyCueId"] = 331190007,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3311902,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000062,},
				},
			},
			[2]= {
				["unitDelay"] = 0.25,
				["flyCueId"] = 331190008,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3311902,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000062,},
				},
			},
		},

	},
	[3311921] = {
		["bhEvent"] = "skill.3311921",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331190011,331191003,},
				},
			},
			[1]= {
				["targetChoose"] = 19,
				["unitDelay"] = 0.3,
				["flyCueId"] = 331190009,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3311921,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000062,},
				},
				["randomTargetNumber"] = 1,
			},
			[2]= {
				["targetChoose"] = 19,
				["unitDelay"] = 0.3,
				["flyCueId"] = 331190010,
				["boxType"] = 1,
				["boxId"] = 3311921,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000062,},
				},
				["randomTargetNumber"] = 1,
			},
		},

	},
	[3311922] = {
		["bhEvent"] = "skill.3311922",
		["atkEvents"]= {
			[100]= {
				["targetArea"] = 3,
				["state"]= {
					["stateOperation"] = 1,
					["chooseStateType"] = 2,
					["chooseStateMode"] = 1,
				},
				["atkCue"]= {
					["cueList"] = {331191004,},
				},
			},
			[1]= {
				["targetChoose"] = 7,
				["unitDelay"] = 0.3,
				["flyCueId"] = 331190012,
				["boxType"] = 1,
				["boxId"] = 3311922,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331190014,331191005,},
				},
				["randomTargetNumber"] = 1,
				["randomRule"] = 4,
			},
		},

	},
	[3311951] = {
		["bhEvent"] = "skill.3311951",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331190015,331190016,331191006,},
				},
			},
			[1]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 3311901,
					["duration"] = 8,
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
