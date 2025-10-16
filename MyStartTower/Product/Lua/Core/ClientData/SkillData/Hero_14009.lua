local Data = {
["cueFile"] = "13008",
	[1400909] = {
		["bhEvent"] = "skill.1400909",
		["atkEvents"]= {
			[1]= {
				["unitDelay"] = 0.15,
				["flyCueId"] = 130080016,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1400909,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {130080017,130081001,},
				},
			},
		},

	},
	[1400959] = {
		["bhEvent"] = "skill.1400959",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {130080023,},
				},
			},
			[0]= {
				["eventType"] = 1,
				["boxId"] = 1400959,
				["state"]= {
					["stateId"] = 1400901,
					["duration"] = 10,
				},
				["hitCue"]= {
					["cueList"] = {130080001,130080001,},
				},
			},
			[1]= {
				["unitDelay"] = 0.08,
				["flyCueId"] = 130080020,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1400959,
				["state"]= {
					["stateId"] = 1400901,
					["duration"] = 10,
				},
				["hitCue"]= {
					["cueList"] = {130080021,130080001,},
				},
			},
			[10]= {
				["state"]= {
				},
			},
		},

		["actTime"] = 40,
	},
	[1400929] = {
		["bhEvent"] = "skill.1400929",
		["atkEvents"]= {
			[1]= {
				["targetChoose"] = 4,
				["delay"] = 0.2,
				["flyCueId"] = 130080020,
				["eventType"] = 1,
				["boxId"] = 1400929,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {130080019,},
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {130080023,},
				},
			},
			[10]= {
				["delay"] = 0.2,
				["flyCueId"] = 130080020,
				["boxType"] = 1,
				["state"]= {
				},
				["baseCue"]= {
					["cueList"] = {130080024,},
				},
			},
		},

		["actTime"] = 30,
	},
	[1400910] = {
		["bhEvent"] = "skill.1400910",
		["atkEvents"]= {
			[0]= {
				["unitDelay"] = 0.08,
				["flyCueId"] = 90010003,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1400909,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {130080001,130081002,},
				},
			},
		},

	},
	[1400960] = {
		["bhEvent"] = "skill.1400960",
		["atkEvents"]= {
			[10]= {
				["delay"] = 0.2,
				["flyCueId"] = 130080020,
				["boxType"] = 1,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {130080024,},
				},
			},
			[1]= {
				["targetChoose"] = 4,
				["eventType"] = 1,
				["boxId"] = 1400960,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {130080021,},
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {130080023,},
				},
			},
		},

		["actTime"] = 48,
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
