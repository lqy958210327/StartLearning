local Data = {
["cueFile"] = "13003",
	[3300301] = {
		["bhEvent"] = "skill.3300301",
		["atkEvents"]= {
			[0]= {
				["unitDelay"] = 0.12,
				["flyCueId"] = 130030002,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3300301,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {130030003,130031003,},
				},
			},
			[1]= {
				["targetChoose"] = 7,
				["unitDelay"] = 0.12,
				["flyCueId"] = 130030002,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3300301,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {130030003,},
				},
				["randomTargetNumber"] = 2,
				["excludeTarget"] = 1,
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {130030001,},
				},
			},
		},

	},
	[3300302] = {
		["bhEvent"] = "skill.3300302",
		["atkEvents"]= {
			[0]= {
				["unitDelay"] = 0.12,
				["flyCueId"] = 130030010,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3300301,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {130030003,130031004,},
				},
			},
			[1]= {
				["targetChoose"] = 7,
				["unitDelay"] = 0.12,
				["flyCueId"] = 130030010,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3300301,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {130030003,},
				},
				["randomTargetNumber"] = 2,
				["excludeTarget"] = 1,
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {130030009,},
				},
			},
		},

	},
	[3300321] = {
		["bhEvent"] = "skill.3300321",
		["atkEvents"]= {
			[0]= {
				["targetArea"] = 3,
				["targetChoose"] = 7,
				["state"]= {
					["stateId"] = 3300301,
					["duration"] = -999,
				},
				["hitCue"]= {
					["cueList"] = {130030012,},
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {90015001,},
				},
			},
			[10]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {130030011,},
				},
			},
		},

		["actTime"] = 46,
		["skillTarget"] = 1,
	},
	[3300351] = {
		["bhEvent"] = "skill.3300351",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {130030001,},
				},
			},
			[0]= {
				["targetChoose"] = 7,
				["eventType"] = 1,
				["boxId"] = 3300351,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {130030008,},
				},
			},
		},

		["actTime"] = 150,
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
