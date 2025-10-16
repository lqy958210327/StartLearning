local Data = {
["cueFile"] = "32103",
	[3210301] = {
		["bhEvent"] = "skill.3210301",
		["atkEvents"]= {
			[1]= {
				["eventType"] = 1,
				["boxId"] = 3210301,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {321030002,},
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {321030009,},
				},
			},
		},

	},
	[3210351] = {
		["bhEvent"] = "skill.3210351",
		["atkEvents"]= {
			[1]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {321030004,321030005,321030006,321031001,},
				},
			},
			[0]= {
				["eventType"] = 1,
				["boxId"] = 3210351,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {321030007,},
				},
			},
			[2]= {
				["state"]= {
				},
			},
		},

		["actTime"] = 55,
	},
	[3210302] = {
		["bhEvent"] = "skill.3210302",
		["atkEvents"]= {
			[1]= {
				["eventType"] = 1,
				["boxId"] = 3210301,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {321030001,},
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {321030008,},
				},
			},
		},

	},
	[3210303] = {
		["bhEvent"] = "skill.3210303",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {321030018,},
				},
			},
			[1]= {
				["targetChoose"] = 1,
				["eventType"] = 1,
				["boxId"] = 3210303,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {321030007,},
				},
			},
		},

	},
	[3210352] = {
		["bhEvent"] = "skill.3210352",
		["atkEvents"]= {
			[1]= {
				["targetChoose"] = 1,
				["eventType"] = 1,
				["boxId"] = 3210352,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {321030016,},
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {321030011,},
				},
			},
		},

		["actTime"] = 45,
	},
	[3210353] = {
		["bhEvent"] = "skill.3210353",
		["atkEvents"]= {
			[1]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 3210301,
					["duration"] = 5,
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
