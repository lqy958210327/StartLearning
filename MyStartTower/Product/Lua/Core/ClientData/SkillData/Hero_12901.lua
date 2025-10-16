local Data = {
["cueFile"] = "12012",
	[1290101] = {
		["bhEvent"] = "skill.1290101",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {120120001,},
				},
			},
			[1]= {
				["eventType"] = 1,
				["boxId"] = 1290101,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {120120004,},
				},
			},
		},

	},
	[1290121] = {
		["bhEvent"] = "skill.1290101",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
			},
			[1001]= {
				["eventType"] = 1,
				["boxId"] = 1290121,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {120120004,},
				},
			},
			[1002]= {
				["targetArea"] = 3,
				["boxId"] = 1290122,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000008,},
				},
			},
			[1]= {
				["state"]= {
				},
			},
		},

	},
	[1290151] = {
		["bhEvent"] = "skill.1290151",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {120120007,},
				},
			},
			[1]= {
				["eventType"] = 1,
				["boxId"] = 1290151,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {120120009,},
				},
			},
			[2]= {
				["targetArea"] = 3,
				["boxId"] = 1290152,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000008,},
				},
			},
		},

		["actTime"] = 96,
		["videoActTime"] = 64,
		["videoActCue"]= {
			["cueList"] = {120128001,120121006,},
		},
	},
	[1290152] = {
		["bhEvent"] = "skill.1290152",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {120120007,},
				},
			},
			[1]= {
				["targetChoose"] = 3,
				["eventType"] = 1,
				["boxId"] = 1290161,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {120120009,},
				},
			},
			[2]= {
				["targetArea"] = 3,
				["boxId"] = 1290152,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000008,},
				},
			},
		},

		["actTime"] = 96,
		["videoActTime"] = 64,
		["videoActCue"]= {
			["cueList"] = {120128001,120121006,},
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
