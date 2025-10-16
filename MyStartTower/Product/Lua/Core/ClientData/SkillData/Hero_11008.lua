local Data = {
["cueFile"] = "11008",
	[1100801] = {
		["bhEvent"] = "skill.1100801",
		["atkEvents"]= {
			[1001]= {
				["targetArea"] = 3,
				["targetChoose"] = 10,
				["state"]= {
					["stateId"] = 1100801,
					["duration"] = 10,
				},
				["hitCue"]= {
					["cueList"] = {110080001,},
				},
			},
			[1]= {
				["eventType"] = 1,
				["boxId"] = 1100801,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {110080006,},
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {110080004,},
				},
			},
			[99]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {110081001,},
				},
			},
		},

	},
	[1100851] = {
		["bhEvent"] = "skill.1100851",
		["atkEvents"]= {
			[1]= {
				["targetArea"] = 3,
				["boxId"] = 1100852,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000025,},
				},
				["levelAtkEvents"]= {
					[2]= {
					},
					[3]= {
						["state"]= {
							["stateId"] = 1100802,
							["duration"] = 10,
						},
					},
					[4]= {
						["state"]= {
							["stateId"] = 1100802,
							["duration"] = 10,
						},
					},
					[5]= {
					},
					[6]= {
					},
				},

			},
			[100]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {110080009,110080010,110081004,},
				},
			},
			[2]= {
				["eventType"] = 1,
				["boxId"] = 1100851,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {110080011,10006003,},
				},
			},
			[3]= {
				["targetArea"] = 3,
				["targetChoose"] = 4,
				["state"]= {
				},
				["excludeTarget"] = 1,
				["levelAtkEvents"]= {
					[2]= {
						["boxId"] = 1100853,
						["hitCue"]= {
							["cueList"] = {10000025,},
						},
					},
					[3]= {
						["boxId"] = 1100853,
						["state"]= {
							["stateId"] = 1100802,
							["duration"] = 10,
						},
						["hitCue"]= {
							["cueList"] = {10000025,},
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

		["actTime"] = 60,
	},
	[1100802] = {
		["bhEvent"] = "skill.1100802",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {110080005,},
				},
			},
			[1]= {
				["eventType"] = 1,
				["boxId"] = 1100801,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {110080006,},
				},
			},
			[99]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {110081002,},
				},
			},
		},

	},
	[1100821] = {
		["bhEvent"] = "skill.1100821",
		["atkEvents"]= {
			[1]= {
				["targetArea"] = 3,
				["targetChoose"] = 7,
				["boxId"] = 1100821,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {110080008,},
				},
				["randomTargetNumber"] = 3,
				["randomRule"] = 2,
				["levelAtkEvents"]= {
					[2]= {
						["randomTargetNumber"] = 20,
					},
					[3]= {
						["state"]= {
							["stateId"] = 1100801,
							["duration"] = 10,
						},
						["randomTargetNumber"] = 20,
					},
					[4]= {
					},
					[5]= {
					},
					[6]= {
					},
				},

			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {110080007,110081003,},
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
