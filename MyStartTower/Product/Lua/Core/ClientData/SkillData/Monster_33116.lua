local Data = {
["cueFile"] = "33116",
	[3311601] = {
		["bhEvent"] = "skill.3311601",
		["atkEvents"]= {
			[100]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 3311601,
					["duration"] = 2,
				},
				["atkCue"]= {
					["cueList"] = {331160001,331161001,},
				},
			},
			[1]= {
				["unitDelay"] = 0.15,
				["flyCueId"] = 331160002,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3311601,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000062,331161002,},
				},
			},
		},

	},
	[3311651] = {
		["bhEvent"] = "skill.3311651",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331160003,331161003,},
				},
			},
			[1]= {
				["targetArea"] = 3,
				["targetChoose"] = 18,
				["unitDelay"] = 0.15,
				["flyCueId"] = 331160004,
				["boxType"] = 1,
				["state"]= {
					["stateId"] = 3311602,
					["duration"] = 6,
				},
				["hitCue"]= {
					["cueList"] = {331161004,},
				},
			},
			[1001]= {
				["targetArea"] = 1,
				["boxId"] = 3311651,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000047,},
				},
			},
		},

		["actTime"] = 45,
		["skillTarget"] = 1,
	},
	[3311652] = {
		["bhEvent"] = "skill.3311652",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331160006,331161005,},
				},
			},
			[1]= {
				["unitDelay"] = 0.15,
				["flyCueId"] = 331160007,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3311652,
				["state"]= {
					["stateId"] = 3311603,
					["duration"] = 8,
				},
				["hitCue"]= {
					["cueList"] = {331160008,331161006,},
				},
			},
			[1001]= {
				["boxId"] = 3311660,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000063,},
				},
			},
		},

		["actTime"] = 45,
	},
	[3311653] = {
		["bhEvent"] = "skill.3311653",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331160006,331161007,},
				},
			},
			[1]= {
				["targetChoose"] = 4,
				["eventType"] = 1,
				["boxId"] = 3311653,
				["state"]= {
					["stateId"] = 3311603,
					["duration"] = 8,
				},
				["hitCue"]= {
					["cueList"] = {331160008,},
				},
			},
			[2]= {
				["delay"] = 0.4,
				["flyCueId"] = 331160011,
				["boxType"] = 1,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331160010,331161008,},
				},
			},
			[3]= {
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331160012,},
				},
			},
		},

		["actTime"] = 46,
	},
	[3311602] = {
		["bhEvent"] = "skill.3311602",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331160001,331161001,},
				},
			},
			[1]= {
				["unitDelay"] = 0.15,
				["flyCueId"] = 331160002,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3311601,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000062,331161002,},
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
