local Data = {
["cueFile"] = "14002",
	[1400209] = {
		["bhEvent"] = "skill.1400209",
		["atkEvents"]= {
			[0]= {
				["unitDelay"] = 0.12,
				["flyCueId"] = 140020003,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1400209,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000062,140021002,},
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {140020001,140021001,},
				},
			},
			[10]= {
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {140020002,},
				},
			},
		},

	},
	[1400210] = {
		["bhEvent"] = "skill.1400210",
		["atkEvents"]= {
			[0]= {
				["unitDelay"] = 0.08,
				["flyCueId"] = 140020003,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1400209,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {140020001,},
				},
			},
			[100]= {
				["state"]= {
				},
			},
			[10]= {
				["state"]= {
				},
			},
		},

	},
	[1400259] = {
		["bhEvent"] = "skill.1400259",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {140020007,},
				},
			},
			[0]= {
				["targetArea"] = 3,
				["summonMonsters"] = "1620101,1620201",
				["state"]= {
				},
				["levelAtkEvents"]= {
					[2]= {
						["summonMonsters"] = "1620102,1620202",
					},
					[3]= {
						["summonMonsters"] = "1620103,1620203",
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
				["addManaNumber"] = 15,
			},
			[41]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {140020008,140021006,},
				},
			},
			[13]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {140020009,140021005,},
				},
			},
		},

		["actTime"] = 60,
		["videoActTime"] = 72,
		["videoActCue"]= {
			["cueList"] = {140028001,140021004,},
		},
		["prepareCamera"] = 1,
		["prepareCamDruation"] = 25,
	},
	[1400229] = {
		["bhEvent"] = "skill.1400229",
		["atkEvents"]= {
			[0]= {
				["unitDelay"] = 0.16,
				["flyCueId"] = 140020005,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1400229,
				["state"]= {
					["stateId"] = 1000002,
					["duration"] = 6,
				},
				["hitCue"]= {
					["cueList"] = {140020006,},
				},
			},
			[100]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {140020004,140021003,},
				},
			},
			[1]= {
				["targetArea"] = 3,
				["targetChoose"] = 10,
				["state"]= {
				},
				["eventCondition"] = "4,2,race,1",
				["levelAtkEvents"]= {
					[2]= {
						["addManaNumber"] = 10,
					},
					[3]= {
						["addManaNumber"] = 10,
					},
					[4]= {
					},
					[5]= {
					},
					[6]= {
					},
				},

			},
			[2]= {
				["targetArea"] = 3,
				["targetChoose"] = 17,
				["state"]= {
				},
				["levelAtkEvents"]= {
					[2]= {
					},
					[3]= {
						["targetChoose"] = 16,
						["addManaNumber"] = 10,
						["eventCondition"] = "4,2,race,1",
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
				["boxId"] = 1400230,
				["state"]= {
				},
			},
			[1002]= {
				["targetArea"] = 3,
				["targetChoose"] = 17,
				["boxId"] = 1400230,
				["state"]= {
				},
			},
			[1003]= {
				["targetChoose"] = 4,
				["delay"] = 1.8,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1400231,
				["state"]= {
					["stateId"] = 1000002,
					["duration"] = 6,
				},
				["hitCue"]= {
					["cueList"] = {140020006,},
				},
				["randomTargetNumber"] = 1,
				["randomRule"] = 1,
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
