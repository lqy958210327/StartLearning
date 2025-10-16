local Data = {
["cueFile"] = "15009",
	[1500909] = {
		["bhEvent"] = "skill.1500909",
		["atkEvents"]= {
			[0]= {
				["unitDelay"] = 0.16,
				["flyCueId"] = 150090002,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1500909,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000063,150091002,},
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {150090001,150091001,},
				},
			},
		},

	},
	[1500910] = {
		["bhEvent"] = "skill.1500909",
		["atkEvents"]= {
			[0]= {
				["unitDelay"] = 0.08,
				["flyCueId"] = 90010003,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1500909,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {150090001,},
				},
			},
			[10]= {
				["state"]= {
				},
			},
			[100]= {
				["state"]= {
				},
			},
		},

	},
	[1500959] = {
		["bhEvent"] = "skill.1500959",
		["atkEvents"]= {
			[10]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {150090001,150090001,},
				},
			},
			[2]= {
				["targetArea"] = 3,
				["targetChoose"] = 7,
				["state"]= {
					["stateId"] = 1500901,
					["duration"] = 10,
				},
				["atkCue"]= {
					["cueList"] = {150090006,},
				},
				["hitCue"]= {
					["cueList"] = {150090008,},
				},
				["levelAtkEvents"]= {
					[2]= {
					},
					[3]= {
						["state"]= {
							["stateId"] = 1500901,
							["duration"] = 15,
						},
					},
					[4]= {
						["state"]= {
							["stateId"] = 1500901,
							["duration"] = 15,
						},
					},
					[5]= {
					},
					[6]= {
					},
				},

			},
			[1]= {
				["state"]= {
				},
			},
			[1001]= {
				["targetArea"] = 1,
				["boxId"] = 1500959,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000008,},
				},
			},
			[0]= {
				["state"]= {
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {150090007,150091005,},
				},
			},
		},

		["actTime"] = 50,
	},
	[1500921] = {
		["bhEvent"] = "skill.1500921",
		["atkEvents"]= {
			[2]= {
				["targetArea"] = 3,
				["targetChoose"] = 12,
				["state"]= {
					["stateId"] = 1500902,
					["duration"] = -999,
				},
				["hitCue"]= {
					["cueList"] = {150090005,150091004,},
				},
			},
			[100]= {
				["targetArea"] = 3,
				["targetChoose"] = 4,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {150090004,150091003,},
				},
				["excludeTarget"] = 1,
				["recordSkillTargets"] = 1,
				["levelAtkEvents"]= {
					[2]= {
						["targetChoose"] = 3,
					},
					[3]= {
						["targetChoose"] = 7,
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

		["actTime"] = 40,
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
