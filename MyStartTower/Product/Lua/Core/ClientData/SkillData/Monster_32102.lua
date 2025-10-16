local Data = {
["cueFile"] = "32101",
	[3210201] = {
		["bhEvent"] = "skill.3210201",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {321011004,321010026,},
				},
			},
			[1]= {
				["eventType"] = 1,
				["boxId"] = 3210201,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {321010027,},
				},
			},
		},

	},
	[3210202] = {
		["bhEvent"] = "skill.3210202",
		["atkEvents"]= {
			[1]= {
				["eventType"] = 1,
				["boxId"] = 3210201,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000062,},
				},
			},
		},

	},
	[3210251] = {
		["bhEvent"] = "skill.3210251 ",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {321011005,321010024,},
				},
			},
			[1]= {
				["targetArea"] = 2,
				["targetChoose"] = 3,
				["eventType"] = 1,
				["boxId"] = 3210251,
				["state"]= {
					["stateId"] = 3210201,
					["duration"] = 10,
				},
				["atkCue"]= {
					["cueList"] = {321010010,},
				},
				["hitCue"]= {
					["cueList"] = {321010028,},
				},
				["excludeTarget"] = 1,
			},
			[2]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 3210204,
					["duration"] = 5,
				},
				["hitCue"]= {
					["cueList"] = {10000048,},
				},
			},
		},

	},
	[3210252] = {
		["bhEvent"] = "skill.3210252",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
			},
			[1]= {
				["targetArea"] = 3,
				["targetChoose"] = 3,
				["state"]= {
					["stateId"] = 3210202,
					["duration"] = 10,
				},
				["atkCue"]= {
					["cueList"] = {321010029,321011006,},
				},
			},
		},

		["skillTarget"] = 1,
	},
	[3210253] = {
		["bhEvent"] = "skill.3210253",
		["atkEvents"]= {
			[1]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 3210203,
					["duration"] = 8,
				},
				["hitCue"]= {
					["cueList"] = {321010029,321011006,},
				},
			},
		},

		["actTime"] = 55,
		["skillTarget"] = 1,
	},
	[3210203] = {
		["bhEvent"] = "skill.3210203",
		["atkEvents"]= {
			[100]= {
				["eventType"] = 1,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {321010024,321011005,},
				},
			},
			[1]= {
				["targetArea"] = 2,
				["targetChoose"] = 3,
				["eventType"] = 1,
				["boxId"] = 3210203,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {321010028,},
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
