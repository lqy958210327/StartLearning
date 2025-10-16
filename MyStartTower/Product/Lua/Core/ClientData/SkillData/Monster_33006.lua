local Data = {
["cueFile"] = "33006",
	[3300601] = {
		["bhEvent"] = "skill.3300601",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {330060001,330061001,},
				},
			},
			[0]= {
				["boxId"] = 3300601,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {330060003,},
				},
			},
		},

	},
	[3300602] = {
		["bhEvent"] = "skill.3300602",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {330060002,330061002,},
				},
			},
			[0]= {
				["boxId"] = 3300601,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {330060004,},
				},
			},
		},

	},
	[3300621] = {
		["bhEvent"] = "skill.3300621",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {330060006,330060007,330060005,330061003,},
				},
			},
			[0]= {
				["targetChoose"] = 7,
				["boxId"] = 3300621,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {330060008,},
				},
				["controlTime"] = 2.5,
				["controlAniName"] = "Float",
			},
			[1]= {
				["targetChoose"] = 7,
				["state"]= {
				},
			},
			[2]= {
				["state"]= {
				},
			},
		},

		["actTime"] = 20,
	},
	[3300651] = {
		["bhEvent"] = "skill.3300651",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {330060009,},
				},
			},
			[10]= {
				["boxId"] = 3300651,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {330060010,330066001,},
				},
				["controlTime"] = 6,
				["controlAniName"] = "Hit01",
			},
			[116]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {330069001,},
				},
			},
			[13]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {330061005,},
				},
			},
			[9]= {
				["targetChoose"] = 7,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {330060011,},
				},
				["stunTime"] = 2,
				["excludeTarget"] = 1,
			},
		},

		["actTime"] = 45,
		["hideEffect"] = 1,
		["videoActTime"] = 60,
		["shortVideoActTime"] = 60,
		["videoActCue"]= {
			["cueList"] = {330068001,330061004,},
		},
		["shortVideoActCue"]= {
			["cueList"] = {330068001,330061004,},
		},
	},
	[3300611] = {
		["bhEvent"] = "skill.3300611",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {330060001,330061001,},
				},
			},
			[0]= {
				["eventType"] = 1,
				["boxId"] = 3300611,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {330060003,},
				},
			},
		},

	},
	[3300612] = {
		["bhEvent"] = "skill.3300612",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {330060002,330061002,},
				},
			},
			[0]= {
				["eventType"] = 1,
				["boxId"] = 3300611,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {330060004,},
				},
			},
		},

	},
	[3300631] = {
		["bhEvent"] = "skill.3300631",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {330060005,330060006,330060007,330061003,10005003,},
				},
			},
			[1]= {
				["targetChoose"] = 19,
				["eventType"] = 1,
				["boxId"] = 3300631,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {330060008,},
				},
			},
			[2]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 3300601,
					["duration"] = 3,
				},
			},
		},

		["actTime"] = 60,
	},
	[3300661] = {
		["bhEvent"] = "skill.3300661",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {330060009,},
				},
			},
			[1]= {
				["targetChoose"] = 7,
				["eventType"] = 1,
				["boxId"] = 3300661,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {330060010,},
				},
				["controlTime"] = 2,
				["controlAniName"] = "Float",
			},
		},

		["actTime"] = 45,
		["videoActTime"] = 60,
		["shortVideoActTime"] = 60,
		["videoActCue"]= {
			["cueList"] = {330068001,330061004,},
		},
		["shortVideoActCue"]= {
			["cueList"] = {330068001,330061004,},
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
