local Data = {
["cueFile"] = "32107",
	[3210701] = {
		["bhEvent"] = "skill.3210701",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {321070001,321071001,},
				},
			},
			[1]= {
				["eventType"] = 1,
				["boxId"] = 3210701,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000062,},
				},
			},
		},

	},
	[3210702] = {
		["bhEvent"] = "skill.3210702",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {321070002,321071002,},
				},
			},
			[1]= {
				["eventType"] = 1,
				["boxId"] = 3210701,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000062,},
				},
			},
		},

	},
	[3210703] = {
		["bhEvent"] = "skill.3210703",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {321070003,321071003,},
				},
			},
			[1]= {
				["targetChoose"] = 2,
				["eventType"] = 1,
				["boxId"] = 3210703,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {321070004,},
				},
			},
		},

	},
	[3210751] = {
		["bhEvent"] = "skill.3210751",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {321070005,321071004,},
				},
			},
			[1]= {
				["targetArea"] = 2,
				["targetChoose"] = 3,
				["eventType"] = 1,
				["boxId"] = 3210551,
				["state"]= {
					["stateId"] = 1000005,
					["duration"] = 5,
				},
				["hitCue"]= {
					["cueList"] = {321070006,},
				},
			},
		},

		["actTime"] = 60,
	},
	[3210752] = {
		["bhEvent"] = "skill.3210752",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {321070007,321071005,},
				},
			},
			[1]= {
				["eventType"] = 1,
				["boxId"] = 3210752,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000064,},
				},
			},
		},

		["actTime"] = 60,
	},
	[3210753] = {
		["bhEvent"] = "skill.3210753",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {321070008,321071006,},
				},
			},
			[1]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 3210701,
					["duration"] = 8,
				},
			},
		},

		["actTime"] = 60,
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
