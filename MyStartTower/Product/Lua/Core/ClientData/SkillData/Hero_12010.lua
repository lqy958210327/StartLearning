local Data = {
["cueFile"] = "12008",
	[1201009] = {
		["bhEvent"] = "skill.1201009",
		["atkEvents"]= {
			[1]= {
				["eventType"] = 1,
				["boxId"] = 1201009,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000062,},
				},
			},
		},

	},
	[1201059] = {
		["bhEvent"] = "skill.1201059",
		["atkEvents"]= {
			[1]= {
				["targetChoose"] = 3,
				["eventType"] = 1,
				["boxId"] = 1201059,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {120080003,},
				},
				["levelAtkEvents"]= {
					[2]= {
					},
					[3]= {
						["state"]= {
							["stateId"] = 1500101,
							["duration"] = 10,
						},
					},
					[4]= {
						["state"]= {
							["stateId"] = 1500101,
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
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {120081006,},
				},
			},
			[1001]= {
				["targetArea"] = 3,
				["targetChoose"] = 7,
				["state"]= {
					["stateId"] = 1201001,
					["duration"] = 15,
				},
				["hitCue"]= {
					["cueList"] = {120080001,},
				},
				["excludeTarget"] = 1,
				["levelAtkEvents"]= {
					[2]= {
					},
					[3]= {
						["state"]= {
							["stateId"] = 1201001,
							["duration"] = -999,
						},
					},
					[4]= {
						["state"]= {
							["stateId"] = 1201001,
							["duration"] = -999,
						},
					},
					[5]= {
					},
					[6]= {
					},
				},

			},
			[5]= {
				["targetArea"] = 3,
				["boxId"] = 1201060,
				["state"]= {
				},
			},
		},

		["actTime"] = 30,
	},
	[1201010] = {
		["bhEvent"] = "skill.1201010",
		["atkEvents"]= {
			[1]= {
				["eventType"] = 1,
				["boxId"] = 1201009,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000062,},
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
