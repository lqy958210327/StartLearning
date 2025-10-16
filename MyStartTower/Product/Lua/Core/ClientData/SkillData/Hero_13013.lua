local Data = {
["cueFile"] = "13013",
	[1301309] = {
		["bhEvent"] = "skill.1301309",
		["atkEvents"]= {
			[0]= {
				["unitDelay"] = 0.15,
				["flyCueId"] = 130130012,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1301309,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {130131002,},
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {130130011,130131001,},
				},
			},
		},

	},
	[1301359] = {
		["bhEvent"] = "skill.1301359",
		["atkEvents"]= {
			[0]= {
				["targetChoose"] = 7,
				["unitDelay"] = 0.1,
				["flyCueId"] = 140030001,
				["eventType"] = 1,
				["boxId"] = 1301359,
				["state"]= {
					["chooseStateType"] = 2,
					["chooseRandomNum"] = 1,
				},
				["hitCue"]= {
					["cueList"] = {130130009,},
				},
				["hitedAnim"] = "Hit",
				["randomTargetNumber"] = 1,
				["subEventSkill"] = 1301359,
				["subEventId"] = 1002,
			},
			[1]= {
				["state"]= {
				},
				["levelAtkEvents"]= {
					[2]= {
						["unitDelay"] = 0.1,
						["flyCueId"] = 140030001,
					},
					[3]= {
						["targetChoose"] = 7,
						["unitDelay"] = 0.1,
						["flyCueId"] = 140030001,
						["eventType"] = 1,
						["boxId"] = 1301359,
						["hitCue"]= {
							["cueList"] = {130130009,},
						},
						["hitedAnim"] = "Hit",
						["randomTargetNumber"] = 1,
					},
					[4]= {
					},
					[5]= {
					},
					[6]= {
					},
				},

			},
			[1001]= {
				["targetArea"] = 3,
				["targetChoose"] = 7,
				["state"]= {
					["stateOperation"] = 1,
					["chooseStateType"] = 2,
					["chooseRandomNum"] = 1,
				},
				["hitCue"]= {
					["cueList"] = {130130010,},
				},
			},
			[10]= {
				["targetArea"] = 2,
				["targetChoose"] = 7,
				["state"]= {
					["stateOperation"] = 1,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {1301301,},
				},
			},
			[15]= {
				["delay"] = 0.2,
				["boxType"] = 1,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {130130003,},
				},
			},
			[25]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {130136001,},
				},
			},
			[100]= {
				["targetChoose"] = 7,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {130130001,},
				},
			},
			[13]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {130130018,130135001,130131005,},
				},
			},
			[2]= {
				["targetArea"] = 3,
				["targetChoose"] = 7,
				["state"]= {
					["stateOperation"] = 1,
					["chooseStateType"] = 2,
					["chooseRandomNum"] = 1,
				},
				["hitCue"]= {
					["cueList"] = {130130010,},
				},
			},
			[99]= {
				["targetChoose"] = 7,
				["state"]= {
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {1301301,},
				},
				["hitedAnim"] = "end",
			},
			[1002]= {
				["state"]= {
					["stateId"] = 1301301,
					["duration"] = 10,
				},
			},
			[3]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["levelAtkEvents"]= {
					[2]= {
						["state"]= {
							["stateId"] = 1301303,
							["duration"] = 5,
						},
					},
					[3]= {
						["state"]= {
							["stateId"] = 1301303,
							["duration"] = 5,
						},
					},
					[4]= {
					},
					[5]= {
					},
					[6]= {
					},
				},

			},
		},

		["actTime"] = 85,
		["hideEffect"] = 1,
		["videoActTime"] = 68,
		["videoActCue"]= {
			["cueList"] = {130138001,130131004,},
		},
	},
	[1301329] = {
		["bhEvent"] = "skill.1301329",
		["atkEvents"]= {
			[0]= {
				["unitDelay"] = 0.15,
				["flyCueId"] = 130130014,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1301329,
				["state"]= {
					["stateId"] = 1400001,
					["duration"] = 2,
				},
				["hitCue"]= {
					["cueList"] = {130130015,},
				},
				["subEventSkill"] = 1301329,
				["subEventId"] = 1005,
			},
			[1001]= {
				["state"]= {
					["stateOperation"] = 1,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {1301302,},
				},
			},
			[1002]= {
				["targetArea"] = 3,
				["state"]= {
					["stateOperation"] = 1,
					["chooseStateType"] = 2,
					["chooseStateMode"] = 1,
				},
				["hitCue"]= {
					["cueList"] = {130130010,},
				},
			},
			[1004]= {
				["delay"] = 0.2,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1301330,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {130130017,},
				},
				["disablePassive"] = 1,
				["subEventSkill"] = 1301329,
				["subEventId"] = 1006,
			},
			[1]= {
				["unitDelay"] = 0.1,
				["flyCueId"] = 130130014,
				["baseToTarget"] = 1,
				["state"]= {
				},
			},
			[1005]= {
				["targetChoose"] = 7,
				["unitDelay"] = 0.1,
				["flyCueId"] = 130130014,
				["baseToTarget"] = 1,
				["boxType"] = 1,
				["state"]= {
					["stateId"] = 1301302,
					["duration"] = -999,
				},
				["hitCue"]= {
					["cueList"] = {130130015,},
				},
				["randomTargetNumber"] = 2,
				["randomRule"] = 2,
			},
			[1006]= {
				["targetChoose"] = 3,
				["eventType"] = 1,
				["boxId"] = 1301330,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {130130017,},
				},
				["disablePassive"] = 1,
				["excludeTarget"] = 1,
				["eventCondition"] = "1,1,8791130",
			},
			[1007]= {
				["targetArea"] = 3,
				["targetChoose"] = 7,
				["state"]= {
					["stateId"] = 1301312,
					["duration"] = 6,
				},
			},
			[100]= {
				["state"]= {
				},
			},
			[1008]= {
				["targetArea"] = 3,
				["targetChoose"] = 14,
				["boxId"] = 1301331,
				["state"]= {
				},
			},
		},

	},
	[1301330] = {
		["bhEvent"] = "skill.1301330",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {130130013,130131003,},
				},
			},
			[0]= {
				["unitDelay"] = 0.15,
				["flyCueId"] = 130130014,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1301329,
				["state"]= {
					["stateId"] = 1400001,
					["duration"] = 2,
				},
				["subEventSkill"] = 1301330,
				["subEventId"] = 1001,
			},
			[1]= {
				["unitDelay"] = 0.1,
				["flyCueId"] = 130130014,
				["baseToTarget"] = 1,
				["state"]= {
				},
			},
			[1001]= {
				["targetChoose"] = 7,
				["unitDelay"] = 0.1,
				["flyCueId"] = 130130014,
				["baseToTarget"] = 1,
				["boxType"] = 1,
				["state"]= {
					["stateId"] = 1301302,
					["duration"] = -999,
				},
				["hitCue"]= {
					["cueList"] = {130130015,},
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
