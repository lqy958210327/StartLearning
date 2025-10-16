local Data = {
["cueFile"] = "13203",
	[1320309] = {
		["bhEvent"] = "skill.1320309",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {132030001,132030004,132031001,},
				},
			},
			[1]= {
				["unitDelay"] = 0.12,
				["flyCueId"] = 132030007,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1320309,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {132030010,132031002,},
				},
			},
			[1001]= {
				["eventType"] = 1,
				["boxId"] = 1320310,
				["state"]= {
				},
				["disablePassive"] = 1,
				["subEventSkill"] = 1320309,
				["subRandomEvents"] = "1002,1003,1004,1005,1006,1007",
				["subRandomNum"] = 1,
			},
			[1002]= {
				["state"]= {
				},
				["stunTime"] = 1,
			},
			[1003]= {
				["state"]= {
				},
				["addManaNumber"] = -10,
			},
			[1004]= {
				["state"]= {
					["stateId"] = 1000001,
					["duration"] = 5,
				},
			},
			[1005]= {
				["state"]= {
					["stateId"] = 1000003,
					["duration"] = 5,
				},
			},
			[1006]= {
				["state"]= {
					["stateId"] = 1000004,
					["duration"] = 3,
				},
			},
			[1007]= {
				["state"]= {
					["stateId"] = 1000006,
					["duration"] = 2,
				},
			},
		},

	},
	[1320310] = {
		["bhEvent"] = "skill.1320310",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {132030002,132030005,132031003,},
				},
			},
			[1]= {
				["unitDelay"] = 0.12,
				["flyCueId"] = 132030008,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1320309,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {132030010,132031002,},
				},
			},
		},

	},
	[1320311] = {
		["bhEvent"] = "skill.1320311",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {132030003,132030006,132031004,},
				},
			},
			[1]= {
				["unitDelay"] = 0.12,
				["flyCueId"] = 132030009,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1320309,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {132030010,132031002,},
				},
			},
		},

	},
	[1320329] = {
		["bhEvent"] = "skill.1320329",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {132030011,132030012,132031005,},
				},
			},
			[1]= {
				["unitDelay"] = 0.12,
				["flyCueId"] = 132030013,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1320309,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {132030014,132031006,},
				},
			},
			[2]= {
				["targetChoose"] = 7,
				["unitDelay"] = 0.12,
				["flyCueId"] = 132030013,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1320329,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {132030014,},
				},
				["disablePassive"] = 1,
				["eventCondition"] = "1,3,1320301",
			},
		},

	},
	[1320359] = {
		["bhEvent"] = "skill.1320359",
		["atkEvents"]= {
			[100]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1320303,
					["duration"] = 3,
				},
				["atkCue"]= {
					["cueList"] = {132030015,132030016,132030017,132030019,132030027,132030028,132030029,132030030,132030031,132030032,132030033,132030034,132030035,132030036,132030037,},
				},
			},
			[13]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {132030020,132035001,132031008,},
				},
			},
			[1]= {
				["targetChoose"] = 12,
				["boxId"] = 1320359,
				["state"]= {
					["stateId"] = 1320301,
					["duration"] = 5,
				},
				["subEventType"] = 1,
			},
			[3]= {
				["targetChoose"] = 7,
				["state"]= {
				},
				["randomTargetNumber"] = 3,
				["randomRule"] = 2,
				["recordSkillTargets"] = 1,
			},
			[2]= {
				["targetArea"] = 3,
				["state"]= {
				},
			},
			[11]= {
				["targetChoose"] = 12,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {132030018,},
				},
				["hitedAnim"] = "Hit",
			},
			[27]= {
				["targetChoose"] = 12,
				["state"]= {
				},
				["hitedAnim"] = "Hit",
			},
			[90]= {
				["targetChoose"] = 12,
				["state"]= {
				},
				["hitedAnim"] = "end",
			},
			[15]= {
				["targetChoose"] = 12,
				["state"]= {
				},
				["subEventType"] = 1,
				["subEventSkill"] = 1320359,
				["subRandomEvents"] = "1002,1003,1004,1005,1006,1007",
				["subRandomNum"] = 1,
			},
			[91]= {
				["targetArea"] = 3,
				["state"]= {
					["stateOperation"] = 1,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {1320303,},
				},
			},
			[1001]= {
				["targetChoose"] = 12,
				["state"]= {
					["stateId"] = 1320301,
					["duration"] = 5,
				},
			},
			[1002]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1320351,
					["duration"] = 1,
				},
				["atkCue"]= {
					["cueList"] = {132030021,},
				},
				["subEventSkill"] = 1320359,
				["subEventId"] = 1009,
				["eventCondition"] = "1,1,1320308,1",
			},
			[1003]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1320352,
					["duration"] = 1,
				},
				["atkCue"]= {
					["cueList"] = {132030022,},
				},
				["subEventSkill"] = 1320359,
				["subEventId"] = 1010,
				["eventCondition"] = "1,1,1320308,1",
			},
			[1004]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1320353,
					["duration"] = 1,
				},
				["atkCue"]= {
					["cueList"] = {132030023,},
				},
				["subEventSkill"] = 1320359,
				["subEventId"] = 1011,
				["eventCondition"] = "1,1,1320308,1",
			},
			[1005]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1320354,
					["duration"] = 1,
				},
				["atkCue"]= {
					["cueList"] = {132030024,},
				},
				["subEventSkill"] = 1320359,
				["subEventId"] = 1012,
				["eventCondition"] = "1,1,1320308,1",
			},
			[1006]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1320355,
					["duration"] = 1,
				},
				["atkCue"]= {
					["cueList"] = {132030025,},
				},
				["subEventSkill"] = 1320359,
				["subEventId"] = 1013,
				["eventCondition"] = "1,1,1320308,1",
			},
			[1007]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1320356,
					["duration"] = 1,
				},
				["atkCue"]= {
					["cueList"] = {132030026,},
				},
				["subEventSkill"] = 1320359,
				["subEventId"] = 1014,
				["eventCondition"] = "1,1,1320308,1",
			},
			[1008]= {
				["targetArea"] = 3,
				["state"]= {
					["stateOperation"] = 1,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {1320308,1320309,},
				},
			},
			[1009]= {
				["targetChoose"] = 12,
				["delay"] = 1.7,
				["boxType"] = 1,
				["state"]= {
				},
				["stunTime"] = 1,
			},
			[1010]= {
				["targetChoose"] = 12,
				["delay"] = 1.7,
				["boxType"] = 1,
				["state"]= {
					["stateId"] = 1000001,
					["duration"] = 5,
				},
			},
			[1011]= {
				["targetChoose"] = 12,
				["delay"] = 1.7,
				["boxType"] = 1,
				["state"]= {
					["stateId"] = 1000003,
					["duration"] = 5,
				},
			},
			[1012]= {
				["targetChoose"] = 12,
				["delay"] = 1.7,
				["boxType"] = 1,
				["state"]= {
				},
				["addManaNumber"] = -10,
			},
			[1013]= {
				["targetChoose"] = 12,
				["delay"] = 1.7,
				["boxType"] = 1,
				["state"]= {
					["stateId"] = 1000004,
					["duration"] = 3,
				},
			},
			[1014]= {
				["targetChoose"] = 12,
				["delay"] = 1.7,
				["boxType"] = 1,
				["state"]= {
					["stateId"] = 1000006,
					["duration"] = 2,
				},
			},
			[1015]= {
				["state"]= {
				},
				["addManaNumber"] = -10,
				["stunTime"] = 1,
			},
			[4]= {
				["targetChoose"] = 7,
				["state"]= {
					["stateOperation"] = 1,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {1320312,},
				},
				["eventCondition"] = "0",
			},
			[5]= {
				["targetChoose"] = 12,
				["state"]= {
					["stateId"] = 1320312,
					["duration"] = -999,
				},
				["eventCondition"] = "1,1,1320311",
			},
		},

		["actTime"] = 90,
		["hideEffect"] = 1,
		["videoActTime"] = 65,
		["videoActCue"]= {
			["cueList"] = {132038001,132031007,},
		},
		["hideTime"] = 10,
		["hideEvent"] = 3,
		["prepareCamera"] = 1,
		["prepareCamDruation"] = 40,
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
