local Data = {
["cueFile"] = "33102",
	[3310301] = {
		["bhEvent"] = "skill.3310301",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331020018,331021006,},
				},
			},
			[1]= {
				["unitDelay"] = 0.1,
				["flyCueId"] = 331020019,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3310301,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331020020,331021003,},
				},
			},
		},

	},
	[3310351] = {
		["bhEvent"] = "skill.3310351",
		["atkEvents"]= {
			[1]= {
				["targetArea"] = 2,
				["targetChoose"] = 4,
				["unitDelay"] = 0.1,
				["flyCueId"] = 331030005,
				["eventType"] = 1,
				["boxId"] = 3310351,
				["state"]= {
					["stateId"] = 1000002,
					["duration"] = 8,
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331020021,331020022,331020023,331021004,},
				},
			},
		},

		["actTime"] = 55,
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
