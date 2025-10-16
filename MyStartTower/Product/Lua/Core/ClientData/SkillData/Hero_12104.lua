local Data = {
["cueFile"] = "11006",
	[1210409] = {
		["bhEvent"] = "skill.1210409",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
			},
			[0]= {
				["eventType"] = 1,
				["boxId"] = 1210409,
				["state"]= {
				},
			},
		},

	},
	[1210410] = {
		["bhEvent"] = "skill.1210410",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
			},
			[0]= {
				["eventType"] = 1,
				["boxId"] = 1210409,
				["state"]= {
				},
			},
		},

	},
	[1210429] = {
		["bhEvent"] = "skill.1210429",
		["atkEvents"]= {
			[100]= {
				["state"]= {
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {0,0,0,},
				},
			},
			[1001]= {
				["eventType"] = 1,
				["boxId"] = 1210429,
				["state"]= {
					["stateId"] = 1210403,
					["duration"] = 2,
				},
				["hitCue"]= {
					["cueList"] = {10000057,},
				},
				["stunTime"] = 2,
				["subEventSkill"] = 1210429,
				["subEventId"] = 1011,
			},
			[1002]= {
				["eventType"] = 1,
				["boxId"] = 1210430,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000055,},
				},
			},
			[1003]= {
				["state"]= {
					["stateOperation"] = 1,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {1210401,1210402,},
				},
			},
			[1004]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1210421,
					["duration"] = -999,
				},
				["subEventSkill"] = 1210429,
				["subEventId"] = 1005,
			},
			[1005]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1210422,
					["duration"] = -999,
				},
				["subEventSkill"] = 1210429,
				["subEventId"] = 1006,
			},
			[1006]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1210423,
					["duration"] = -999,
				},
				["subEventSkill"] = 1210429,
				["subEventId"] = 1007,
			},
			[1007]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1210424,
					["duration"] = -999,
				},
				["subEventSkill"] = 1210429,
				["subEventId"] = 1008,
			},
			[1008]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1210425,
					["duration"] = -999,
				},
			},
			[1009]= {
				["state"]= {
					["stateId"] = 1210405,
					["duration"] = 1,
				},
			},
			[1010]= {
				["targetArea"] = 3,
				["delay"] = 1,
				["boxType"] = 1,
				["boxId"] = 1210431,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000008,},
				},
			},
			[1011]= {
				["state"]= {
					["stateId"] = 1210405,
					["duration"] = 2,
				},
			},
			[1012]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1210426,
					["duration"] = 8,
				},
				["eventCondition"] = "1,1,1210426,1",
			},
			[1013]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1210427,
					["duration"] = 8,
				},
				["eventCondition"] = "1,1,1210427,1",
			},
			[1014]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1210428,
					["duration"] = 8,
				},
				["eventCondition"] = "1,1,1210428,1",
			},
			[1015]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1210429,
					["duration"] = 8,
				},
				["eventCondition"] = "1,1,1210429,1",
			},
			[1016]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1210430,
					["duration"] = 8,
				},
				["eventCondition"] = "1,1,1210430,1",
			},
			[1017]= {
				["targetArea"] = 3,
				["state"]= {
					["stateOperation"] = 2,
					["duration"] = 8,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {1210426,},
				},
				["eventCondition"] = "1,1,1210426",
			},
			[1018]= {
				["targetArea"] = 3,
				["state"]= {
					["stateOperation"] = 2,
					["duration"] = 8,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {1210427,},
				},
				["eventCondition"] = "1,1,1210427",
			},
			[1019]= {
				["targetArea"] = 3,
				["state"]= {
					["stateOperation"] = 2,
					["duration"] = 8,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {1210428,},
				},
				["eventCondition"] = "1,1,1210428",
			},
			[1020]= {
				["targetArea"] = 3,
				["state"]= {
					["stateOperation"] = 2,
					["duration"] = 8,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {1210429,},
				},
				["eventCondition"] = "1,1,1210429",
			},
			[1021]= {
				["targetArea"] = 3,
				["state"]= {
					["stateOperation"] = 2,
					["duration"] = 8,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {1210430,},
				},
				["eventCondition"] = "1,1,1210430",
			},
		},

	},
	[1210459] = {
		["bhEvent"] = "skill.1210459",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
			},
			[1001]= {
				["targetArea"] = 3,
				["state"]= {
					["stateOperation"] = 1,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {1210406,},
				},
			},
			[1002]= {
				["targetChoose"] = 7,
				["state"]= {
					["stateId"] = 1210404,
					["duration"] = -999,
				},
				["eventCondition"] = "1,1,1210406",
			},
			[1003]= {
				["state"]= {
					["stateId"] = 1210405,
					["duration"] = 1,
				},
				["subEventSkill"] = 1210459,
				["subEventId"] = 1004,
			},
			[1004]= {
				["state"]= {
					["stateOperation"] = 1,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {1210404,},
				},
				["subEventSkill"] = 1210459,
				["subEventId"] = 1005,
			},
			[1005]= {
				["targetArea"] = 3,
				["boxId"] = 1210461,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000008,},
				},
			},
			[0]= {
				["targetChoose"] = 7,
				["eventType"] = 1,
				["boxId"] = 1210459,
				["state"]= {
				},
				["subEventSkill"] = 1210459,
				["subEventId"] = 1002,
			},
			[2]= {
				["targetChoose"] = 7,
				["boxId"] = 1210460,
				["state"]= {
					["stateId"] = 1210403,
					["duration"] = 2,
				},
				["hitCue"]= {
					["cueList"] = {10000057,},
				},
				["stunTime"] = 2,
				["randomTargetNumber"] = 1,
				["filterChuyin"] = 1,
				["randomRule"] = 1,
				["recordSkillTargets"] = 1,
				["subEventSkill"] = 1210459,
				["subEventId"] = 1007,
				["eventCondition"] = "1,1,1210406",
			},
			[1006]= {
				["state"]= {
					["stateId"] = 1210405,
					["duration"] = 1,
				},
			},
			[1]= {
				["state"]= {
				},
			},
			[33]= {
				["state"]= {
				},
			},
			[1007]= {
				["targetChoose"] = 12,
				["state"]= {
					["stateId"] = 1210405,
					["duration"] = 2,
				},
				["subEventSkill"] = 1210459,
				["subEventId"] = 1001,
				["eventCondition"] = "1,1,1210406",
			},
		},

		["actTime"] = 65,
		["hideEffect"] = 1,
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
