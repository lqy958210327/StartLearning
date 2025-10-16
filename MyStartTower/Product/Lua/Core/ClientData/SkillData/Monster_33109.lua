local Data = {
["cueFile"] = "33109",
	[3310901] = {
		["bhEvent"] = "skill.3310901",
		["atkEvents"]= {
			[1]= {
				["unitDelay"] = 0.15,
				["flyCueId"] = 331090002,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3310901,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331090003,331091002,},
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331091001,},
				},
			},
		},

	},
	[3310951] = {
		["bhEvent"] = "skill.3310951",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331090004,331091003,},
				},
			},
			[1]= {
				["eventType"] = 1,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331090005,},
				},
			},
			[2]= {
				["targetChoose"] = 3,
				["delay"] = 0.2,
				["eventType"] = 1,
				["boxId"] = 3310951,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331090006,331091004,},
				},
			},
		},

		["actTime"] = 70,
	},
	[3310952] = {
		["bhEvent"] = "skill.3310952",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331090007,331091005,},
				},
			},
			[1]= {
				["targetChoose"] = 7,
				["unitDelay"] = 0.3,
				["flyCueId"] = 331090008,
				["boxType"] = 1,
				["eventType"] = 1,
				["state"]= {
					["stateId"] = 3310901,
					["duration"] = 5,
				},
				["hitCue"]= {
					["cueList"] = {331091006,331090001,},
				},
				["randomTargetNumber"] = 3,
			},
			[1001]= {
				["eventType"] = 1,
				["boxId"] = 3310952,
				["state"]= {
				},
				["disablePassive"] = 1,
			},
		},

		["actTime"] = 62,
	},
	[3310953] = {
		["bhEvent"] = "skill.3310953",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331090010,331091007,},
				},
			},
			[1]= {
				["unitDelay"] = 0.2,
				["flyCueId"] = 331090011,
				["boxType"] = 1,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331090017,},
				},
			},
			[2]= {
				["targetChoose"] = 4,
				["unitDelay"] = 0.18,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3310953,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331090013,331091008,},
				},
			},
		},

		["actTime"] = 60,
	},
	[3310902] = {
		["bhEvent"] = "skill.3310902",
		["atkEvents"]= {
			[1]= {
				["unitDelay"] = 0.15,
				["flyCueId"] = 331090015,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3310901,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331090016,331091002,},
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331091001,},
				},
			},
		},

	},
	[3310954] = {
		["bhEvent"] = "skill.3310954",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331090007,331091005,},
				},
			},
			[1]= {
				["targetChoose"] = 7,
				["state"]= {
					["stateId"] = 3310902,
					["duration"] = 8,
				},
				["hitCue"]= {
					["cueList"] = {331090001,331091005,},
				},
				["randomTargetNumber"] = 2,
			},
			[1001]= {
				["eventType"] = 1,
				["boxId"] = 3310954,
				["state"]= {
				},
			},
		},

		["actTime"] = 62,
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
