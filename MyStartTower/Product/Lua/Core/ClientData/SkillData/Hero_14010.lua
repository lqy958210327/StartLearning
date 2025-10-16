local Data = {
["cueFile"] = "14010",
	[1401009] = {
		["bhEvent"] = "skill.1401009",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {140100001,},
				},
			},
			[0]= {
				["unitDelay"] = 0.16,
				["flyCueId"] = 140100002,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1401001,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {140100003,},
				},
			},
			[1]= {
				["state"]= {
				},
			},
		},

	},
	[1401059] = {
		["bhEvent"] = "skill.1401059",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {140100004,},
				},
			},
			[0]= {
				["unitDelay"] = 0.12,
				["flyCueId"] = 140100005,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1401051,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {140100006,},
				},
				["subEventSkill"] = 1401059,
				["subEventId"] = 1001,
				["levelAtkEvents"]= {
					[2]= {
						["state"]= {
							["stateId"] = 1401001,
							["duration"] = 6,
						},
					},
					[3]= {
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
				["targetChoose"] = 3,
				["unitDelay"] = 0.24,
				["flyCueId"] = 140100007,
				["baseToTarget"] = 1,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1401051,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {140100008,},
				},
				["randomTargetNumber"] = 1,
				["excludeTarget"] = 1,
				["subEventSkill"] = 1401059,
				["subEventId"] = 1002,
				["levelAtkEvents"]= {
					[2]= {
						["state"]= {
							["stateId"] = 1401001,
							["duration"] = 6,
						},
					},
					[3]= {
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
				["targetChoose"] = 3,
				["unitDelay"] = 0.24,
				["flyCueId"] = 140100007,
				["baseToTarget"] = 1,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1401051,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {140100008,},
				},
				["randomTargetNumber"] = 1,
				["excludeTarget"] = 1,
				["subEventSkill"] = 1401059,
				["subEventId"] = 1003,
				["levelAtkEvents"]= {
					[2]= {
						["state"]= {
							["stateId"] = 1401001,
							["duration"] = 6,
						},
					},
					[3]= {
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
				["targetChoose"] = 3,
				["unitDelay"] = 0.24,
				["flyCueId"] = 140100007,
				["baseToTarget"] = 1,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1401051,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {140100008,},
				},
				["randomTargetNumber"] = 1,
				["excludeTarget"] = 1,
				["levelAtkEvents"]= {
					[2]= {
						["state"]= {
							["stateId"] = 1401001,
							["duration"] = 6,
						},
					},
					[3]= {
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

		["actTime"] = 81,
	},
	[1401029] = {
		["bhEvent"] = "skill.1401029",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {140100009,},
				},
			},
			[1]= {
				["targetArea"] = 3,
				["targetChoose"] = 10,
				["boxId"] = 1401021,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000025,140100011,},
				},
			},
			[1001]= {
				["targetArea"] = 1,
				["delay"] = 0.5,
				["boxType"] = 1,
				["boxId"] = 1401021,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000025,},
				},
				["levelAtkEvents"]= {
					[2]= {
						["state"]= {
							["stateId"] = 1401002,
							["duration"] = -999,
						},
					},
					[3]= {
						["state"]= {
							["stateId"] = 1401002,
							["duration"] = -999,
						},
					},
					[4]= {
						["delay"] = 0.2,
					},
					[5]= {
						["delay"] = 0.2,
					},
					[6]= {
						["delay"] = 0.2,
					},
				},

			},
			[1002]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["addManaNumber"] = 6,
			},
			[0]= {
				["state"]= {
				},
			},
		},

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
