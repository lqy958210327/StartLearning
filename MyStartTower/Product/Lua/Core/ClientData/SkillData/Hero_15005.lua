local Data = {
["cueFile"] = "15005",
	[1500509] = {
		["bhEvent"] = "skill.1500509",
		["atkEvents"]= {
			[0]= {
				["unitDelay"] = 0.08,
				["flyCueId"] = 90010003,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1500509,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {90010008,},
				},
			},
		},

	},
	[1500510] = {
		["bhEvent"] = "skill.1500510",
		["atkEvents"]= {
			[0]= {
				["unitDelay"] = 0.08,
				["flyCueId"] = 90010003,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1500509,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {90010008,},
				},
			},
		},

	},
	[1500559] = {
		["bhEvent"] = "skill.1500559",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {150050001,},
				},
			},
			[0]= {
				["targetArea"] = 3,
				["targetChoose"] = 4,
				["boxId"] = 1500559,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {150050001,},
				},
				["addManaNumber"] = 20,
				["randomTargetNumber"] = 1,
				["randomRule"] = 1,
			},
		},

		["actTime"] = 70,
	},
	[1500501] = {
		["bhEvent"] = "skill.1500501",
		["atkEvents"]= {
			[1]= {
				["unitDelay"] = 0.1,
				["flyCueId"] = 150050002,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1500509,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {150050001,150051001,},
				},
			},
		},

	},
	[1500551] = {
		["bhEvent"] = "skill.1500551",
		["atkEvents"]= {
			[1]= {
				["targetArea"] = 3,
				["targetChoose"] = 4,
				["boxId"] = 1500559,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000008,150050003,},
				},
				["addManaNumber"] = 20,
				["randomTargetNumber"] = 1,
				["randomRule"] = 1,
				["levelAtkEvents"]= {
					[2]= {
					},
					[3]= {
						["addManaNumber"] = 30,
					},
					[4]= {
						["addManaNumber"] = 30,
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
				["atkCue"]= {
					["cueList"] = {150051004,},
				},
			},
		},

		["actTime"] = 40,
	},
	[1500521] = {
		["bhEvent"] = "skill.1500521",
		["atkEvents"]= {
			[1]= {
				["targetArea"] = 3,
				["targetChoose"] = 12,
				["state"]= {
					["stateId"] = 1500506,
					["duration"] = -999,
				},
				["hitCue"]= {
					["cueList"] = {150050004,},
				},
			},
			[100]= {
				["targetArea"] = 3,
				["targetChoose"] = 4,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {150051003,},
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

		["actTime"] = 50,
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
