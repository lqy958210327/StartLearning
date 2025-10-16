local Data = {
["cueFile"] = "11007",
	[1100909] = {
		["bhEvent"] = "skill.1100909",
		["atkEvents"]= {
			[0]= {
				["boxId"] = 1100909,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {110070001,},
				},
			},
			[1001]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1100902,
					["duration"] = 10,
				},
				["hitCue"]= {
					["cueList"] = {110070001,},
				},
			},
			[1]= {
				["eventType"] = 1,
				["boxId"] = 1100909,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {110070002,},
				},
			},
		},

	},
	[1100959] = {
		["bhEvent"] = "skill.1100959",
		["atkEvents"]= {
			[0]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1100901,
					["duration"] = 10,
				},
				["hitCue"]= {
					["cueList"] = {110070001,},
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {110075001,},
				},
			},
			[1]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1100901,
					["duration"] = 10,
				},
				["hitCue"]= {
					["cueList"] = {10000001,},
				},
			},
		},

		["actTime"] = 50,
		["skillTarget"] = 1,
	},
	[1100929] = {
		["bhEvent"] = "skill.1100929",
		["atkEvents"]= {
			[0]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1100902,
					["duration"] = 10,
				},
				["hitCue"]= {
					["cueList"] = {110070001,},
				},
			},
			[1]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1100902,
					["duration"] = 10,
				},
				["hitCue"]= {
					["cueList"] = {10000001,},
				},
			},
		},

		["skillTarget"] = 1,
	},
	[1100910] = {
		["bhEvent"] = "skill.1100910",
		["atkEvents"]= {
			[1]= {
				["eventType"] = 1,
				["boxId"] = 1100909,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {110070002,},
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
