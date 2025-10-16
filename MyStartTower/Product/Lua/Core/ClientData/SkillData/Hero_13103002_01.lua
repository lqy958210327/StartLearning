local Data = {
["cueFile"] = "13103",
	[1640109] = {
		["bhEvent"] = "skill.1640109",
		["atkEvents"]= {
			[100]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {131030031,},
				},
			},
			[1]= {
				["targetChoose"] = 19,
				["unitDelay"] = 0.2,
				["flyCueId"] = 131030004,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1310309,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {131030005,},
				},
				["randomTargetNumber"] = 1,
			},
		},

		["skillTarget"] = 1,
	},
	[1640110] = {
		["bhEvent"] = "skill.1640110",
		["atkEvents"]= {
			[100]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {131030032,},
				},
			},
			[1]= {
				["targetChoose"] = 19,
				["unitDelay"] = 0.2,
				["flyCueId"] = 131030007,
				["boxType"] = 1,
				["eventType"] = 1,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {131030008,},
				},
				["randomTargetNumber"] = 1,
			},
		},

		["skillTarget"] = 1,
	},
	[1640111] = {
		["bhEvent"] = "skill.1640111",
		["atkEvents"]= {
			[100]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {131030033,131030011,131030010,},
				},
			},
			[1]= {
				["targetChoose"] = 19,
				["unitDelay"] = 0.2,
				["flyCueId"] = 131030012,
				["boxType"] = 1,
				["eventType"] = 1,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {131030013,},
				},
				["randomTargetNumber"] = 1,
			},
		},

		["skillTarget"] = 1,
	},
	[1640112] = {
		["bhEvent"] = "skill.1640112",
		["atkEvents"]= {
			[100]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {131030034,131030015,131030016,},
				},
			},
			[1]= {
				["targetChoose"] = 19,
				["unitDelay"] = 0.2,
				["flyCueId"] = 131030017,
				["boxType"] = 1,
				["eventType"] = 1,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {131030018,},
				},
				["randomTargetNumber"] = 1,
			},
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
