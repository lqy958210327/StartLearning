local Data = {
["cueFile"] = "11007",
	[1100701] = {
		["bhEvent"] = "skill.1100701",
		["atkEvents"]= {
			[1]= {
				["eventType"] = 1,
				["boxId"] = 1100709,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000062,},
				},
			},
		},

	},
	[1100702] = {
		["bhEvent"] = "skill.1100702",
		["atkEvents"]= {
			[1]= {
				["eventType"] = 1,
				["boxId"] = 1100709,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000062,},
				},
			},
		},

	},
	[1100729] = {
		["bhEvent"] = "skill.1100701",
		["atkEvents"]= {
			[0]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1100701,
					["duration"] = 10,
				},
			},
		},

	},
	[1100751] = {
		["bhEvent"] = "skill.1100751",
		["atkEvents"]= {
			[2]= {
				["targetArea"] = 3,
				["boxId"] = 1100751,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000008,},
				},
			},
			[1]= {
				["targetArea"] = 2,
				["targetChoose"] = 3,
				["eventType"] = 1,
				["boxId"] = 1100759,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {110070004,},
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {110070005,},
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
