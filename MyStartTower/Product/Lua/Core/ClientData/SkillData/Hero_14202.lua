local Data = {
["cueFile"] = "14202",
	[1420209] = {
		["bhEvent"] = "skill.1420209",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {142020011,142021001,},
				},
			},
			[1]= {
				["unitDelay"] = 0.2,
				["flyCueId"] = 142020012,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1420209,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {142020014,142021002,},
				},
			},
			[1001]= {
				["delay"] = 0.15,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1420210,
				["state"]= {
				},
				["disablePassive"] = 1,
			},
		},

	},
	[1420210] = {
		["bhEvent"] = "skill.1420210",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {142020013,142021003,},
				},
			},
			[1]= {
				["unitDelay"] = 0.2,
				["flyCueId"] = 142020016,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1420209,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {142020014,142021002,},
				},
			},
		},

	},
	[1420229] = {
		["bhEvent"] = "skill.1420229",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {142020006,142021004,},
				},
				["hitCue"]= {
					["cueList"] = {142020007,},
				},
			},
			[1]= {
				["state"]= {
					["stateId"] = 1420202,
					["duration"] = -999,
				},
				["stunTime"] = 4,
			},
			[1001]= {
				["targetChoose"] = 3,
				["eventType"] = 1,
				["boxId"] = 1420230,
				["state"]= {
					["stateId"] = 1000013,
					["duration"] = 3,
				},
				["baseCue"]= {
					["cueList"] = {142020008,},
				},
				["excludeTarget"] = 1,
			},
			[1002]= {
				["targetChoose"] = 3,
				["eventType"] = 1,
				["boxId"] = 1420229,
				["state"]= {
				},
				["baseCue"]= {
					["cueList"] = {142020009,},
				},
				["excludeTarget"] = 1,
			},
			[1003]= {
				["boxId"] = 1420231,
				["state"]= {
				},
				["disablePassive"] = 1,
			},
			[1004]= {
				["targetChoose"] = 23,
				["state"]= {
					["stateId"] = 1420202,
					["duration"] = -999,
				},
			},
			[1005]= {
				["targetChoose"] = 7,
				["state"]= {
					["stateId"] = 8791071,
					["duration"] = -999,
				},
			},
			[1006]= {
				["targetChoose"] = 3,
				["eventType"] = 1,
				["boxId"] = 1420232,
				["state"]= {
				},
				["baseCue"]= {
					["cueList"] = {142020008,},
				},
			},
		},

		["actTime"] = 60,
	},
	[1420259] = {
		["bhEvent"] = "skill.1420259",
		["atkEvents"]= {
			[100]= {
				["targetChoose"] = 3,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {142020015,},
				},
			},
			[12]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {142020017,142025001,142021006,},
				},
			},
			[14]= {
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {142020002,},
				},
			},
			[60]= {
				["targetChoose"] = 3,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {142020003,},
				},
			},
			[1]= {
				["targetChoose"] = 3,
				["eventType"] = 1,
				["boxId"] = 1420259,
				["state"]= {
					["stateId"] = 1000013,
					["duration"] = 5,
				},
				["recordSkillTargets"] = 1,
				["levelAtkEvents"]= {
					[2]= {
					},
					[3]= {
						["state"]= {
							["stateId"] = 1000013,
							["duration"] = 8,
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
				["eventType"] = 1,
				["state"]= {
				},
			},
			[1002]= {
				["state"]= {
					["stateOperation"] = 2,
					["duration"] = 3,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {1000013,},
				},
			},
			[2]= {
				["targetChoose"] = 12,
				["state"]= {
				},
				["levelAtkEvents"]= {
					[2]= {
						["state"]= {
							["stateId"] = 1420201,
							["duration"] = 5,
						},
					},
					[3]= {
						["state"]= {
							["stateId"] = 1420201,
							["duration"] = 8,
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
		},

		["actTime"] = 95,
		["hideEffect"] = 1,
		["videoActTime"] = 40,
		["videoActCue"]= {
			["cueList"] = {142028001,142021005,},
		},
		["hideTime"] = 10,
		["hideEvent"] = 100,
		["prepareCamera"] = 1,
		["prepareCamDruation"] = 30,
	},
	[1420230] = {
		["bhEvent"] = "skill.1420230",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {142020006,142021004,},
				},
				["hitCue"]= {
					["cueList"] = {142020007,},
				},
			},
			[1]= {
				["state"]= {
					["stateId"] = 1420202,
					["duration"] = -999,
				},
				["hitCue"]= {
					["cueList"] = {142020010,},
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
