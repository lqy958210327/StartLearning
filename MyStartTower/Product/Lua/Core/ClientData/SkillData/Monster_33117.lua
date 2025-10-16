local Data = {
["cueFile"] = "33117",
	[3311701] = {
		["bhEvent"] = "skill.3311701",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331170002,331171001,},
				},
			},
			[0]= {
				["unitDelay"] = 0.16,
				["flyCueId"] = 331170004,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3311701,
				["state"]= {
					["stateId"] = 3311701,
					["duration"] = 10,
				},
				["hitCue"]= {
					["cueList"] = {331170006,331171002,},
				},
			},
			[1001]= {
				["state"]= {
					["stateId"] = 3311702,
					["duration"] = 5,
				},
			},
		},

	},
	[3311702] = {
		["bhEvent"] = "skill.3311702",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331170003,331171003,},
				},
			},
			[0]= {
				["unitDelay"] = 0.16,
				["flyCueId"] = 331170005,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3311701,
				["state"]= {
					["stateId"] = 3311701,
					["duration"] = 10,
				},
				["hitCue"]= {
					["cueList"] = {331170006,331171004,},
				},
			},
		},

	},
	[3311703] = {
		["bhEvent"] = "skill.3311703",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331170002,331171001,},
				},
			},
			[0]= {
				["unitDelay"] = 0.16,
				["flyCueId"] = 331170004,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3311702,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331170006,331171002,},
				},
			},
		},

	},
	[3311704] = {
		["bhEvent"] = "skill.3311704",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331170003,331171003,},
				},
			},
			[0]= {
				["unitDelay"] = 0.16,
				["flyCueId"] = 331170005,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3311702,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331170006,331171004,},
				},
			},
		},

	},
	[3311752] = {
		["bhEvent"] = "skill.3311752",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331170009,331170010,331171005,},
				},
			},
			[0]= {
				["delay"] = 0.3,
				["flyCueId"] = 331170011,
				["boxType"] = 1,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331170012,},
				},
			},
			[1]= {
				["targetChoose"] = 4,
				["eventType"] = 1,
				["boxId"] = 3311752,
				["state"]= {
					["stateId"] = 3311703,
					["duration"] = 8,
				},
				["hitCue"]= {
					["cueList"] = {331170013,},
				},
			},
		},

		["actTime"] = 60,
	},
	[3311721] = {
		["bhEvent"] = "skill.3311721",
		["atkEvents"]= {
			[100]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 3311704,
					["duration"] = 3,
				},
				["atkCue"]= {
					["cueList"] = {331170009,331170010,331171005,10005003,},
				},
			},
			[0]= {
				["targetChoose"] = 7,
				["delay"] = 0.3,
				["flyCueId"] = 331170011,
				["boxType"] = 1,
				["boxId"] = 3311721,
				["state"]= {
					["stateId"] = 3311703,
					["duration"] = 8,
				},
				["hitCue"]= {
					["cueList"] = {331170012,},
				},
				["randomTargetNumber"] = 1,
			},
			[1]= {
				["state"]= {
				},
			},
			[1001]= {
				["targetChoose"] = 4,
				["eventType"] = 1,
				["boxId"] = 3311721,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331170013,},
				},
				["disablePassive"] = 1,
				["excludeTarget"] = 1,
			},
		},

		["actTime"] = 60,
		["skillTarget"] = 1,
	},
	[3311751] = {
		["bhEvent"] = "skill.3311751",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331170014,331171006,},
				},
			},
			[0]= {
				["targetChoose"] = 7,
				["boxId"] = 3311751,
				["state"]= {
					["stateId"] = 3311703,
					["duration"] = 8,
				},
			},
			[1001]= {
				["eventType"] = 1,
				["boxId"] = 3311760,
				["state"]= {
				},
				["disablePassive"] = 1,
			},
			[1]= {
				["targetChoose"] = 7,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331170015,},
				},
			},
		},

		["actTime"] = 65,
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
