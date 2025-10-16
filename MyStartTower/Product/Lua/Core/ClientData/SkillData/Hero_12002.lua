local Data = {
["cueFile"] = "12002",
	[1200209] = {
		["bhEvent"] = "skill.1200209",
		["atkEvents"]= {
			[1]= {
				["eventType"] = 1,
				["boxId"] = 1200209,
				["state"]= {
				},
			},
		},

	},
	[1200210] = {
		["bhEvent"] = "skill.1200210",
		["atkEvents"]= {
			[1]= {
				["eventType"] = 1,
				["boxId"] = 1200209,
				["state"]= {
				},
			},
		},

	},
	[1200229] = {
		["bhEvent"] = "skill.1200229",
		["atkEvents"]= {
			[1]= {
				["targetArea"] = 3,
				["summonMonsters"] = "1610101,1610101,1610101",
				["state"]= {
					["stateOperation"] = 1,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {1000012,},
				},
				["levelAtkEvents"]= {
					[2]= {
						["summonMonsters"] = "1610102,1610102,1610102",
					},
					[3]= {
						["summonMonsters"] = "1610103,1610103,1610103",
					},
					[4]= {
						["summonMonsters"] = "1610101,1610101",
					},
					[5]= {
						["summonMonsters"] = "1610101,1610101",
					},
					[6]= {
						["summonMonsters"] = "1610101,1610101",
					},
				},

			},
			[10]= {
				["targetArea"] = 3,
				["state"]= {
				},
			},
			[100]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1000012,
					["duration"] = 2,
				},
				["atkCue"]= {
					["cueList"] = {120020001,},
				},
			},
		},

		["skillTarget"] = 1,
	},
	[1200259] = {
		["bhEvent"] = "skill.1200259",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {120020006,},
				},
			},
			[1001]= {
				["delay"] = 0.1,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1200260,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {120028001,},
				},
				["disablePassive"] = 1,
			},
			[1]= {
				["targetChoose"] = 3,
				["eventType"] = 1,
				["boxId"] = 1200259,
				["state"]= {
				},
				["hitedAnim"] = "Hit",
				["levelAtkEvents"]= {
					[2]= {
					},
					[3]= {
						["state"]= {
							["stateId"] = 1200201,
							["duration"] = 5,
						},
					},
					[4]= {
					},
					[5]= {
					},
					[6]= {
					},
				},

			},
			[10]= {
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {120029001,},
				},
			},
			[11]= {
				["state"]= {
				},
				["hitedAnim"] = "Hit",
			},
			[12]= {
				["targetChoose"] = 3,
				["state"]= {
				},
				["hitedAnim"] = "Hit",
			},
			[2]= {
				["state"]= {
				},
			},
			[13]= {
				["targetChoose"] = 3,
				["state"]= {
				},
				["hitedAnim"] = "end",
			},
			[1002]= {
				["targetArea"] = 3,
				["targetChoose"] = 17,
				["boxId"] = 1200260,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000008,},
				},
			},
			[1003]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1200205,
					["duration"] = 4,
				},
			},
			[1004]= {
				["targetArea"] = 3,
				["summonMonsters"] = "1610101",
				["state"]= {
				},
			},
			[1005]= {
				["targetArea"] = 3,
				["summonMonsters"] = "1610102",
				["state"]= {
				},
			},
			[1006]= {
				["targetArea"] = 3,
				["summonMonsters"] = "1610103",
				["state"]= {
				},
			},
			[26]= {
				["targetChoose"] = 3,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {120020007,},
				},
			},
		},

		["actTime"] = 85,
		["hideEffect"] = 1,
		["videoActTime"] = 32,
		["shortVideoActTime"] = 2,
		["videoActCue"]= {
			["cueList"] = {120028001,120029002,120021001,},
		},
		["shortVideoActCue"]= {
			["cueList"] = {120028002,120021004,},
		},
	},
	[1200222] = {
		["bhEvent"] = "skill.1200222",
		["atkEvents"]= {
			[1]= {
				["targetChoose"] = 3,
				["unitDelay"] = 0.25,
				["flyCueId"] = 120020004,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1200222,
				["state"]= {
				},
				["baseCue"]= {
					["cueList"] = {120020005,120021002,120021003,},
				},
			},
			[2]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["levelAtkEvents"]= {
					[2]= {
						["addManaNumber"] = 10,
					},
					[3]= {
						["addManaNumber"] = 10,
					},
					[4]= {
						["addManaNumber"] = 10,
					},
					[5]= {
					},
					[6]= {
					},
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
