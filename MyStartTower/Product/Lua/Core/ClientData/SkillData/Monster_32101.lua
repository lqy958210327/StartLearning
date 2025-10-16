local Data = {
["cueFile"] = "32101",
	[3210101] = {
		["bhEvent"] = "skill.3210101",
		["atkEvents"]= {
			[1]= {
				["eventType"] = 1,
				["boxId"] = 3210101,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000062,},
				},
			},
		},

	},
	[3210151] = {
		["bhEvent"] = "skill.3210151",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {321011001,},
				},
			},
			[1]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 3210101,
					["duration"] = 5,
				},
			},
			[5]= {
				["state"]= {
				},
			},
		},

		["actTime"] = 53,
		["skillTarget"] = 1,
	},
	[3210102] = {
		["bhEvent"] = "skill.3210102",
		["atkEvents"]= {
			[1]= {
				["eventType"] = 1,
				["boxId"] = 3210101,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000062,},
				},
			},
		},

	},
	[3210152] = {
		["bhEvent"] = "skill.3210152",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
			},
			[0]= {
				["targetArea"] = 2,
				["targetChoose"] = 7,
				["unitDelay"] = 0.4,
				["flyCueId"] = 321010025,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3210152,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {321010021,},
				},
			},
			[1]= {
				["targetArea"] = 2,
				["targetChoose"] = 7,
				["unitDelay"] = 0.4,
				["flyCueId"] = 321010025,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3210152,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {321010020,},
				},
				["hitCue"]= {
					["cueList"] = {321010021,},
				},
			},
		},

		["actTime"] = 50,
		["skillTarget"] = 1,
	},
	[3210103] = {
		["bhEvent"] = "skill.3210103",
		["atkEvents"]= {
			[1]= {
				["targetArea"] = 2,
				["targetChoose"] = 3,
				["eventType"] = 1,
				["boxId"] = 3210103,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {321010009,},
				},
			},
		},

	},
	[3210154] = {
		["bhEvent"] = "skill.3210154",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
			},
			[1]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 3210102,
					["duration"] = 10,
				},
			},
			[5]= {
				["state"]= {
				},
			},
		},

		["actTime"] = 53,
	},
	[3210153] = {
		["bhEvent"] = "skill.3210153",
		["atkEvents"]= {
			[5]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 3210103,
					["duration"] = 5,
				},
			},
			[1]= {
				["targetArea"] = 2,
				["targetChoose"] = 3,
				["eventType"] = 1,
				["boxId"] = 3210153,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {321010016,},
				},
			},
			[100]= {
				["state"]= {
				},
			},
		},

		["actTime"] = 90,
	},
	[3210155] = {
		["bhEvent"] = "skill.3210155",
		["atkEvents"]= {
			[5]= {
				["state"]= {
				},
			},
			[1]= {
				["targetArea"] = 2,
				["targetChoose"] = 3,
				["eventType"] = 1,
				["boxId"] = 3210155,
				["state"]= {
					["stateId"] = 1500101,
					["duration"] = 5,
				},
				["hitCue"]= {
					["cueList"] = {321010016,},
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {321010015,},
				},
			},
		},

	},
	[3210156] = {
		["bhEvent"] = "skill.3210156",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
			},
			[0]= {
				["targetChoose"] = 7,
				["unitDelay"] = 0.4,
				["flyCueId"] = 321010025,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3210156,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {321010021,},
				},
				["randomTargetNumber"] = 1,
			},
			[1]= {
				["targetChoose"] = 7,
				["unitDelay"] = 0.4,
				["flyCueId"] = 321010025,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3210156,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {321010020,},
				},
				["hitCue"]= {
					["cueList"] = {321010021,},
				},
				["randomTargetNumber"] = 1,
			},
		},

		["actTime"] = 50,
		["skillTarget"] = 1,
	},
	[3210157] = {
		["bhEvent"] = "skill.3210157",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
			},
			[0]= {
				["targetArea"] = 2,
				["targetChoose"] = 3,
				["unitDelay"] = 0.25,
				["flyCueId"] = 321010025,
				["eventType"] = 1,
				["boxId"] = 3210157,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {321010021,},
				},
			},
			[1]= {
				["targetArea"] = 2,
				["targetChoose"] = 3,
				["delay"] = 0.1,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3210157,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {321010020,},
				},
				["hitCue"]= {
					["cueList"] = {321010021,},
				},
			},
		},

		["actTime"] = 50,
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
