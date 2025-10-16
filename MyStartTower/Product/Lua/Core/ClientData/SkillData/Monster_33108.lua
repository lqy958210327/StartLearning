local Data = {
["cueFile"] = "33108",
	[3310801] = {
		["bhEvent"] = "skill.3310801",
		["atkEvents"]= {
			[1]= {
				["unitDelay"] = 0.12,
				["flyCueId"] = 331080002,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3310801,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000062,},
				},
			},
			[2]= {
				["unitDelay"] = 0.12,
				["flyCueId"] = 331080002,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3310801,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000062,},
				},
				["disablePassive"] = 1,
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331080001,331081001,},
				},
			},
			[0]= {
				["state"]= {
				},
			},
		},

	},
	[3310802] = {
		["bhEvent"] = "skill.3310802",
		["atkEvents"]= {
			[5]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 3310803,
					["duration"] = 2.2,
				},
			},
			[1]= {
				["eventType"] = 1,
				["boxId"] = 3310802,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331080005,331081006,},
				},
			},
			[2]= {
				["eventType"] = 1,
				["boxId"] = 3310802,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331080005,331081006,},
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331080004,331081005,},
				},
			},
		},

	},
	[3310851] = {
		["bhEvent"] = "skill.3310851",
		["atkEvents"]= {
			[1]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 3310801,
					["duration"] = 5,
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331080006,331081007,},
				},
			},
		},

		["actTime"] = 81,
		["skillTarget"] = 1,
	},
	[3310852] = {
		["bhEvent"] = "skill.3310852",
		["atkEvents"]= {
			[1]= {
				["unitDelay"] = 0.12,
				["flyCueId"] = 331080010,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3310852,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331080011,331080012,331080013,331081009,},
				},
			},
			[5]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 3310802,
					["duration"] = 4.5,
				},
			},
			[2]= {
				["unitDelay"] = 0.12,
				["flyCueId"] = 331080010,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3310852,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331080011,331080012,331080013,331081009,},
				},
			},
			[6]= {
				["targetArea"] = 3,
				["state"]= {
					["stateOperation"] = 1,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {3310802,},
				},
			},
			[100]= {
				["state"]= {
				},
			},
			[15]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331080008,331080009,},
				},
				["hitCue"]= {
					["cueList"] = {331080013,331080012,},
				},
			},
		},

		["actTime"] = 16,
	},
	[3310853] = {
		["bhEvent"] = "skill.3310853",
		["atkEvents"]= {
			[1]= {
				["unitDelay"] = 0.09,
				["flyCueId"] = 331080017,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3310853,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331080016,331081004,},
				},
				["addManaNumber"] = -30,
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331080015,331081003,},
				},
			},
		},

		["actTime"] = 71,
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
