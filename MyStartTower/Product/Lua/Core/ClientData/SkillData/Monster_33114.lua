local Data = {
["cueFile"] = "33114",
	[3311401] = {
		["bhEvent"] = "skill.3311401",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331140001,331141001,},
				},
			},
			[1]= {
				["unitDelay"] = 0.12,
				["flyCueId"] = 331140002,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3311401,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331140005,331141002,},
				},
			},
		},

	},
	[3311402] = {
		["bhEvent"] = "skill.3311402",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331140001,331141001,},
				},
			},
			[1]= {
				["unitDelay"] = 0.12,
				["flyCueId"] = 331140003,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3311401,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331140005,331141002,},
				},
			},
		},

	},
	[3311403] = {
		["bhEvent"] = "skill.3311403",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331140001,331141001,},
				},
			},
			[1]= {
				["unitDelay"] = 0.12,
				["flyCueId"] = 331140004,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3311401,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331140005,331141002,},
				},
			},
		},

	},
	[3311421] = {
		["bhEvent"] = "skill.3311421",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {10005003,},
				},
			},
			[1]= {
				["targetArea"] = 2,
				["targetChoose"] = 3,
				["eventType"] = 1,
				["boxId"] = 3311421,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331140018,},
				},
			},
			[1001]= {
				["targetArea"] = 3,
				["state"]= {
					["stateOperation"] = 1,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {3311404,},
				},
			},
			[2]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331140006,331141003,},
				},
			},
			[3]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331140006,331141003,},
				},
			},
			[4]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331140006,331141003,},
				},
			},
			[5]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331140006,331141003,},
				},
			},
			[10]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 3311407,
					["duration"] = -999,
				},
			},
		},

		["actTime"] = 30,
	},
	[3311451] = {
		["bhEvent"] = "skill.3311451",
		["atkEvents"]= {
			[100]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 3311401,
					["duration"] = 2,
				},
				["atkCue"]= {
					["cueList"] = {331140010,331141004,},
				},
			},
			[1]= {
				["targetChoose"] = 10,
				["eventType"] = 1,
				["boxId"] = 3311451,
				["state"]= {
				},
			},
			[2]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 3311402,
					["duration"] = -999,
				},
			},
			[1001]= {
				["targetChoose"] = 3,
				["eventType"] = 1,
				["boxId"] = 3311451,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000062,},
				},
				["disablePassive"] = 1,
				["excludeTarget"] = 1,
			},
			[3]= {
				["targetChoose"] = 7,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331140011,331141005,},
				},
			},
		},

		["actTime"] = 50,
	},
	[3311452] = {
		["bhEvent"] = "skill.3311452",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331140012,},
				},
			},
			[1]= {
				["targetChoose"] = 7,
				["unitDelay"] = 0.15,
				["flyCueId"] = 331140013,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3311452,
				["state"]= {
					["stateId"] = 3311406,
					["duration"] = 5,
				},
				["hitCue"]= {
					["cueList"] = {331140014,331141006,},
				},
				["randomTargetNumber"] = 3,
				["randomRule"] = 2,
			},
			[2]= {
				["targetArea"] = 3,
				["state"]= {
					["stateOperation"] = 1,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {3311402,},
				},
			},
			[3]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 3311403,
					["duration"] = -999,
				},
			},
		},

		["actTime"] = 64,
	},
	[3311453] = {
		["bhEvent"] = "skill.3311453",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331140016,331141007,},
				},
				["hitCue"]= {
					["cueList"] = {331140017,},
				},
			},
			[1]= {
				["targetChoose"] = 3,
				["unitDelay"] = 0.15,
				["eventType"] = 1,
				["boxId"] = 3311453,
				["state"]= {
				},
			},
			[2]= {
				["targetArea"] = 3,
				["state"]= {
					["stateOperation"] = 1,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {3311403,},
				},
			},
		},

		["actTime"] = 60,
	},
	[3311461] = {
		["bhEvent"] = "skill.3311461",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331140010,331141004,},
				},
			},
			[3]= {
				["targetChoose"] = 7,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331140011,331141005,},
				},
			},
			[1]= {
				["targetChoose"] = 7,
				["eventType"] = 1,
				["boxId"] = 3311461,
				["state"]= {
				},
			},
			[2]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 3311422,
					["duration"] = -999,
				},
			},
		},

		["actTime"] = 50,
	},
	[3311462] = {
		["bhEvent"] = "skill.3311462",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331140012,},
				},
			},
			[1]= {
				["targetChoose"] = 7,
				["unitDelay"] = 0.15,
				["flyCueId"] = 331140013,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3311462,
				["state"]= {
					["stateId"] = 3311406,
					["duration"] = 5,
				},
				["hitCue"]= {
					["cueList"] = {331140014,331141006,},
				},
				["randomTargetNumber"] = 3,
				["randomRule"] = 2,
			},
			[2]= {
				["targetArea"] = 3,
				["state"]= {
					["stateOperation"] = 1,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {3311422,},
				},
			},
			[3]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 3311423,
					["duration"] = -999,
				},
			},
		},

		["actTime"] = 64,
	},
	[3311463] = {
		["bhEvent"] = "skill.3311463",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331140016,331141007,},
				},
				["hitCue"]= {
					["cueList"] = {331140017,},
				},
			},
			[1]= {
				["eventType"] = 1,
				["boxId"] = 3311463,
				["state"]= {
				},
			},
			[2]= {
				["targetArea"] = 3,
				["state"]= {
					["stateOperation"] = 1,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {3311423,},
				},
			},
		},

		["actTime"] = 60,
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
