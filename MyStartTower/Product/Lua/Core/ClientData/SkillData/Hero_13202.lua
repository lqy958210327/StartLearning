local Data = {
["cueFile"] = "13202",
	[1320209] = {
		["bhEvent"] = "skill.1320209",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {132020001,132021001,},
				},
			},
			[1]= {
				["unitDelay"] = 0.15,
				["flyCueId"] = 132020002,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1320209,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {132020003,132021002,},
				},
			},
		},

	},
	[1320229] = {
		["bhEvent"] = "skill.1320229",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {132020004,132021003,},
				},
			},
			[1]= {
				["unitDelay"] = 0.15,
				["flyCueId"] = 132020005,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1320229,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {132020007,132020007,},
				},
				["subEventSkill"] = 1320229,
				["subEventId"] = 1001,
				["levelAtkEvents"]= {
					[2]= {
						["stunTime"] = 0.3,
					},
					[3]= {
						["stunTime"] = 0.3,
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
				["targetChoose"] = 22,
				["unitDelay"] = 0.2,
				["flyCueId"] = 132020006,
				["baseToTarget"] = 1,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1320230,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {132020007,},
				},
				["excludeTarget"] = 1,
				["subEventSkill"] = 1320229,
				["subEventId"] = 1002,
				["levelAtkEvents"]= {
					[2]= {
						["stunTime"] = 0.6,
					},
					[3]= {
						["stunTime"] = 0.6,
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
				["targetChoose"] = 22,
				["unitDelay"] = 0.2,
				["flyCueId"] = 132020006,
				["baseToTarget"] = 1,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1320231,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {132020007,},
				},
				["excludeTarget"] = 1,
				["levelAtkEvents"]= {
					[2]= {
						["stunTime"] = 0.9,
					},
					[3]= {
						["stunTime"] = 0.9,
					},
					[4]= {
					},
					[5]= {
					},
					[6]= {
					},
				},

			},
			[1003]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["addManaNumber"] = 30,
			},
		},

	},
	[1320259] = {
		["bhEvent"] = "skill.1320259",
		["atkEvents"]= {
			[100]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1320203,
					["duration"] = 2,
				},
				["atkCue"]= {
					["cueList"] = {132020008,},
				},
			},
			[10]= {
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {132020009,},
				},
			},
			[11]= {
				["state"]= {
				},
			},
			[1]= {
				["eventType"] = 1,
				["boxId"] = 1320259,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {132020010,},
				},
			},
			[13]= {
				["state"]= {
					["stateId"] = 1320201,
					["duration"] = -999,
				},
				["atkCue"]= {
					["cueList"] = {132020013,132025001,132021005,},
				},
			},
			[1001]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000035,},
				},
				["addManaNumber"] = 100,
			},
			[1002]= {
				["targetChoose"] = 3,
				["unitDelay"] = 0.1,
				["flyCueId"] = 132020006,
				["baseToTarget"] = 1,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1320260,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {132020007,},
				},
				["excludeTarget"] = 1,
			},
			[2]= {
				["targetArea"] = 3,
				["state"]= {
					["stateOperation"] = 1,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {1320202,},
				},
				["eventCondition"] = "1,1,1320204,1",
			},
		},

		["actTime"] = 97,
		["hideEffect"] = 1,
		["videoActTime"] = 70,
		["videoActCue"]= {
			["cueList"] = {132028001,132021006,},
		},
		["prepareCamera"] = 1,
		["prepareCamDruation"] = 35,
		["skillTarget"] = 2,
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
