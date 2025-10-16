local Data = {
["cueFile"] = "33101",
	[3310101] = {
		["bhEvent"] = "skill.3310101",
		["atkEvents"]= {
			[1]= {
				["unitDelay"] = 0.08,
				["flyCueId"] = 331010001,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3310101,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331010002,331011001,},
				},
			},
			[10]= {
				["state"]= {
				},
			},
		},

	},
	[3310151] = {
		["bhEvent"] = "skill.3310151",
		["atkEvents"]= {
			[10]= {
				["targetChoose"] = 1,
				["state"]= {
				},
			},
			[1]= {
				["targetChoose"] = 7,
				["delay"] = 0.1,
				["eventType"] = 1,
				["boxId"] = 3310151,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331010005,331010004,},
				},
				["randomTargetNumber"] = 3,
			},
		},

		["actTime"] = 40,
	},
	[3310152] = {
		["bhEvent"] = "skill.3310152",
		["atkEvents"]= {
			[1]= {
				["targetChoose"] = 7,
				["delay"] = 0.1,
				["eventType"] = 1,
				["boxId"] = 3310152,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331010004,331010005,},
				},
			},
			[1001]= {
				["targetArea"] = 2,
				["targetChoose"] = 3,
				["eventType"] = 1,
				["boxId"] = 3310160,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331010003,},
				},
				["hitCue"]= {
					["cueList"] = {331010002,},
				},
			},
			[1002]= {
				["targetArea"] = 3,
				["targetChoose"] = 7,
				["state"]= {
					["stateId"] = 3310101,
					["duration"] = -999,
				},
			},
		},

		["actTime"] = 70,
	},
	[3310153] = {
		["bhEvent"] = "skill.3310153",
		["atkEvents"]= {
			[1]= {
				["targetChoose"] = 7,
				["eventType"] = 1,
				["boxId"] = 3310153,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331010016,},
				},
				["randomTargetNumber"] = 1,
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331011005,},
				},
			},
		},

		["actTime"] = 45,
	},
	[3310154] = {
		["bhEvent"] = "skill.3310154",
		["atkEvents"]= {
			[1]= {
				["delay"] = 0.25,
				["flyCueId"] = 331010017,
				["boxType"] = 1,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331010018,},
				},
			},
			[2]= {
				["targetChoose"] = 3,
				["eventType"] = 1,
				["boxId"] = 3310154,
				["state"]= {
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331011006,},
				},
			},
		},

		["actTime"] = 37,
	},
	[3310155] = {
		["bhEvent"] = "skill.3310155",
		["atkEvents"]= {
			[0]= {
				["targetChoose"] = 10,
				["eventType"] = 1,
				["boxId"] = 3310155,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331010004,331010005,},
				},
			},
		},

	},
	[3310156] = {
		["bhEvent"] = "skill.3310156",
		["atkEvents"]= {
			[1]= {
				["targetChoose"] = 19,
				["eventType"] = 1,
				["boxId"] = 3310156,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331010004,331010005,},
				},
			},
		},

		["actTime"] = 72,
	},
	[3310157] = {
		["bhEvent"] = "skill.3310157",
		["atkEvents"]= {
			[0]= {
				["eventType"] = 1,
				["boxId"] = 3310157,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331010004,331010005,},
				},
			},
		},

		["actTime"] = 16,
	},
	[3310102] = {
		["bhEvent"] = "skill.3310102",
		["atkEvents"]= {
			[1]= {
				["targetChoose"] = 7,
				["unitDelay"] = 0.08,
				["flyCueId"] = 331010001,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3310102,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331010002,331011001,},
				},
				["randomTargetNumber"] = 3,
				["randomRule"] = 2,
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
