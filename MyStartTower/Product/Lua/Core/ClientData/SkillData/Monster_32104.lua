local Data = {
["cueFile"] = "32104",
	[3210401] = {
		["bhEvent"] = "skill.3210401",
		["atkEvents"]= {
			[1]= {
				["eventType"] = 1,
				["boxId"] = 3210401,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000062,},
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {321040011,321041001,},
				},
			},
		},

	},
	[3210402] = {
		["bhEvent"] = "skill.3210402",
		["atkEvents"]= {
			[1]= {
				["eventType"] = 1,
				["boxId"] = 3210401,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000062,},
				},
			},
			[0]= {
				["state"]= {
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {321040012,321041002,},
				},
			},
		},

	},
	[3210451] = {
		["bhEvent"] = "skill.3210451",
		["atkEvents"]= {
			[1]= {
				["targetChoose"] = 2,
				["unitDelay"] = 0.1,
				["flyCueId"] = 321040008,
				["eventType"] = 1,
				["boxId"] = 3210451,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {321040016,},
				},
				["hitedAnim"] = "Hit",
				["stunTime"] = 3,
			},
			[10]= {
				["targetArea"] = 2,
				["targetChoose"] = 2,
				["state"]= {
				},
				["hitedAnim"] = "end",
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {321040014,321040015,321041003,},
				},
			},
		},

		["actTime"] = 80,
	},
	[3210452] = {
		["bhEvent"] = "skill.3210452",
		["atkEvents"]= {
			[2]= {
				["eventType"] = 1,
				["state"]= {
				},
			},
			[1]= {
				["targetChoose"] = 1,
				["eventType"] = 1,
				["boxId"] = 3210452,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {321040020,},
				},
				["hitedAnim"] = "Hit",
				["stunTime"] = 2,
			},
			[10]= {
				["targetChoose"] = 1,
				["state"]= {
				},
				["hitedAnim"] = "end",
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {321040017,321040018,321040019,321041004,},
				},
			},
		},

		["actTime"] = 55,
	},
	[3210453] = {
		["bhEvent"] = "skill.3210453",
		["atkEvents"]= {
			[1]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 3210401,
					["duration"] = 5,
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {321040021,321041005,},
				},
			},
		},

		["actTime"] = 70,
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
