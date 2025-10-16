local Data = {
["cueFile"] = "32104",
	[1220209] = {
		["bhEvent"] = "skill.1220209",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {321040011,},
				},
			},
			[1]= {
				["boxId"] = 1220209,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000062,},
				},
			},
		},

	},
	[1220210] = {
		["bhEvent"] = "skill.1220210",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {321040012,},
				},
			},
			[1]= {
				["boxId"] = 1220209,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000062,},
				},
			},
		},

	},
	[1220229] = {
		["bhEvent"] = "skill.1220229",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {321040017,321040018,321040019,},
				},
			},
			[1]= {
				["targetChoose"] = 1,
				["boxId"] = 1220229,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {321040020,},
				},
			},
			[2]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["levelAtkEvents"]= {
					[2]= {
						["state"]= {
							["stateId"] = 1220202,
							["duration"] = 5,
						},
					},
					[3]= {
						["state"]= {
							["stateId"] = 1220202,
							["duration"] = 5,
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

	},
	[1220259] = {
		["bhEvent"] = "skill.1220259",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {321040021,},
				},
			},
			[1]= {
				["targetArea"] = 2,
				["state"]= {
					["stateId"] = 1220201,
					["duration"] = 8,
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
