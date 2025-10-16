local Data = {
["cueFile"] = "12008",
	[1200801] = {
		["bhEvent"] = "skill.1200801",
		["atkEvents"]= {
			[1]= {
				["eventType"] = 1,
				["boxId"] = 1200801,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {120080007,},
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {120080006,120081001,},
				},
			},
		},

	},
	[1200802] = {
		["bhEvent"] = "skill.1200802",
		["atkEvents"]= {
			[1]= {
				["unitDelay"] = 0.1,
				["flyCueId"] = 120080002,
				["eventType"] = 1,
				["boxId"] = 1200801,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {120080007,},
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {120080006,120081001,},
				},
			},
		},

	},
	[1200803] = {
		["bhEvent"] = "skill.1200803",
		["atkEvents"]= {
			[1]= {
				["targetArea"] = 2,
				["targetChoose"] = 3,
				["eventType"] = 1,
				["boxId"] = 1200804,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {120080009,},
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {120080008,120080006,120081002,},
				},
			},
		},

	},
	[1200851] = {
		["bhEvent"] = "skill.1200851",
		["atkEvents"]= {
			[1]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1200801,
					["duration"] = 5,
				},
				["hitCue"]= {
					["cueList"] = {120080011,120081003,},
				},
			},
			[100]= {
				["state"]= {
				},
			},
		},

		["actTime"] = 30,
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
