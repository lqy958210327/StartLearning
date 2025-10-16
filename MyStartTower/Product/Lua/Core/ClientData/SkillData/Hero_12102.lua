local Data = {
["cueFile"] = "12102",
	[1210209] = {
		["bhEvent"] = "skill.1210209",
		["atkEvents"]= {
			[100]= {
				["targetArea"] = 3,
				["targetChoose"] = 4,
				["state"]= {
					["stateId"] = 1210202,
					["duration"] = 3,
				},
				["atkCue"]= {
					["cueList"] = {121020001,121021001,},
				},
				["excludeTarget"] = 1,
				["subEventSkill"] = 1210259,
				["subEventId"] = 1002,
				["eventCondition"] = "1,1,1210201",
			},
			[0]= {
				["eventType"] = 1,
				["boxId"] = 1210209,
				["state"]= {
				},
			},
		},

	},
	[1210229] = {
		["bhEvent"] = "skill.1210229",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
			},
			[1001]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1210201,
					["duration"] = -999,
				},
			},
			[1002]= {
				["targetChoose"] = 23,
				["delay"] = 0.1,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {121020004,121020005,121021003,},
				},
				["subEventSkill"] = 1210229,
				["subEventId"] = 1006,
			},
			[1003]= {
				["targetArea"] = 3,
				["delay"] = 0.1,
				["boxType"] = 1,
				["state"]= {
				},
				["levelAtkEvents"]= {
					[2]= {
						["state"]= {
							["stateId"] = 1210203,
							["duration"] = -999,
						},
					},
					[3]= {
						["state"]= {
							["stateId"] = 1210203,
							["duration"] = -999,
						},
					},
					[4]= {
						["state"]= {
							["duration"] = -999,
						},
					},
					[5]= {
						["state"]= {
							["duration"] = -999,
						},
					},
					[6]= {
						["state"]= {
							["duration"] = -999,
						},
					},
				},

			},
			[1004]= {
				["targetChoose"] = 23,
				["delay"] = 0.1,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {121020007,121020008,121021003,},
				},
				["subEventSkill"] = 1210229,
				["subEventId"] = 1005,
			},
			[1005]= {
				["targetChoose"] = 23,
				["delay"] = 0.5,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1210231,
				["state"]= {
				},
				["subEventSkill"] = 1000121,
				["subEventId"] = 1080,
			},
			[1006]= {
				["targetChoose"] = 23,
				["delay"] = 0.5,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1210229,
				["state"]= {
				},
				["subEventSkill"] = 1000121,
				["subEventId"] = 1080,
			},
			[1007]= {
				["targetArea"] = 3,
				["delay"] = 0.1,
				["boxType"] = 1,
				["state"]= {
					["stateId"] = 1210203,
					["duration"] = -999,
				},
			},
		},

	},
	[1210230] = {
		["bhEvent"] = "skill.1210230",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
			},
			[5]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["levelAtkEvents"]= {
					[2]= {
					},
					[3]= {
						["state"]= {
							["stateId"] = 1210203,
							["duration"] = 1,
						},
					},
					[4]= {
						["state"]= {
							["stateId"] = 1210203,
							["duration"] = 1,
						},
					},
					[5]= {
						["state"]= {
							["stateId"] = 1210203,
							["duration"] = 1,
						},
					},
					[6]= {
						["state"]= {
							["stateId"] = 1210203,
							["duration"] = 1,
						},
					},
				},

			},
			[0]= {
				["targetChoose"] = 3,
				["boxId"] = 1210229,
				["state"]= {
				},
				["randomTargetNumber"] = 1,
				["recordSkillTargets"] = 1,
				["subEventSkill"] = 1210230,
				["subEventId"] = 1001,
			},
			[4]= {
				["targetChoose"] = 12,
				["state"]= {
					["stateId"] = 1210202,
					["duration"] = 3,
				},
				["subEventSkill"] = 1000121,
				["subEventId"] = 1080,
			},
			[2]= {
				["targetChoose"] = 7,
				["state"]= {
					["stateOperation"] = 1,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {1210202,},
				},
			},
			[1001]= {
				["targetArea"] = 3,
				["state"]= {
					["stateOperation"] = 2,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {0,},
				},
				["eventCondition"] = "1,2,1210202,1",
				["levelAtkEvents"]= {
					[2]= {
					},
					[3]= {
						["state"]= {
							["stateOperation"] = 2,
							["duration"] = 0.25,
							["chooseStateMode"] = 2,
							["chooseStateIds"] = {1210203,},
						},
					},
					[4]= {
						["state"]= {
							["stateOperation"] = 2,
							["duration"] = 0.25,
							["chooseStateMode"] = 2,
							["chooseStateIds"] = {1210203,},
						},
					},
					[5]= {
						["state"]= {
							["stateOperation"] = 2,
							["duration"] = 0.25,
							["chooseStateMode"] = 2,
							["chooseStateIds"] = {1210203,},
						},
					},
					[6]= {
						["state"]= {
							["stateOperation"] = 2,
							["duration"] = 0.25,
							["chooseStateMode"] = 2,
							["chooseStateIds"] = {1210203,},
						},
					},
				},

			},
			[1002]= {
				["targetArea"] = 3,
				["boxId"] = 1210230,
				["state"]= {
				},
				["eventCondition"] = "1,1,1210212",
			},
		},

	},
	[1210259] = {
		["bhEvent"] = "skill.1210259",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {121020011,121020012,},
				},
			},
			[0]= {
				["eventType"] = 1,
				["boxId"] = 1210259,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {121020013,},
				},
				["hitedAnim"] = "Hit",
			},
			[2]= {
				["targetArea"] = 3,
				["state"]= {
					["stateOperation"] = 1,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {1210203,},
				},
			},
			[13]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {121025001,121020015,121021005,},
				},
			},
			[1]= {
				["targetArea"] = 3,
				["targetChoose"] = 4,
				["state"]= {
					["stateId"] = 1210202,
					["duration"] = 3,
				},
				["excludeTarget"] = 1,
				["subEventSkill"] = 1210259,
				["subEventId"] = 1002,
			},
			[90]= {
				["state"]= {
				},
				["hitedAnim"] = "end",
			},
			[3]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1210204,
					["duration"] = 1,
				},
			},
			[1001]= {
				["targetArea"] = 2,
				["targetChoose"] = 23,
				["unitDelay"] = 0.35,
				["flyCueId"] = 121020014,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1210260,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {121021006,},
				},
				["hitCue"]= {
					["cueList"] = {121020013,},
				},
				["subEventSkill"] = 1210259,
				["subEventId"] = 1004,
			},
			[4]= {
				["targetArea"] = 3,
				["state"]= {
					["stateOperation"] = 2,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {0,},
				},
				["levelAtkEvents"]= {
					[2]= {
					},
					[3]= {
						["state"]= {
							["stateOperation"] = 2,
							["duration"] = 0.25,
							["chooseStateMode"] = 2,
							["chooseStateIds"] = {1210204,},
							["layerState"] = 1210203,
						},
					},
					[4]= {
						["state"]= {
							["stateOperation"] = 2,
							["duration"] = 0.25,
							["chooseStateMode"] = 2,
							["chooseStateIds"] = {1210204,},
							["layerState"] = 1210203,
						},
					},
					[5]= {
						["state"]= {
							["stateOperation"] = 2,
							["duration"] = 0.25,
							["chooseStateMode"] = 2,
							["chooseStateIds"] = {1210204,},
							["layerState"] = 1210203,
						},
					},
					[6]= {
						["state"]= {
							["stateOperation"] = 2,
							["duration"] = 0.25,
							["chooseStateMode"] = 2,
							["chooseStateIds"] = {1210204,},
							["layerState"] = 1210203,
						},
					},
				},

			},
			[101]= {
				["targetArea"] = 3,
				["state"]= {
					["stateOperation"] = 1,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {1210204,},
				},
			},
			[1002]= {
				["targetArea"] = 3,
				["targetChoose"] = 16,
				["state"]= {
					["stateOperation"] = 1,
					["stateId"] = 1210202,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {1210202,},
				},
			},
			[1003]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 8791201,
					["duration"] = 6,
				},
				["eventCondition"] = "1,1,8791200",
			},
			[1004]= {
				["targetArea"] = 2,
				["targetChoose"] = 3,
				["unitDelay"] = 0.35,
				["flyCueId"] = 121020014,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1210260,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {121020013,},
				},
				["excludeTarget"] = 1,
				["eventCondition"] = "1,1,8791200",
			},
		},

		["actTime"] = 85,
		["hideEffect"] = 1,
		["videoActTime"] = 105,
		["videoActCue"]= {
			["cueList"] = {121028001,121021004,},
		},
		["hideTime"] = 10,
		["hideEvent"] = 100,
		["prepareCamera"] = 1,
		["prepareCamDruation"] = 30,
	},
	[1210210] = {
		["bhEvent"] = "skill.1210210",
		["atkEvents"]= {
			[100]= {
				["targetArea"] = 3,
				["targetChoose"] = 4,
				["state"]= {
					["stateId"] = 1210202,
					["duration"] = 3,
				},
				["atkCue"]= {
					["cueList"] = {121020003,121021002,},
				},
				["excludeTarget"] = 1,
				["subEventSkill"] = 1210259,
				["subEventId"] = 1002,
				["eventCondition"] = "1,1,1210201",
			},
			[0]= {
				["eventType"] = 1,
				["boxId"] = 1210209,
				["state"]= {
				},
			},
		},

	},
	[1210211] = {
		["bhEvent"] = "skill.1210209",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
			},
			[0]= {
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000008,},
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
