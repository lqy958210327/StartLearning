local Data = {
["cueFile"] = "13001",
	[1310409] = {
		["bhEvent"] = "skill.1310409",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
			},
			[1]= {
				["unitDelay"] = 0.15,
				["flyCueId"] = 130010012,
				["boxType"] = 1,
				["boxId"] = 1310409,
				["state"]= {
				},
			},
		},

	},
	[1310429] = {
		["bhEvent"] = "skill.1310429",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
			},
			[1001]= {
				["targetChoose"] = 7,
				["eventType"] = 1,
				["boxId"] = 1310429,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000055,},
				},
				["filterChuyin"] = 1,
				["subEventType"] = 1,
				["subEventSkill"] = 1310429,
				["subEventId"] = 1011,
			},
			[1002]= {
				["eventProbId"] = 1310402,
				["targetChoose"] = 7,
				["delay"] = 0.5,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1310429,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000057,},
				},
				["filterChuyin"] = 1,
				["subEventType"] = 1,
				["subEventSkill"] = 1310429,
				["subEventId"] = 1012,
				["eventCondition"] = "2,1,1,3,5000,2",
			},
			[1003]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1310401,
					["duration"] = -999,
				},
				["subEventSkill"] = 1310429,
				["subEventId"] = 1004,
			},
			[1004]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1310401,
					["duration"] = -999,
				},
				["subEventSkill"] = 1310429,
				["subEventId"] = 1005,
			},
			[1005]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1310401,
					["duration"] = -999,
				},
				["subEventSkill"] = 1310429,
				["subEventId"] = 1006,
			},
			[1006]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1310401,
					["duration"] = -999,
				},
				["subEventSkill"] = 1310429,
				["subEventId"] = 1007,
			},
			[1007]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1310401,
					["duration"] = -999,
				},
				["subEventSkill"] = 1310429,
				["subEventId"] = 1008,
			},
			[1008]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1310401,
					["duration"] = -999,
				},
				["subEventSkill"] = 1310429,
				["subEventId"] = 1009,
			},
			[1009]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1310401,
					["duration"] = -999,
				},
				["subEventSkill"] = 1310429,
				["subEventId"] = 1010,
			},
			[1010]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1310401,
					["duration"] = -999,
				},
			},
			[1011]= {
				["targetArea"] = 3,
				["state"]= {
					["stateOperation"] = 4,
					["stateId"] = 1310401,
					["delLayer"] = 1,
				},
				["subEventType"] = 1,
				["subEventSkill"] = 1310429,
				["subEventId"] = 1002,
			},
			[1012]= {
				["targetArea"] = 3,
				["state"]= {
					["stateOperation"] = 4,
					["stateId"] = 1310401,
					["delLayer"] = 1,
				},
			},
		},

	},
	[1310459] = {
		["bhEvent"] = "skill.1310459",
		["atkEvents"]= {
			[100]= {
				["targetChoose"] = 7,
				["state"]= {
					["stateId"] = 1310402,
					["duration"] = 0.1,
				},
				["subEventSkill"] = 1310459,
				["subEventId"] = 1001,
			},
			[30]= {
				["state"]= {
				},
			},
			[1001]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1310403,
					["duration"] = 3,
				},
			},
			[1]= {
				["targetChoose"] = 7,
				["eventType"] = 1,
				["boxId"] = 1310459,
				["state"]= {
					["stateId"] = 1310408,
					["duration"] = 10,
				},
				["filterChuyin"] = 1,
			},
			[10]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1310404,
					["duration"] = 3,
				},
			},
			[90]= {
				["targetArea"] = 3,
				["state"]= {
					["stateOperation"] = 1,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {1310403,1310404,},
				},
			},
			[91]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1310405,
					["duration"] = 6,
				},
			},
			[92]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1310407,
					["duration"] = 3,
				},
				["eventCondition"] = "1,1,1310406,1",
			},
			[1002]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000008,},
				},
			},
		},

		["actTime"] = 107,
	},
	[1310460] = {
		["bhEvent"] = "skill.1310460",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
			},
			[10]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1310404,
					["duration"] = 3,
				},
			},
			[30]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {130015001,},
				},
			},
			[1]= {
				["targetChoose"] = 7,
				["boxId"] = 1310460,
				["state"]= {
				},
				["filterChuyin"] = 1,
			},
			[92]= {
				["state"]= {
				},
			},
		},

		["actTime"] = 97,
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
