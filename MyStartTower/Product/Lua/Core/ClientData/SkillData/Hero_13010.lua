local Data = {
["cueFile"] = "13010",
	[1301009] = {
		["bhEvent"] = "skill.1301009",
		["atkEvents"]= {
			[1001]= {
				["state"]= {
					["stateId"] = 1301001,
					["duration"] = 10,
				},
			},
			[1002]= {
				["delay"] = 0.2,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1301029,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {130100001,},
				},
				["disablePassive"] = 1,
			},
			[2]= {
				["unitDelay"] = 0.15,
				["flyCueId"] = 130100002,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1301009,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000062,130100003,130101002,},
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {130100001,130101001,},
				},
			},
		},

	},
	[1301059] = {
		["bhEvent"] = "skill.1301059",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {130100004,130101003,},
				},
			},
			[1001]= {
				["targetArea"] = 3,
				["boxId"] = 1301060,
				["state"]= {
				},
			},
			[1]= {
				["targetArea"] = 3,
				["summonMonsters"] = "1630101",
				["state"]= {
				},
				["levelAtkEvents"]= {
					[2]= {
						["summonMonsters"] = "1630102",
					},
					[3]= {
						["summonMonsters"] = "1630103",
					},
					[4]= {
						["summonMonsters"] = "1630103",
					},
					[5]= {
					},
					[6]= {
					},
				},

			},
			[1002]= {
				["targetArea"] = 3,
				["targetChoose"] = 15,
				["state"]= {
					["stateId"] = 1301005,
					["duration"] = 2,
				},
			},
			[1003]= {
				["targetArea"] = 3,
				["targetChoose"] = 15,
				["state"]= {
					["stateOperation"] = 1,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {1301001,},
				},
			},
			[1004]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["addManaNumber"] = 20,
			},
			[1005]= {
				["targetArea"] = 3,
				["summonMonsters"] = "1630103",
				["state"]= {
				},
			},
		},

		["actTime"] = 60,
		["skillTarget"] = 1,
	},
	[1301060] = {
		["bhEvent"] = "skill.1301060",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {130100004,130101003,},
				},
			},
			[1]= {
				["targetArea"] = 3,
				["summonMonsters"] = "1630111",
				["state"]= {
				},
			},
		},

		["actTime"] = 60,
		["skillTarget"] = 1,
	},
	[1301010] = {
		["bhEvent"] = "skill.1301010",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {130100001,130101001,},
				},
			},
			[2]= {
				["targetChoose"] = 7,
				["unitDelay"] = 0.15,
				["flyCueId"] = 130100002,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1301009,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000062,130100003,130101002,},
				},
				["randomTargetNumber"] = 3,
				["randomRule"] = 2,
			},
		},

	},
	[1301061] = {
		["bhEvent"] = "skill.1301061",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {130100004,130101003,},
				},
			},
			[1]= {
				["summonMonsters"] = "1630112,1630112",
				["state"]= {
				},
			},
			[1001]= {
				["targetArea"] = 3,
				["boxId"] = 1301060,
				["state"]= {
				},
			},
			[1002]= {
				["targetArea"] = 3,
				["targetChoose"] = 15,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000035,},
				},
				["addManaNumber"] = 30,
			},
			[1003]= {
				["targetArea"] = 3,
				["targetChoose"] = 18,
				["boxId"] = 1301010,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000045,10000047,},
				},
				["excludeTarget"] = 1,
			},
			[1004]= {
				["targetChoose"] = 7,
				["boxId"] = 1301061,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000062,},
				},
			},
		},

		["actTime"] = 60,
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
