local Data = {
["cueFile"] = "15002",
	[1590101] = {
		["bhEvent"] = "skill.1590101",
		["atkEvents"]= {
			[0]= {
				["eventType"] = 1,
				["boxId"] = 1590101,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {150020001,},
				},
			},
		},

	},
	[1590121] = {
		["bhEvent"] = "skill.1590121",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
			},
			[1]= {
				["targetArea"] = 3,
				["targetChoose"] = 3,
				["state"]= {
					["stateId"] = 1590101,
					["duration"] = -999,
				},
				["excludeTarget"] = 1,
				["levelAtkEvents"]= {
					[2]= {
					},
					[3]= {
						["targetChoose"] = 10,
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

		["actTime"] = 45,
		["skillTarget"] = 1,
	},
	[1590151] = {
		["bhEvent"] = "skill.1590151",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
			},
			[1]= {
				["targetArea"] = 3,
				["targetChoose"] = 7,
				["boxId"] = 1590151,
				["state"]= {
					["stateId"] = 1590102,
					["duration"] = 10,
				},
				["hitCue"]= {
					["cueList"] = {10000008,},
				},
			},
		},

		["actTime"] = 60,
		["videoActTime"] = 50,
		["videoActCue"]= {
			["cueList"] = {150028002,150021005,},
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
