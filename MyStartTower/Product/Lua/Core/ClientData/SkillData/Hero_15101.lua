local Data = {
["cueFile"] = "15101",
	[1510109] = {
		["bhEvent"] = "skill.1510109",
		["atkEvents"]= {
			[0]= {
				["unitDelay"] = 0.12,
				["flyCueId"] = 151010004,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1510109,
				["state"]= {
					["chooseStateType"] = 1,
					["chooseStateMode"] = 2,
				},
				["hitCue"]= {
					["cueList"] = {151010005,151011001,},
				},
			},
			[15]= {
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {151010008,},
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {151010001,},
				},
			},
		},

	},
	[1510110] = {
		["bhEvent"] = "skill.1510110",
		["atkEvents"]= {
			[0]= {
				["unitDelay"] = 0.12,
				["flyCueId"] = 151010003,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1510109,
				["state"]= {
					["chooseStateMode"] = 2,
				},
				["hitCue"]= {
					["cueList"] = {151010005,151011002,},
				},
			},
			[15]= {
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {151010008,},
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {151010002,},
				},
			},
		},

	},
	[1510159] = {
		["bhEvent"] = "skill.1510159",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
			},
			[0]= {
				["targetArea"] = 3,
				["targetChoose"] = 12,
				["boxId"] = 1510159,
				["state"]= {
					["stateId"] = 1510103,
					["duration"] = 5,
				},
				["hitCue"]= {
					["cueList"] = {151010007,151011004,},
				},
				["levelAtkEvents"]= {
					[2]= {
					},
					[3]= {
						["state"]= {
							["stateId"] = 1510102,
							["duration"] = 2,
						},
					},
					[4]= {
						["state"]= {
						},
					},
					[5]= {
						["state"]= {
						},
					},
					[6]= {
						["state"]= {
						},
					},
				},

			},
			[1]= {
				["targetArea"] = 3,
				["targetChoose"] = 18,
				["state"]= {
					["stateId"] = 1510104,
					["duration"] = 2,
				},
				["recordSkillTargets"] = 1,
			},
			[1001]= {
				["targetArea"] = 1,
				["boxId"] = 1510160,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000047,},
				},
			},
			[1002]= {
				["targetArea"] = 3,
				["boxId"] = 1510161,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {151010007,},
				},
			},
			[2]= {
				["state"]= {
				},
				["levelAtkEvents"]= {
					[2]= {
						["state"]= {
							["stateId"] = 1510105,
							["duration"] = 0.2,
						},
					},
					[3]= {
						["state"]= {
							["stateId"] = 1510105,
							["duration"] = 0.2,
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

		["actTime"] = 65,
		["skillTarget"] = 1,
	},
	[1510129] = {
		["bhEvent"] = "skill.1510129",
		["atkEvents"]= {
			[100]= {
				["targetArea"] = 3,
				["targetChoose"] = 3,
				["state"]= {
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
					["stateId"] = 1510101,
					["duration"] = -999,
				},
				["hitCue"]= {
					["cueList"] = {151010006,151011003,},
				},
				["addManaNumber"] = 20,
				["levelAtkEvents"]= {
					[2]= {
					},
					[3]= {
					},
					[4]= {
						["state"]= {
						},
					},
					[5]= {
						["state"]= {
						},
					},
					[6]= {
						["state"]= {
						},
					},
				},

			},
			[2]= {
				["targetArea"] = 3,
				["targetChoose"] = 4,
				["state"]= {
				},
				["excludeTarget"] = 1,
				["levelAtkEvents"]= {
					[2]= {
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
		},

		["actTime"] = 35,
		["skillTarget"] = 1,
	},
	[1510160] = {
		["bhEvent"] = "skill.1510160",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
			},
			[0]= {
				["targetArea"] = 3,
				["targetChoose"] = 7,
				["boxId"] = 1510159,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {151010007,151011004,},
				},
			},
			[1]= {
				["state"]= {
				},
			},
			[2]= {
				["state"]= {
				},
			},
		},

		["actTime"] = 65,
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
