local Data = {
["cueFile"] = "33127",
	[3312701] = {
		["bhEvent"] = "skill.3312701",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331270001,331271001,},
				},
			},
			[1]= {
				["unitDelay"] = 0.12,
				["flyCueId"] = 331270002,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3312701,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000062,331271002,},
				},
			},
		},

	},
	[3312702] = {
		["bhEvent"] = "skill.3312702",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331270003,331271003,},
				},
			},
			[1]= {
				["targetChoose"] = 7,
				["unitDelay"] = 0.1,
				["flyCueId"] = 331270004,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3312702,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331270005,331271004,},
				},
				["randomTargetNumber"] = 3,
				["randomRule"] = 2,
			},
		},

	},
	[3312721] = {
		["bhEvent"] = "skill.3312721",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331270006,331271006,},
				},
			},
			[1]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000035,331270007,},
				},
				["addManaNumber"] = 15,
			},
		},

		["skillTarget"] = 1,
	},
	[3312722] = {
		["bhEvent"] = "skill.3312722",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331270008,331271005,},
				},
			},
			[1]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 3312701,
					["duration"] = 5,
				},
			},
		},

		["skillTarget"] = 1,
	},
	[3312751] = {
		["bhEvent"] = "skill.3312751",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331270009,331271007,},
				},
			},
			[1]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 3312702,
					["duration"] = 8,
				},
			},
		},

		["actTime"] = 50,
		["skillTarget"] = 1,
	},
	[3312752] = {
		["bhEvent"] = "skill.3312752",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331270011,331271008,},
				},
			},
			[1]= {
				["targetChoose"] = 3,
				["eventType"] = 1,
				["boxId"] = 3312752,
				["state"]= {
					["stateId"] = 3312703,
					["duration"] = 5,
				},
				["hitCue"]= {
					["cueList"] = {331270012,},
				},
			},
		},

		["actTime"] = 50,
	},
	[3312753] = {
		["bhEvent"] = "skill.3312753",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331270013,331270014,331271009,},
				},
			},
			[1]= {
				["targetChoose"] = 10,
				["unitDelay"] = 0.1,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3312753,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331270015,},
				},
				["stunTime"] = 1,
			},
		},

		["actTime"] = 50,
	},
	[3312754] = {
		["bhEvent"] = "skill.3312754",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331270016,331270017,331271010,},
				},
			},
			[1]= {
				["targetArea"] = 2,
				["targetChoose"] = 21,
				["eventType"] = 1,
				["boxId"] = 3312754,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331270018,},
				},
			},
		},

		["actTime"] = 30,
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
