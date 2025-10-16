local Data = {
["cueFile"] = "13008",
	[1300801] = {
		["bhEvent"] = "skill.1300801",
		["atkEvents"]= {
			[1]= {
				["unitDelay"] = 0.12,
				["flyCueId"] = 130080026,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1300801,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {130080027,130081004,},
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {130080025,130081003,},
				},
			},
		},

	},
	[1300851] = {
		["bhEvent"] = "skill.1300851",
		["atkEvents"]= {
			[1]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1300801,
					["duration"] = 8,
				},
				["levelAtkEvents"]= {
					[2]= {
					},
					[3]= {
						["state"]= {
							["stateId"] = 1300801,
							["duration"] = 12,
						},
					},
					[4]= {
						["state"]= {
							["stateId"] = 1300801,
							["duration"] = 15,
						},
					},
					[5]= {
						["state"]= {
							["stateId"] = 1300801,
							["duration"] = 10,
						},
					},
					[6]= {
						["state"]= {
							["stateId"] = 1300801,
							["duration"] = 10,
						},
					},
				},

			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {130080033,130081007,},
				},
			},
			[2]= {
				["targetArea"] = 3,
				["state"]= {
				},
			},
			[1001]= {
				["delay"] = 0.2,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1300851,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000042,},
				},
				["disablePassive"] = 1,
			},
		},

		["actTime"] = 75,
	},
	[1300802] = {
		["bhEvent"] = "skill.1300802",
		["atkEvents"]= {
			[1]= {
				["unitDelay"] = 0.1,
				["flyCueId"] = 130080030,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1300802,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {130080031,130081006,},
				},
			},
			[2]= {
				["targetArea"] = 3,
				["state"]= {
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {130080028,130080029,130081005,},
				},
			},
		},

	},
	[1300821] = {
		["bhEvent"] = "skill.1300821",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
			},
			[1001]= {
				["delay"] = 0.2,
				["eventType"] = 1,
				["boxId"] = 1300821,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {130080032,},
				},
				["disablePassive"] = 1,
				["levelAtkEvents"]= {
					[2]= {
						["controlTime"] = 3,
						["controlAniName"] = "freeze",
					},
					[3]= {
						["controlTime"] = 3,
						["controlAniName"] = "freeze",
					},
					[4]= {
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
			[2]= {
				["state"]= {
				},
			},
		},

	},
	[1300803] = {
		["bhEvent"] = "skill.1300803",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {130080028,130080029,130081005,},
				},
			},
			[2]= {
				["state"]= {
				},
			},
			[1]= {
				["unitDelay"] = 0.05,
				["flyCueId"] = 130080035,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1300802,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {130080031,130081006,},
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
