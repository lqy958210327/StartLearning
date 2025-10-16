local Data = {
["cueFile"] = "33002",
	[3300201] = {
		["bhEvent"] = "skill.3300201",
		["atkEvents"]= {
			[0]= {
				["targetChoose"] = 4,
				["eventType"] = 1,
				["boxId"] = 3300201,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {330020007,},
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {330020005,330020006,330021001,},
				},
			},
			[1]= {
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {330020007,},
				},
			},
		},

	},
	[3300221] = {
		["bhEvent"] = "skill.3300221",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {330020008,330021002,},
				},
			},
			[0]= {
				["targetChoose"] = 7,
				["eventType"] = 1,
				["boxId"] = 3300221,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {330020009,},
				},
				["randomTargetNumber"] = 1,
			},
			[1]= {
				["targetArea"] = 3,
				["state"]= {
					["stateOperation"] = 1,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {1000004,1000002,1100401,},
				},
			},
		},

	},
	[3300251] = {
		["bhEvent"] = "skill.3300251",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {330020011,330020010,330029001,330021003,},
				},
			},
			[0]= {
				["targetChoose"] = 7,
				["eventType"] = 1,
				["boxId"] = 3300251,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {330020013,},
				},
				["hitCue"]= {
					["cueList"] = {330020012,},
				},
			},
		},

		["actTime"] = 150,
	},
	[3300202] = {
		["bhEvent"] = "skill.3300202",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {330020005,330020006,330021001,},
				},
			},
			[0]= {
				["targetChoose"] = 1,
				["eventType"] = 1,
				["boxId"] = 3300201,
				["state"]= {
					["stateId"] = 1000001,
					["duration"] = 3,
				},
				["hitCue"]= {
					["cueList"] = {330020007,},
				},
			},
		},

	},
	[3300222] = {
		["bhEvent"] = "skill.3300222",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {330020008,330021002,},
				},
			},
			[0]= {
				["eventType"] = 1,
				["boxId"] = 3300222,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {330020009,},
				},
			},
		},

	},
	[3300252] = {
		["bhEvent"] = "skill.3300252",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {330020011,330020010,330029001,330021003,},
				},
			},
			[0]= {
				["targetChoose"] = 7,
				["eventType"] = 1,
				["boxId"] = 3300252,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {330020013,},
				},
				["hitCue"]= {
					["cueList"] = {330020012,},
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
