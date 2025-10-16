local Data = {
["cueFile"] = "14002",
	[1620109] = {
		["bhEvent"] = "skill.1620109",
		["atkEvents"]= {
			[0]= {
				["eventType"] = 1,
				["boxId"] = 1620109,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000062,140021007,},
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {140020010,},
				},
			},
		},

	},
	[1620110] = {
		["bhEvent"] = "skill.1620110",
		["atkEvents"]= {
			[0]= {
				["unitDelay"] = 0.08,
				["flyCueId"] = 90010002,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1620109,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {140020001,},
				},
			},
			[100]= {
				["state"]= {
				},
			},
		},

	},
	[1620159] = {
		["bhEvent"] = "skill.1620159",
		["atkEvents"]= {
			[100]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {140020011,140021008,},
				},
			},
			[0]= {
				["targetChoose"] = 7,
				["eventType"] = 1,
				["boxId"] = 1620159,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {140020012,},
				},
			},
			[1]= {
				["targetArea"] = 3,
				["eventType"] = 1,
				["boxId"] = 1620160,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10006006,},
				},
			},
		},

		["actTime"] = 46,
	},
	[1620160] = {
		["bhEvent"] = "skill.1620160",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {140020011,140021008,},
				},
			},
			[0]= {
				["eventType"] = 1,
				["boxId"] = 1620161,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {140020012,},
				},
			},
			[1]= {
				["targetArea"] = 3,
				["eventType"] = 1,
				["boxId"] = 1620160,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10006006,},
				},
			},
		},

		["actTime"] = 46,
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
