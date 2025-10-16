local Data = {
["cueFile"] = "33113",
	[3311301] = {
		["bhEvent"] = "skill.3311301",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331130001,},
				},
			},
			[1]= {
				["unitDelay"] = 0.08,
				["flyCueId"] = 331130002,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3311301,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000062,331131002,},
				},
			},
		},

	},
	[3311321] = {
		["bhEvent"] = "skill.3311321",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331130005,331131004,},
				},
			},
			[1]= {
				["targetArea"] = 3,
				["summonMonsters"] = "3311310",
				["summonLineChoose"] = 2,
				["state"]= {
				},
			},
			[1001]= {
				["unitDelay"] = 0.15,
				["flyCueId"] = 331130003,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3311321,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331130004,},
				},
			},
			[2]= {
				["targetArea"] = 3,
				["summonMonsters"] = "3311310",
				["summonLineChoose"] = 4,
				["state"]= {
				},
			},
			[1002]= {
				["unitDelay"] = 0.3,
				["flyCueId"] = 331130011,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3311322,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331130008,},
				},
				["stunTime"] = 0.5,
				["subEventSkill"] = 3311321,
				["subEventId"] = 1003,
			},
			[1003]= {
				["targetChoose"] = 3,
				["unitDelay"] = 0.3,
				["flyCueId"] = 331130011,
				["baseToTarget"] = 1,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3311322,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331130008,},
				},
				["stunTime"] = 0.5,
				["randomTargetNumber"] = 1,
				["excludeTarget"] = 1,
				["subEventSkill"] = 3311321,
				["subEventId"] = 1004,
			},
			[1004]= {
				["targetChoose"] = 3,
				["unitDelay"] = 0.3,
				["flyCueId"] = 331130011,
				["baseToTarget"] = 1,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3311322,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331130008,},
				},
				["stunTime"] = 0.5,
				["randomTargetNumber"] = 1,
				["excludeTarget"] = 1,
				["subEventSkill"] = 3311321,
				["subEventId"] = 1005,
			},
			[1005]= {
				["targetChoose"] = 3,
				["unitDelay"] = 0.3,
				["flyCueId"] = 331130011,
				["baseToTarget"] = 1,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3311322,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331130008,},
				},
				["stunTime"] = 0.5,
				["randomTargetNumber"] = 1,
				["excludeTarget"] = 1,
			},
		},

		["skillTarget"] = 1,
	},
	[3311351] = {
		["bhEvent"] = "skill.3311301",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331130006,331131006,},
				},
			},
			[1]= {
				["unitDelay"] = 0.1,
				["flyCueId"] = 331130007,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3311351,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331130008,331131007,},
				},
				["stunTime"] = 0.2,
				["subEventSkill"] = 3311351,
				["subEventId"] = 1001,
			},
			[1001]= {
				["targetChoose"] = 3,
				["unitDelay"] = 0.3,
				["flyCueId"] = 331130011,
				["baseToTarget"] = 1,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3311351,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331130008,},
				},
				["stunTime"] = 0.2,
				["randomTargetNumber"] = 1,
				["excludeTarget"] = 1,
				["subEventSkill"] = 3311351,
				["subEventId"] = 1002,
			},
			[1002]= {
				["targetChoose"] = 3,
				["unitDelay"] = 0.3,
				["flyCueId"] = 331130011,
				["baseToTarget"] = 1,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3311351,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331130008,},
				},
				["stunTime"] = 0.2,
				["randomTargetNumber"] = 1,
				["excludeTarget"] = 1,
				["subEventSkill"] = 3311351,
				["subEventId"] = 1003,
			},
			[1003]= {
				["targetChoose"] = 3,
				["unitDelay"] = 0.3,
				["flyCueId"] = 331130011,
				["baseToTarget"] = 1,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3311351,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331130008,},
				},
				["stunTime"] = 0.2,
				["randomTargetNumber"] = 1,
				["excludeTarget"] = 1,
			},
		},

		["actTime"] = 35,
	},
	[3311352] = {
		["bhEvent"] = "skill.3311352",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331130009,331130012,331131005,},
				},
			},
			[1]= {
				["targetChoose"] = 7,
				["eventType"] = 1,
				["boxId"] = 3311352,
				["state"]= {
					["stateId"] = 3311301,
					["duration"] = 5,
				},
				["hitCue"]= {
					["cueList"] = {331130010,},
				},
			},
		},

		["actTime"] = 60,
		["skillTarget"] = 1,
	},
	[3311353] = {
		["bhEvent"] = "skill.3311353",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331130009,331130012,331131005,},
				},
			},
			[1]= {
				["targetChoose"] = 10,
				["eventType"] = 1,
				["boxId"] = 3311352,
				["state"]= {
					["stateId"] = 3311301,
					["duration"] = 5,
				},
				["hitCue"]= {
					["cueList"] = {331130010,},
				},
			},
		},

		["actTime"] = 60,
		["skillTarget"] = 1,
	},
	[3311354] = {
		["bhEvent"] = "skill.3311354",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331130009,331130012,331131005,},
				},
			},
			[1]= {
				["targetChoose"] = 7,
				["eventType"] = 1,
				["boxId"] = 3311354,
				["state"]= {
					["stateId"] = 3311302,
					["duration"] = -999,
				},
				["hitCue"]= {
					["cueList"] = {331130010,},
				},
			},
			[1001]= {
				["targetArea"] = 3,
				["state"]= {
					["stateOperation"] = 1,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {3311304,},
				},
			},
		},

		["actTime"] = 60,
	},
	[3311355] = {
		["bhEvent"] = "skill.3311355",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331130006,331131006,},
				},
			},
			[1]= {
				["unitDelay"] = 0.1,
				["flyCueId"] = 331130007,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3311355,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331130008,331131007,},
				},
				["stunTime"] = 1,
				["subEventSkill"] = 3311355,
				["subEventId"] = 1001,
			},
			[1001]= {
				["targetChoose"] = 3,
				["unitDelay"] = 0.1,
				["flyCueId"] = 331130007,
				["baseToTarget"] = 1,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3311355,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331130008,331131007,},
				},
				["stunTime"] = 1,
				["randomTargetNumber"] = 1,
				["excludeTarget"] = 1,
				["subEventSkill"] = 3311355,
				["subEventId"] = 1002,
			},
			[1002]= {
				["targetChoose"] = 3,
				["unitDelay"] = 0.1,
				["flyCueId"] = 331130007,
				["baseToTarget"] = 1,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3311355,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331130008,331131007,},
				},
				["stunTime"] = 1,
				["randomTargetNumber"] = 1,
				["excludeTarget"] = 1,
				["subEventSkill"] = 3311355,
				["subEventId"] = 1003,
			},
			[1003]= {
				["targetChoose"] = 3,
				["unitDelay"] = 0.1,
				["flyCueId"] = 331130007,
				["baseToTarget"] = 1,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3311355,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331130008,331131007,},
				},
				["stunTime"] = 1,
				["randomTargetNumber"] = 1,
				["excludeTarget"] = 1,
			},
		},

		["actTime"] = 35,
	},
	[3311356] = {
		["bhEvent"] = "skill.3311356",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331130005,331131004,},
				},
			},
			[2]= {
				["targetChoose"] = 4,
				["unitDelay"] = 0.1,
				["flyCueId"] = 331130007,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3311356,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000062,},
				},
				["baseCue"]= {
					["cueList"] = {10000086,},
				},
				["stunTime"] = 1,
			},
			[1]= {
				["targetChoose"] = 4,
				["unitDelay"] = 0.1,
				["flyCueId"] = 331130007,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3311356,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000062,},
				},
				["baseCue"]= {
					["cueList"] = {10000086,},
				},
				["stunTime"] = 1,
			},
		},

		["actTime"] = 50,
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
