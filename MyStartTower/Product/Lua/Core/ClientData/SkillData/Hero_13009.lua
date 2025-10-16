local Data = {
["cueFile"] = "13009",
	[1300901] = {
		["bhEvent"] = "skill.1300901",
		["atkEvents"]= {
			[0]= {
				["unitDelay"] = 0.15,
				["flyCueId"] = 130090002,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1300901,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {130090003,130091002,},
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {130090001,130091001,},
				},
			},
		},

	},
	[1300902] = {
		["bhEvent"] = "skill.1300901",
		["atkEvents"]= {
			[0]= {
				["unitDelay"] = 0.08,
				["flyCueId"] = 90010002,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1300901,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {130090001,130090001,},
				},
			},
			[100]= {
				["state"]= {
				},
			},
		},

	},
	[1300951] = {
		["bhEvent"] = "skill.1300951",
		["atkEvents"]= {
			[1]= {
				["targetChoose"] = 7,
				["unitDelay"] = 0.12,
				["flyCueId"] = 130090008,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1300951,
				["state"]= {
					["stateId"] = 1300901,
					["duration"] = 5,
				},
				["hitCue"]= {
					["cueList"] = {130090009,130091006,10006003,},
				},
				["randomTargetNumber"] = 4,
				["levelAtkEvents"]= {
					[2]= {
						["randomTargetNumber"] = 5,
					},
					[3]= {
						["randomTargetNumber"] = 5,
					},
					[4]= {
						["randomTargetNumber"] = 5,
					},
					[5]= {
						["state"]= {
						},
						["randomTargetNumber"] = 3,
					},
					[6]= {
						["state"]= {
						},
						["randomTargetNumber"] = 3,
					},
				},

			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {130090006,130090007,130091005,},
				},
			},
		},

		["actTime"] = 60,
	},
	[1300921] = {
		["bhEvent"] = "skill.1300921",
		["atkEvents"]= {
			[0]= {
				["targetArea"] = 2,
				["targetChoose"] = 7,
				["eventType"] = 1,
				["boxId"] = 1300921,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {130090005,130091004,},
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {130090004,130091003,},
				},
			},
		},

	},
	[1300922] = {
		["bhEvent"] = "skill.1300922",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {130090004,130091003,},
				},
			},
			[0]= {
				["targetArea"] = 2,
				["targetChoose"] = 7,
				["eventType"] = 1,
				["boxId"] = 1300921,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {130090005,130091004,},
				},
			},
		},

		["actTime"] = 60,
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
