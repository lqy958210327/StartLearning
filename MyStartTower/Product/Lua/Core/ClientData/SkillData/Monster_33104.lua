local Data = {
["cueFile"] = "33104",
	[3310401] = {
		["bhEvent"] = "skill.3310401",
		["atkEvents"]= {
			[1]= {
				["unitDelay"] = 0.2,
				["flyCueId"] = 331040002,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3310401,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331040001,},
				},
			},
		},

	},
	[3310451] = {
		["bhEvent"] = "skill.3310451",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
			},
			[1]= {
				["targetArea"] = 3,
				["unitDelay"] = 0.1,
				["flyCueId"] = 331040014,
				["state"]= {
					["stateId"] = 3310401,
					["duration"] = 6,
				},
			},
		},

		["actTime"] = 54,
		["skillTarget"] = 1,
	},
	[3310402] = {
		["bhEvent"] = "skill.3310402",
		["atkEvents"]= {
			[1]= {
				["unitDelay"] = 0.1,
				["flyCueId"] = 331040005,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3310402,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331040004,},
				},
			},
			[10]= {
				["state"]= {
				},
			},
			[2]= {
				["state"]= {
				},
			},
		},

	},
	[3310452] = {
		["bhEvent"] = "skill.3310452",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
			},
			[1]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 3310402,
					["duration"] = 6,
				},
			},
			[2]= {
				["state"]= {
				},
			},
		},

		["actTime"] = 45,
		["skillTarget"] = 1,
	},
	[3310403] = {
		["bhEvent"] = "skill.3310403",
		["atkEvents"]= {
			[1]= {
				["targetChoose"] = 7,
				["unitDelay"] = 0.08,
				["flyCueId"] = 331040005,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3310403,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331040004,},
				},
				["randomTargetNumber"] = 2,
				["randomRule"] = 2,
			},
		},

	},
	[3310453] = {
		["bhEvent"] = "skill.3310453",
		["atkEvents"]= {
			[1]= {
				["targetArea"] = 3,
				["summonMonsters"] = "3310410",
				["state"]= {
				},
			},
			[1001]= {
				["targetArea"] = 3,
				["targetChoose"] = 15,
				["state"]= {
					["stateOperation"] = 1,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {3310406,},
				},
			},
		},

		["actTime"] = 62,
		["skillTarget"] = 1,
	},
	[3310454] = {
		["bhEvent"] = "skill.3310454",
		["atkEvents"]= {
			[1]= {
				["targetChoose"] = 4,
				["delay"] = 0.2,
				["flyCueId"] = 331040020,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3310454,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331040017,},
				},
				["baseCue"]= {
					["cueList"] = {331040024,},
				},
			},
		},

		["actTime"] = 45,
	},
	[3310455] = {
		["bhEvent"] = "skill.3310455",
		["atkEvents"]= {
			[1]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 3310403,
					["duration"] = 8,
				},
			},
		},

		["actTime"] = 54,
		["skillTarget"] = 1,
	},
	[3310456] = {
		["bhEvent"] = "skill.3310456",
		["atkEvents"]= {
			[1]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 3310404,
					["duration"] = 8,
				},
			},
		},

		["actTime"] = 45,
		["skillTarget"] = 1,
	},
	[3310457] = {
		["bhEvent"] = "skill.3310457",
		["atkEvents"]= {
			[1]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 3310405,
					["duration"] = 8,
				},
			},
			[1001]= {
				["state"]= {
					["stateId"] = 3310407,
					["duration"] = 3,
				},
				["controlTime"] = 2,
				["controlAniName"] = "freeze",
			},
		},

		["actTime"] = 45,
		["skillTarget"] = 1,
	},
	[3310404] = {
		["bhEvent"] = "skill.3310404",
		["atkEvents"]= {
			[1]= {
				["unitDelay"] = 0.1,
				["flyCueId"] = 331040005,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3310404,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331040004,},
				},
			},
			[10]= {
				["state"]= {
				},
			},
			[2]= {
				["state"]= {
				},
			},
		},

	},
	[3310405] = {
		["bhEvent"] = "skill.3310405",
		["atkEvents"]= {
			[1]= {
				["delay"] = 0.5,
				["flyCueId"] = 331040039,
				["eventType"] = 1,
				["boxId"] = 3310405,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331040004,},
				},
			},
			[2]= {
				["targetArea"] = 3,
				["boxId"] = 3310407,
				["state"]= {
				},
			},
			[10]= {
				["delay"] = 0.4,
				["flyCueId"] = 331040039,
				["boxType"] = 1,
				["state"]= {
				},
			},
		},

	},
	[3310406] = {
		["bhEvent"] = "skill.3310406",
		["atkEvents"]= {
			[1]= {
				["unitDelay"] = 0.1,
				["flyCueId"] = 331040005,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3310406,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331040004,},
				},
			},
		},

	},
	[3310458] = {
		["bhEvent"] = "skill.3310458",
		["atkEvents"]= {
			[1]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 3310408,
					["duration"] = 8,
				},
			},
		},

		["actTime"] = 45,
		["skillTarget"] = 1,
	},
	[3310409] = {
		["bhEvent"] = "skill.3310409",
		["atkEvents"]= {
			[1]= {
				["unitDelay"] = 0.1,
				["flyCueId"] = 331040041,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3310401,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331040004,},
				},
			},
		},

	},
	[3310410] = {
		["bhEvent"] = "skill.3310410",
		["atkEvents"]= {
			[1]= {
				["targetChoose"] = 7,
				["unitDelay"] = 0.1,
				["flyCueId"] = 331040041,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3310403,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331040021,},
				},
				["randomTargetNumber"] = 2,
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
