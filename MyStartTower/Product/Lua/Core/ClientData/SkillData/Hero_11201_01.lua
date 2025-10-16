local Data = {
["cueFile"] = "10001",
	[1120103] = {
		["bhEvent"] = "skill.1120103",
		["atkEvents"]= {
			[1]= {
				["state"]= {
				},
			},
		},

	},
	[1120122] = {
		["bhEvent"] = "skill.1120122",
		["atkEvents"]= {
			[2]= {
				["targetArea"] = 2,
				["state"]= {
				},
			},
			[1]= {
				["targetChoose"] = 1,
				["boxId"] = 1100409,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000029,},
				},
			},
		},

	},
	[1120152] = {
		["bhEvent"] = "skill.1120152",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
			},
			[1]= {
				["state"]= {
				},
			},
			[2]= {
				["state"]= {
					["stateOperation"] = 1,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {1220101,},
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
