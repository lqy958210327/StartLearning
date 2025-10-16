local Data = {
["cueFile"] = "33005",
	[3300501] = {
		["bhEvent"] = "skill.3300501",
		["atkEvents"]= {
			[1]= {
				["unitDelay"] = 0.25,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3300501,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {330050001,},
				},
			},
		},

	},
	[3300551] = {
		["bhEvent"] = "skill.3300551",
		["atkEvents"]= {
			[1]= {
				["targetArea"] = 2,
				["targetChoose"] = 4,
				["eventType"] = 1,
				["boxId"] = 3300551,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {330050001,},
				},
			},
			[100]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {330050002,},
				},
			},
		},

		["actTime"] = 30,
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
