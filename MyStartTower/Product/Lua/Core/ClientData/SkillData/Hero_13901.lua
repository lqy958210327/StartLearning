local Data = {
["cueFile"] = "13005",
	[1390101] = {
		["bhEvent"] = "skill.1390101",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {130050001,},
				},
			},
			[0]= {
				["unitDelay"] = 0.15,
				["flyCueId"] = 130050003,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1390101,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {130050004,},
				},
			},
		},

	},
	[1390121] = {
		["bhEvent"] = "skill.1390101",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
			},
			[1001]= {
				["targetChoose"] = 3,
				["unitDelay"] = 0.15,
				["flyCueId"] = 130050003,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1390121,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {130050006,},
				},
			},
		},

	},
	[1390151] = {
		["bhEvent"] = "skill.1390151",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {130050007,130050008,},
				},
			},
			[1]= {
				["targetChoose"] = 7,
				["unitDelay"] = 0.15,
				["flyCueId"] = 130050009,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1390151,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {130050010,},
				},
			},
		},

		["actTime"] = 60,
		["videoActTime"] = 52,
		["videoActCue"]= {
			["cueList"] = {130058001,130051005,},
		},
	},
	[1390152] = {
		["bhEvent"] = "skill.1390152",
		["atkEvents"]= {
			[100]= {
				["targetArea"] = 3,
				["targetChoose"] = 24,
				["state"]= {
				},
				["randomTargetNumber"] = 1,
				["rebornMhp"] = 10000,
			},
			[1]= {
				["unitDelay"] = 0.15,
				["flyCueId"] = 130050009,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1390161,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {130050010,},
				},
			},
		},

		["actTime"] = 60,
		["videoActTime"] = 52,
		["videoActCue"]= {
			["cueList"] = {130058001,130051005,},
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
