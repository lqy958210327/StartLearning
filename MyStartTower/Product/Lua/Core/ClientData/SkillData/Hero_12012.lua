local Data = {
["cueFile"] = "12012",
	[1201209] = {
		["bhEvent"] = "skill.1201209",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {120120001,120121001,},
				},
			},
			[1]= {
				["eventType"] = 1,
				["boxId"] = 1201209,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {120120004,},
				},
			},
		},

	},
	[1201210] = {
		["bhEvent"] = "skill.1201210",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {120120002,120121002,},
				},
			},
			[1]= {
				["eventType"] = 1,
				["boxId"] = 1201209,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {120120004,},
				},
			},
		},

	},
	[1201211] = {
		["bhEvent"] = "skill.1201211",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {120120003,120121003,},
				},
			},
			[1]= {
				["eventType"] = 1,
				["boxId"] = 1201209,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {120120004,},
				},
			},
		},

	},
	[1201229] = {
		["bhEvent"] = "skill.1201229",
		["atkEvents"]= {
			[100]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1201203,
					["duration"] = 3,
				},
				["atkCue"]= {
					["cueList"] = {120120005,120121004,},
				},
			},
			[1]= {
				["eventType"] = 1,
				["boxId"] = 1201229,
				["state"]= {
				},
			},
			[2]= {
				["eventType"] = 1,
				["boxId"] = 1201229,
				["state"]= {
				},
			},
			[1001]= {
				["targetArea"] = 3,
				["state"]= {
					["stateOperation"] = 1,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {1201212,},
				},
			},
		},

	},
	[1201230] = {
		["bhEvent"] = "skill.1201230",
		["atkEvents"]= {
			[100]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1201203,
					["duration"] = 3,
				},
				["atkCue"]= {
					["cueList"] = {120120006,120121005,},
				},
			},
			[1]= {
				["eventType"] = 1,
				["boxId"] = 1201230,
				["state"]= {
				},
			},
			[2]= {
				["eventType"] = 1,
				["boxId"] = 1201230,
				["state"]= {
				},
			},
			[3]= {
				["eventType"] = 1,
				["boxId"] = 1201230,
				["state"]= {
				},
			},
		},

	},
	[1201259] = {
		["bhEvent"] = "skill.1201259",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {120120007,},
				},
			},
			[13]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {120120012,120125001,120121008,},
				},
			},
			[11]= {
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {120120010,},
				},
			},
			[12]= {
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {120120009,},
				},
			},
			[27]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {120123001,},
				},
				["hitedAnim"] = "Hit",
			},
			[99]= {
				["state"]= {
				},
				["hitedAnim"] = "end",
			},
			[1]= {
				["eventType"] = 1,
				["boxId"] = 1201259,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {120123003,},
				},
			},
			[1001]= {
				["eventType"] = 1,
				["boxId"] = 1201260,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {120120011,},
				},
			},
			[28]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {120123002,},
				},
				["hitedAnim"] = "Hit",
			},
			[14]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {120121007,},
				},
			},
			[1002]= {
				["targetArea"] = 3,
				["state"]= {
					["stateOperation"] = 1,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {1201202,1201205,},
				},
			},
			[1003]= {
				["eventType"] = 1,
				["boxId"] = 1201261,
				["state"]= {
				},
				["disablePassive"] = 1,
			},
			[1004]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1201205,
					["duration"] = -999,
				},
			},
			[2]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1201201,
					["duration"] = 5,
				},
			},
			[3]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["levelAtkEvents"]= {
					[2]= {
					},
					[3]= {
						["state"]= {
							["stateId"] = 1201204,
							["duration"] = -999,
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

		["actTime"] = 96,
		["hideEffect"] = 1,
		["videoActTime"] = 64,
		["videoActCue"]= {
			["cueList"] = {120128001,120121006,},
		},
		["hideTime"] = 10,
		["hideEvent"] = 1,
		["prepareCamera"] = 1,
		["prepareCamDruation"] = 55,
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
