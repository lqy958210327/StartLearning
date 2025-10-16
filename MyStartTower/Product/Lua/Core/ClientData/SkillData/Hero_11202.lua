local Data = {
["cueFile"] = "32104",
	[1120210] = {
		["bhEvent"] = "skill.1120210",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {321040012,},
				},
			},
			[1]= {
				["boxId"] = 1120209,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000062,},
				},
			},
		},

	},
	[1120229] = {
		["bhEvent"] = "skill.1120229",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {321040014,321040015,},
				},
			},
			[1]= {
				["targetChoose"] = 2,
				["boxId"] = 1120229,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {321040016,},
				},
			},
			[2]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["levelAtkEvents"]= {
					[2]= {
						["boxId"] = 1120230,
						["hitCue"]= {
							["cueList"] = {10000025,},
						},
					},
					[3]= {
						["boxId"] = 1120230,
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

	},
	[1120209] = {
		["bhEvent"] = "skill.1120209",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {321040011,},
				},
			},
			[1]= {
				["boxId"] = 1120209,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000062,},
				},
			},
		},

	},
	[1120259] = {
		["bhEvent"] = "skill.1120259",
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
					["stateId"] = 1120201,
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
