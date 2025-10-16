local Data = {
["cueFile"] = "13003",
	[3300401] = {
		["bhEvent"] = "skill.3300401",
		["atkEvents"]= {
			[0]= {
				["unitDelay"] = 0.12,
				["flyCueId"] = 130030002,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3300401,
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
				["boxId"] = 3300401,
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
	[3300402] = {
		["bhEvent"] = "skill.3300402",
		["atkEvents"]= {
			[0]= {
				["unitDelay"] = 0.05,
				["flyCueId"] = 130030010,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3300401,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {130030003,130031004,},
				},
			},
			[1]= {
				["targetChoose"] = 7,
				["unitDelay"] = 0.05,
				["flyCueId"] = 130030010,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3300401,
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
	[3300421] = {
		["bhEvent"] = "skill.3300421",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {90015001,},
				},
			},
			[0]= {
				["targetArea"] = 3,
				["targetChoose"] = 7,
				["state"]= {
					["stateId"] = 3300401,
					["duration"] = -999,
				},
				["hitCue"]= {
					["cueList"] = {130030014,},
				},
			},
			[10]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {130030013,},
				},
			},
		},

		["actTime"] = 47,
		["skillTarget"] = 1,
	},
	[3300451] = {
		["bhEvent"] = "skill.3300451",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {130030005,},
				},
			},
			[0]= {
				["targetArea"] = 3,
				["targetChoose"] = 7,
				["state"]= {
					["stateId"] = 3300402,
					["duration"] = -999,
				},
				["hitCue"]= {
					["cueList"] = {130030007,10000001,130031005,},
				},
				["addManaNumber"] = 50,
				["excludeTarget"] = 1,
			},
			[1001]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 3300404,
					["duration"] = -999,
				},
			},
			[1]= {
				["state"]= {
				},
			},
			[101]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {130030006,},
				},
			},
		},

		["actTime"] = 90,
		["skillTarget"] = 1,
	},
	[3300452] = {
		["bhEvent"] = "skill.3300452",
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
				["unitDelay"] = 0.1,
				["flyCueId"] = 90010027,
				["eventType"] = 1,
				["boxId"] = 3300451,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {130030008,},
				},
			},
			[10]= {
				["state"]= {
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
