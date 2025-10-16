local Data = {
["cueFile"] = "15002",
	[1500209] = {
		["bhEvent"] = "skill.1500209",
		["atkEvents"]= {
			[0]= {
				["eventType"] = 1,
				["boxId"] = 1500209,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {150020001,150021003,},
				},
			},
			[100]= {
				["eventType"] = 1,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {150020008,},
				},
			},
		},

	},
	[1500210] = {
		["bhEvent"] = "skill.1500210",
		["atkEvents"]= {
			[0]= {
				["eventType"] = 1,
				["boxId"] = 1500209,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {150020001,150021003,},
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {150020007,},
				},
			},
		},

	},
	[1500259] = {
		["bhEvent"] = "skill.1500259",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {150020005,150020006,},
				},
			},
			[0]= {
				["targetArea"] = 3,
				["targetChoose"] = 7,
				["boxId"] = 1500259,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {150020003,150021002,},
				},
			},
			[1]= {
				["targetArea"] = 3,
				["targetChoose"] = 7,
				["state"]= {
					["stateId"] = 1500202,
					["duration"] = 10,
				},
			},
			[10]= {
				["state"]= {
				},
			},
			[11]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {150025001,150020004,},
				},
			},
			[2]= {
				["targetArea"] = 3,
				["targetChoose"] = 16,
				["state"]= {
				},
				["levelAtkEvents"]= {
					[2]= {
						["boxId"] = 1500260,
						["hitCue"]= {
							["cueList"] = {150020003,},
						},
					},
					[3]= {
						["boxId"] = 1500260,
						["hitCue"]= {
							["cueList"] = {150020003,},
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
			[3]= {
				["targetArea"] = 3,
				["targetChoose"] = 16,
				["state"]= {
				},
				["levelAtkEvents"]= {
					[2]= {
						["state"]= {
							["stateId"] = 1500201,
							["duration"] = 10,
						},
					},
					[3]= {
						["state"]= {
							["stateId"] = 1500201,
							["duration"] = 10,
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
			[13]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {150020004,150025001,},
				},
			},
		},

		["actTime"] = 60,
		["hideEffect"] = 1,
		["videoActTime"] = 50,
		["videoActCue"]= {
			["cueList"] = {150021005,150028002,},
		},
		["hideTime"] = 10,
		["prepareCamera"] = 1,
		["prepareCamDruation"] = 30,
	},
	[1500229] = {
		["bhEvent"] = "skill.1500229",
		["atkEvents"]= {
			[100]= {
				["targetArea"] = 3,
				["targetChoose"] = 3,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {150020009,},
				},
				["excludeTarget"] = 1,
				["recordSkillTargets"] = 1,
				["levelAtkEvents"]= {
					[2]= {
					},
					[3]= {
						["targetChoose"] = 7,
					},
					[4]= {
						["targetChoose"] = 4,
					},
					[5]= {
						["targetChoose"] = 4,
					},
					[6]= {
						["targetChoose"] = 4,
					},
				},

			},
			[1]= {
				["targetArea"] = 3,
				["targetChoose"] = 12,
				["state"]= {
					["stateId"] = 1500203,
					["duration"] = -999,
				},
				["hitCue"]= {
					["cueList"] = {150020002,150021004,},
				},
				["levelAtkEvents"]= {
					[2]= {
					},
					[3]= {
						["boxId"] = 1500229,
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
				["addManaNumber"] = 25,
			},
			[1002]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["addManaNumber"] = 5,
			},
			[1003]= {
				["targetArea"] = 1,
				["delay"] = 0.3,
				["boxType"] = 1,
				["boxId"] = 1500230,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000025,},
				},
			},
		},

		["actTime"] = 45,
		["skillTarget"] = 1,
	},
	[1500260] = {
		["bhEvent"] = "skill.1500260",
		["atkEvents"]= {
			[10]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 9900006,
					["duration"] = 90,
				},
			},
			[11]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {150029002,},
				},
			},
			[0]= {
				["targetArea"] = 3,
				["targetChoose"] = 7,
				["boxId"] = 1500259,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {150021002,},
				},
				["hitCue"]= {
					["cueList"] = {150020003,},
				},
			},
			[2]= {
				["targetArea"] = 3,
				["state"]= {
				},
			},
		},

		["actTime"] = 60,
		["videoActTime"] = 140,
		["shortVideoActTime"] = 60,
		["videoActCue"]= {
			["cueList"] = {150028001,150021001,},
		},
		["shortVideoActCue"]= {
			["cueList"] = {150028002,150021005,},
		},
		["hideTime"] = 10,
		["prepareCamera"] = 1,
		["prepareCamDruation"] = 30,
		["skillTarget"] = 1,
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
