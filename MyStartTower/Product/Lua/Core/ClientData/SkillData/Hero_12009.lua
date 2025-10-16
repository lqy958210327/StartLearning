local Data = {
["cueFile"] = "12009",
	[1200901] = {
		["bhEvent"] = "skill.1200901",
		["atkEvents"]= {
			[1]= {
				["eventType"] = 1,
				["boxId"] = 1200901,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {120090001,},
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {120090009,},
				},
			},
		},

	},
	[1200902] = {
		["bhEvent"] = "skill.1200902",
		["atkEvents"]= {
			[1]= {
				["eventType"] = 1,
				["boxId"] = 1200901,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {120090001,},
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {120090008,},
				},
			},
		},

	},
	[1200951] = {
		["bhEvent"] = "skill.1200951",
		["atkEvents"]= {
			[1]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {120090004,120090005,120090006,120091001,},
				},
				["levelAtkEvents"]= {
					[2]= {
						["state"]= {
							["stateId"] = 1200902,
							["duration"] = 3,
						},
					},
					[3]= {
						["state"]= {
							["stateId"] = 1200902,
							["duration"] = 3,
						},
					},
					[4]= {
						["state"]= {
							["stateId"] = 1200902,
							["duration"] = 3,
						},
					},
					[5]= {
					},
					[6]= {
					},
				},

			},
			[0]= {
				["eventType"] = 1,
				["boxId"] = 1200951,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {120090007,},
				},
			},
			[2]= {
				["targetArea"] = 3,
				["state"]= {
				},
			},
			[1001]= {
				["targetArea"] = 3,
				["boxId"] = 1200952,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000008,},
				},
			},
		},

		["actTime"] = 40,
	},
	[1200921] = {
		["bhEvent"] = "skill.1200921",
		["atkEvents"]= {
			[1001]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1200901,
					["duration"] = 1,
				},
			},
			[1002]= {
				["state"]= {
					["stateId"] = 1200903,
					["duration"] = -999,
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
