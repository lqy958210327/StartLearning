local Data = {
["cueFile"] = "15202",
	[1520209] = {
		["bhEvent"] = "skill.1520209",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {152020001,152021001,},
				},
			},
			[1]= {
				["unitDelay"] = 0.15,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1520209,
				["state"]= {
				},
			},
			[2]= {
				["targetArea"] = 3,
				["targetChoose"] = 13,
				["state"]= {
				},
				["levelAtkEvents"]= {
					[2]= {
						["boxId"] = 1520210,
					},
					[3]= {
						["boxId"] = 1520210,
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
				["unitDelay"] = 0.15,
				["flyCueId"] = 152020003,
				["boxType"] = 1,
				["state"]= {
				},
			},
			[11]= {
				["unitDelay"] = 0.15,
				["flyCueId"] = 152020003,
				["boxType"] = 1,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {152020005,},
				},
			},
		},

	},
	[1520210] = {
		["bhEvent"] = "skill.1520210",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {152020002,152021002,},
				},
			},
			[1]= {
				["unitDelay"] = 0.15,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1520209,
				["state"]= {
				},
			},
			[2]= {
				["targetArea"] = 3,
				["targetChoose"] = 13,
				["state"]= {
				},
				["levelAtkEvents"]= {
					[2]= {
						["boxId"] = 1520210,
					},
					[3]= {
						["boxId"] = 1520210,
					},
					[4]= {
					},
					[5]= {
					},
					[6]= {
					},
				},

			},
			[11]= {
				["unitDelay"] = 0.15,
				["flyCueId"] = 152020004,
				["boxType"] = 1,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {152020005,},
				},
			},
			[10]= {
				["unitDelay"] = 0.15,
				["flyCueId"] = 152020004,
				["boxType"] = 1,
				["state"]= {
				},
			},
		},

	},
	[1520211] = {
		["bhEvent"] = "skill.1520211",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {152020006,152020007,152020008,152021004,},
				},
			},
			[1]= {
				["unitDelay"] = 0.15,
				["flyCueId"] = 152020009,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1520209,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {152020011,152021005,},
				},
			},
			[3]= {
				["targetChoose"] = 7,
				["unitDelay"] = 0.15,
				["flyCueId"] = 152020010,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1520209,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {152020011,},
				},
				["randomTargetNumber"] = 1,
				["randomRule"] = 1,
			},
			[2]= {
				["targetArea"] = 3,
				["targetChoose"] = 13,
				["state"]= {
				},
				["levelAtkEvents"]= {
					[2]= {
						["boxId"] = 1520210,
					},
					[3]= {
						["boxId"] = 1520210,
					},
					[4]= {
					},
					[5]= {
					},
					[6]= {
					},
				},

			},
			[4]= {
				["targetArea"] = 3,
				["state"]= {
					["stateOperation"] = 1,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {1520211,},
				},
			},
		},

	},
	[1520229] = {
		["bhEvent"] = "skill.1520229",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {152020012,152020013,152020014,152021006,},
				},
			},
			[1]= {
				["targetArea"] = 3,
				["targetChoose"] = 3,
				["state"]= {
					["stateId"] = 1520205,
					["duration"] = 15,
				},
				["levelAtkEvents"]= {
					[2]= {
					},
					[3]= {
						["targetChoose"] = 10,
						["state"]= {
							["stateId"] = 1520205,
							["duration"] = 20,
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
			[1001]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000035,},
				},
				["addManaNumber"] = 30,
			},
			[1002]= {
				["targetArea"] = 3,
				["state"]= {
					["stateOperation"] = 1,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {1520201,},
				},
			},
			[3]= {
				["state"]= {
				},
			},
			[2]= {
				["state"]= {
				},
			},
			[4]= {
				["state"]= {
				},
			},
			[1003]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["addManaNumber"] = 24,
				["levelAtkEvents"]= {
					[2]= {
						["addManaNumber"] = 30,
					},
					[3]= {
						["addManaNumber"] = 30,
					},
					[4]= {
					},
					[5]= {
					},
					[6]= {
					},
				},

			},
			[1004]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["addManaNumber"] = 24,
			},
		},

		["actTime"] = 48,
		["skillTarget"] = 1,
	},
	[1520259] = {
		["bhEvent"] = "skill.1520259",
		["atkEvents"]= {
			[100]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1520202,
					["duration"] = 4,
				},
				["atkCue"]= {
					["cueList"] = {152020016,152020017,152020018,152020019,152020020,152020021,152020022,},
				},
				["eventCondition"] = "1,1,1520201,1",
			},
			[1]= {
				["targetChoose"] = 7,
				["eventType"] = 1,
				["boxId"] = 1520259,
				["state"]= {
					["stateId"] = 1000006,
					["duration"] = 3,
				},
			},
			[2]= {
				["targetArea"] = 3,
				["targetChoose"] = 24,
				["state"]= {
				},
				["randomTargetNumber"] = 1,
				["eventCondition"] = "1,1,1520201,1",
				["rebornMhp"] = 3200,
			},
			[1001]= {
				["targetArea"] = 1,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {152020023,},
				},
				["levelAtkEvents"]= {
					[2]= {
						["boxId"] = 1520260,
					},
					[3]= {
						["boxId"] = 1520260,
					},
					[4]= {
					},
					[5]= {
					},
					[6]= {
					},
				},

			},
			[1002]= {
				["targetArea"] = 3,
				["boxId"] = 1520260,
				["state"]= {
					["stateId"] = 1520205,
					["duration"] = 20,
				},
			},
			[10]= {
				["targetChoose"] = 7,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {152023001,},
				},
				["hitedAnim"] = "Hit",
			},
			[90]= {
				["targetChoose"] = 7,
				["state"]= {
				},
				["hitedAnim"] = "end",
			},
			[13]= {
				["targetChoose"] = 7,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {152025001,152020025,152021008,},
				},
			},
			[1003]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {152020026,},
				},
			},
			[1004]= {
				["targetArea"] = 3,
				["state"]= {
					["stateOperation"] = 1,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {1520201,},
				},
			},
		},

		["actTime"] = 75,
		["hideEffect"] = 1,
		["videoActTime"] = 66,
		["videoActCue"]= {
			["cueList"] = {152028001,152021007,},
		},
		["hideTime"] = 10,
		["hideEvent"] = 13,
		["prepareCamera"] = 1,
		["prepareCamDruation"] = 30,
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
