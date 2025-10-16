local Data = {
["cueFile"] = "14013",
	[1401309] = {
		["bhEvent"] = "skill.1401309",
		["atkEvents"]= {
			[1]= {
				["unitDelay"] = 0.1,
				["flyCueId"] = 140130002,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1401309,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {140130003,140131003,},
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {140130001,140130004,140131001,},
				},
			},
		},

	},
	[1401310] = {
		["bhEvent"] = "skill.1401310",
		["atkEvents"]= {
			[1]= {
				["unitDelay"] = 0.1,
				["flyCueId"] = 140130002,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1401309,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {140130003,140131003,},
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {140130001,140130004,140131002,},
				},
			},
		},

	},
	[1401359] = {
		["bhEvent"] = "skill.1401359",
		["atkEvents"]= {
			[1]= {
				["targetArea"] = 3,
				["targetChoose"] = 18,
				["state"]= {
					["stateId"] = 1401301,
					["duration"] = 12,
				},
				["subEventSkill"] = 1401359,
				["subEventId"] = 1001,
			},
			[1001]= {
				["targetArea"] = 3,
				["targetChoose"] = 18,
				["delay"] = 0.5,
				["flyCueId"] = 140130008,
				["baseToTarget"] = 1,
				["state"]= {
					["stateId"] = 1401302,
					["duration"] = 12,
				},
				["subEventSkill"] = 1401359,
				["subEventId"] = 1006,
				["eventCondition"] = "1,1,1401305",
			},
			[1002]= {
				["targetArea"] = 3,
				["targetChoose"] = 18,
				["state"]= {
					["stateId"] = 82140131,
					["duration"] = 12,
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {140130011,140130012,},
				},
			},
			[10]= {
				["targetArea"] = 3,
				["targetChoose"] = 18,
				["delay"] = 0.5,
				["flyCueId"] = 140130013,
				["boxType"] = 1,
				["state"]= {
				},
				["recordSkillTargets"] = 1,
			},
			[11]= {
				["targetChoose"] = 12,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {140130014,140130015,},
				},
			},
			[13]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {140130017,140135001,140131008,},
				},
			},
			[1003]= {
				["targetArea"] = 3,
				["targetChoose"] = 7,
				["boxId"] = 1401359,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000047,},
				},
				["eventCondition"] = "1,2,1401301",
			},
			[1004]= {
				["targetArea"] = 3,
				["state"]= {
					["stateOperation"] = 1,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {1401305,},
				},
			},
			[2]= {
				["eventProbId"] = 1401301,
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1401301,
					["duration"] = 6,
				},
				["subEventSkill"] = 1401359,
				["subEventId"] = 1005,
			},
			[1005]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 82140131,
					["duration"] = 6,
				},
				["eventCondition"] = "1,1,82140130",
			},
			[3]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["subEventSkill"] = 1401359,
				["subEventId"] = 1007,
				["eventCondition"] = "1,1,8791190",
			},
			[1006]= {
				["targetArea"] = 3,
				["targetChoose"] = 18,
				["state"]= {
					["stateId"] = 1401399,
					["duration"] = 12,
				},
				["eventCondition"] = "1,1,1401399",
			},
			[1007]= {
				["targetArea"] = 3,
				["targetChoose"] = 4,
				["state"]= {
					["stateId"] = 8791191,
					["duration"] = 12,
				},
				["randomTargetNumber"] = 2,
				["randomRule"] = 1,
				["eventCondition"] = "1,2,1401301,1",
			},
		},

		["actTime"] = 95,
		["hideEffect"] = 1,
		["videoActTime"] = 70,
		["videoActCue"]= {
			["cueList"] = {140138001,140131007,},
		},
		["prepareCamera"] = 1,
		["prepareCamDruation"] = 35,
	},
	[1401329] = {
		["bhEvent"] = "skill.1401329",
		["atkEvents"]= {
			[1]= {
				["unitDelay"] = 0.12,
				["flyCueId"] = 140130007,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1401330,
				["state"]= {
					["stateId"] = 1401306,
					["duration"] = 4,
				},
				["hitCue"]= {
					["cueList"] = {140130009,140131006,},
				},
				["stunTime"] = 0.5,
				["subEventSkill"] = 1401329,
				["subEventId"] = 1001,
			},
			[1001]= {
				["targetChoose"] = 3,
				["delay"] = 0.5,
				["flyCueId"] = 140130008,
				["baseToTarget"] = 1,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1401329,
				["state"]= {
					["stateId"] = 1401306,
					["duration"] = 4,
				},
				["hitCue"]= {
					["cueList"] = {140130009,140131006,},
				},
				["stunTime"] = 0.5,
				["randomTargetNumber"] = 1,
				["excludeTarget"] = 1,
				["subEventSkill"] = 1401329,
				["subEventId"] = 1002,
			},
			[1002]= {
				["targetChoose"] = 3,
				["delay"] = 0.5,
				["flyCueId"] = 140130008,
				["baseToTarget"] = 1,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1401329,
				["state"]= {
					["stateId"] = 1401306,
					["duration"] = 4,
				},
				["hitCue"]= {
					["cueList"] = {140130009,140131006,},
				},
				["randomTargetNumber"] = 1,
				["excludeTarget"] = 1,
				["subEventSkill"] = 1401329,
				["subEventId"] = 1003,
			},
			[1003]= {
				["targetChoose"] = 3,
				["delay"] = 0.5,
				["flyCueId"] = 140130008,
				["baseToTarget"] = 1,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1401329,
				["state"]= {
					["stateId"] = 1401306,
					["duration"] = 4,
				},
				["hitCue"]= {
					["cueList"] = {140130009,140131006,},
				},
				["randomTargetNumber"] = 1,
				["excludeTarget"] = 1,
				["subEventSkill"] = 1401329,
				["subEventId"] = 1004,
			},
			[1004]= {
				["targetChoose"] = 3,
				["delay"] = 0.5,
				["flyCueId"] = 140130008,
				["baseToTarget"] = 1,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1401329,
				["state"]= {
					["stateId"] = 1401306,
					["duration"] = 4,
				},
				["hitCue"]= {
					["cueList"] = {140130009,140131006,},
				},
				["randomTargetNumber"] = 1,
				["excludeTarget"] = 1,
				["subEventSkill"] = 1401329,
				["subEventId"] = 1005,
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {140130005,140130006,140131004,},
				},
			},
			[1005]= {
				["targetChoose"] = 3,
				["delay"] = 0.5,
				["flyCueId"] = 140130008,
				["baseToTarget"] = 1,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1401329,
				["state"]= {
					["stateId"] = 1401306,
					["duration"] = 4,
				},
				["hitCue"]= {
					["cueList"] = {140130009,140131006,},
				},
				["randomTargetNumber"] = 1,
				["excludeTarget"] = 1,
				["subEventSkill"] = 1401329,
				["subEventId"] = 1006,
			},
			[1006]= {
				["targetChoose"] = 3,
				["delay"] = 0.5,
				["flyCueId"] = 140130008,
				["baseToTarget"] = 1,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1401329,
				["state"]= {
					["stateId"] = 1401306,
					["duration"] = 4,
				},
				["hitCue"]= {
					["cueList"] = {140130009,140131006,},
				},
				["randomTargetNumber"] = 1,
				["excludeTarget"] = 1,
				["subEventSkill"] = 1401329,
				["subEventId"] = 1008,
				["eventCondition"] = "1,1,1401311",
			},
			[1007]= {
				["targetChoose"] = 3,
				["delay"] = 0.5,
				["flyCueId"] = 140130008,
				["baseToTarget"] = 1,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1401331,
				["state"]= {
					["stateId"] = 1401306,
					["duration"] = 4,
				},
				["hitCue"]= {
					["cueList"] = {140130009,140131006,},
				},
				["randomTargetNumber"] = 1,
				["excludeTarget"] = 1,
			},
			[1008]= {
				["state"]= {
					["stateId"] = 1401312,
					["duration"] = 4,
				},
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
