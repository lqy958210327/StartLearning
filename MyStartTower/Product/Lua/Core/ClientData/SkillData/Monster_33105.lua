local Data = {
["cueFile"] = "33104",
	[3310501] = {
		["bhEvent"] = "skill.3310501",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331040032,331041003,},
				},
			},
			[1]= {
				["unitDelay"] = 0.1,
				["flyCueId"] = 331040034,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3310501,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000062,331041004,},
				},
			},
		},

	},
	[3310551] = {
		["bhEvent"] = "skill.3310551",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331040036,331040037,331041005,},
				},
			},
			[1]= {
				["unitDelay"] = 0.1,
				["flyCueId"] = 331040034,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3310551,
				["state"]= {
					["stateId"] = 3310501,
					["duration"] = 5,
				},
				["hitCue"]= {
					["cueList"] = {331040038,},
				},
			},
		},

		["actTime"] = 50,
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
