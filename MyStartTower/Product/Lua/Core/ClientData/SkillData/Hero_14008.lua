local Data = {
["cueFile"] = "14008",
	[1400801] = {
		["bhEvent"] = "skill.1400801",
		["atkEvents"]= {
			[1]= {
				["unitDelay"] = 0.15,
				["flyCueId"] = 140080007,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1400801,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {140080008,140081003,},
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {140080006,140081002,},
				},
			},
		},

	},
	[1400851] = {
		["bhEvent"] = "skill.1400851",
		["atkEvents"]= {
			[1]= {
				["eventType"] = 1,
				["boxId"] = 1400851,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {140080012,},
				},
			},
			[2]= {
				["targetArea"] = 1,
				["targetChoose"] = 11,
				["boxId"] = 1400852,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000008,},
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {140080011,140080010,140081005,},
				},
			},
		},

		["actTime"] = 45,
	},
	[1400821] = {
		["bhEvent"] = "skill.1400801",
		["atkEvents"]= {
			[1]= {
				["state"]= {
				},
			},
			[1001]= {
				["targetArea"] = 3,
				["boxId"] = 1400821,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {140080009,140081004,},
				},
			},
			[100]= {
				["state"]= {
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
