local Data = {
["cueFile"] = "32106",
	[3210601] = {
		["bhEvent"] = "skill.3210601",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {321060001,321061001,},
				},
			},
			[1]= {
				["boxId"] = 3210601,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {321060004,},
				},
			},
		},

	},
	[3210602] = {
		["bhEvent"] = "skill.3210602",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {321060002,321061002,},
				},
			},
			[1]= {
				["boxId"] = 3210601,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {321060005,},
				},
			},
		},

	},
	[3210603] = {
		["bhEvent"] = "skill.3210603",
		["atkEvents"]= {
			[100]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 3210604,
					["duration"] = 2,
				},
				["atkCue"]= {
					["cueList"] = {321060003,321061003,},
				},
			},
			[1]= {
				["boxId"] = 3210603,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {321060006,},
				},
			},
		},

	},
	[3210621] = {
		["bhEvent"] = "skill.3210621",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {321060008,321061004,},
				},
			},
			[1]= {
				["targetArea"] = 2,
				["targetChoose"] = 3,
				["boxId"] = 3210621,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {321060009,},
				},
			},
			[2]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 3210601,
					["duration"] = 5,
				},
			},
		},

	},
	[3210622] = {
		["bhEvent"] = "skill.3210622",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {321060008,321061004,},
				},
			},
			[1]= {
				["targetArea"] = 2,
				["targetChoose"] = 3,
				["boxId"] = 3210622,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {321060009,},
				},
			},
			[2]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 3210601,
					["duration"] = 5,
				},
			},
		},

	},
	[3210651] = {
		["bhEvent"] = "skill.3210651",
		["atkEvents"]= {
			[100]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 3210613,
					["duration"] = 2,
				},
				["atkCue"]= {
					["cueList"] = {321060010,321061005,},
				},
			},
			[2]= {
				["targetArea"] = 3,
				["boxId"] = 3210660,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000062,},
				},
			},
			[1]= {
				["targetArea"] = 3,
				["boxId"] = 3210651,
				["state"]= {
					["stateId"] = 3210602,
					["duration"] = 5,
				},
			},
			[1001]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {10000057,},
				},
			},
			[1002]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 3210607,
					["duration"] = 1,
				},
			},
			[1003]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 3210608,
					["duration"] = 1,
				},
			},
			[3]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 3210609,
					["duration"] = -999,
				},
			},
			[1004]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 3210611,
					["duration"] = -999,
				},
			},
		},

		["actTime"] = 60,
		["skillTarget"] = 1,
	},
	[3210652] = {
		["bhEvent"] = "skill.3210652",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {321060012,321060013,321061006,},
				},
			},
			[2]= {
				["targetArea"] = 2,
				["targetChoose"] = 7,
				["state"]= {
				},
				["controlTime"] = 5,
				["controlAniName"] = "timelock",
			},
			[3]= {
				["targetArea"] = 3,
				["state"]= {
					["stateOperation"] = 1,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {3210611,},
				},
			},
			[4]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 3210612,
					["duration"] = 5,
				},
			},
			[1]= {
				["targetChoose"] = 7,
				["boxId"] = 3210652,
				["state"]= {
				},
			},
		},

		["actTime"] = 40,
		["skillTarget"] = 1,
	},
	[3210653] = {
		["bhEvent"] = "skill.3210653",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {321060015,321061007,},
				},
			},
			[1]= {
				["targetChoose"] = 7,
				["unitDelay"] = 0.12,
				["eventType"] = 1,
				["boxId"] = 3210653,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000062,321061008,},
				},
				["eventCondition"] = "1,2,3210610",
			},
			[2]= {
				["targetChoose"] = 7,
				["unitDelay"] = 0.12,
				["flyCueId"] = 321060016,
				["boxType"] = 1,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {321060017,},
				},
				["controlTime"] = 5,
				["controlAniName"] = "timelock",
				["eventCondition"] = "1,2,3210610",
			},
			[10]= {
				["targetChoose"] = 7,
				["state"]= {
					["stateId"] = 3210610,
					["duration"] = 5,
				},
			},
			[3]= {
				["targetArea"] = 3,
				["state"]= {
					["stateOperation"] = 1,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {3210611,},
				},
			},
			[4]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 3210612,
					["duration"] = 5,
				},
			},
		},

		["actTime"] = 45,
		["skillTarget"] = 1,
	},
	[3210654] = {
		["bhEvent"] = "skill.3210654",
		["atkEvents"]= {
			[100]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {321060010,321061005,},
				},
			},
			[1]= {
				["targetArea"] = 3,
				["boxId"] = 3210655,
				["state"]= {
					["stateId"] = 3210615,
					["duration"] = 5,
				},
			},
			[2]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 3210618,
					["duration"] = 6,
				},
			},
			[1001]= {
				["targetArea"] = 3,
				["state"]= {
					["stateOperation"] = 1,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {3210618,},
				},
			},
			[1002]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 3210617,
					["duration"] = 1,
				},
			},
		},

		["actTime"] = 60,
		["skillTarget"] = 1,
	},
	[3210604] = {
		["bhEvent"] = "skill.3210604",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {321060001,321061001,},
				},
			},
			[1]= {
				["eventType"] = 1,
				["boxId"] = 3210604,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {321060004,},
				},
			},
		},

	},
	[3210605] = {
		["bhEvent"] = "skill.3210605",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {321060002,321061002,},
				},
			},
			[1]= {
				["eventType"] = 1,
				["boxId"] = 3210604,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {321060005,},
				},
			},
		},

	},
	[3210623] = {
		["bhEvent"] = "skill.3210623",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {321060008,321061004,},
				},
			},
			[1]= {
				["targetArea"] = 2,
				["targetChoose"] = 3,
				["eventType"] = 1,
				["boxId"] = 3210623,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {321060009,},
				},
			},
		},

	},
	[3210655] = {
		["bhEvent"] = "skill.3210655",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {321060012,321060013,321061006,},
				},
			},
			[1]= {
				["targetChoose"] = 7,
				["eventType"] = 1,
				["boxId"] = 3210654,
				["state"]= {
				},
			},
			[2]= {
				["targetChoose"] = 7,
				["state"]= {
				},
				["controlTime"] = 1,
				["controlAniName"] = "timelock",
			},
		},

		["actTime"] = 40,
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
