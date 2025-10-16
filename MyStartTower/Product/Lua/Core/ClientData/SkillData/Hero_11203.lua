local Data = {
["cueFile"] = "11203",
	[1120302] = {
		["bhEvent"] = "skill.1120302",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {112030004,112030005,112031003,},
				},
			},
			[1]= {
				["eventType"] = 1,
				["boxId"] = 1120321,
				["state"]= {
				},
				["levelAtkEvents"]= {
					[2]= {
						["controlTime"] = 2,
						["controlAniName"] = "Float",
					},
					[3]= {
						["controlTime"] = 2,
						["controlAniName"] = "Float",
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

	},
	[1120311] = {
		["bhEvent"] = "skill.1120311",
		["atkEvents"]= {
			[100]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {112030006,},
				},
			},
			[1001]= {
				["targetArea"] = 3,
				["boxId"] = 1120330,
				["state"]= {
					["stateOperation"] = 4,
					["stateId"] = 1120301,
					["delLayer"] = 1,
				},
			},
			[1002]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1120302,
					["duration"] = 5,
				},
			},
			[1003]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1120301,
					["duration"] = -999,
					["delLayer"] = 1,
				},
			},
			[2]= {
				["targetArea"] = 3,
				["state"]= {
					["stateOperation"] = 1,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {1120301,1120303,1120304,1120306,1120308,},
				},
			},
			[3]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1120322,
					["duration"] = -999,
				},
			},
			[1]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1120321,
					["duration"] = -999,
				},
			},
			[1004]= {
				["targetArea"] = 4,
				["state"]= {
					["stateOperation"] = 4,
					["stateId"] = 1120305,
					["delLayer"] = 1,
				},
			},
			[1005]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1120305,
					["duration"] = -999,
				},
			},
			[5]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1120307,
					["duration"] = -999,
				},
			},
			[6]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {112036001,},
				},
				["levelAtkEvents"]= {
					[2]= {
					},
					[3]= {
						["state"]= {
							["stateId"] = 1120312,
							["duration"] = 8,
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
			[1006]= {
				["targetArea"] = 3,
				["boxId"] = 1120331,
				["state"]= {
				},
			},
		},

		["actTime"] = 43,
		["skillTarget"] = 1,
	},
	[1120309] = {
		["bhEvent"] = "skill.1120309",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {112030003,112031002,},
				},
			},
			[1]= {
				["eventType"] = 1,
				["boxId"] = 1120309,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000062,},
				},
			},
		},

	},
	[1120310] = {
		["bhEvent"] = "skill.1120310",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {112030001,112030002,112031001,},
				},
			},
			[1]= {
				["eventType"] = 1,
				["boxId"] = 1120309,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000062,},
				},
			},
		},

	},
	[1120359] = {
		["bhEvent"] = "skill.1120359",
		["atkEvents"]= {
			[1]= {
				["targetChoose"] = 4,
				["eventType"] = 1,
				["boxId"] = 1120359,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {112030013,},
				},
				["hitedAnim"] = "Hit",
			},
			[2]= {
				["targetArea"] = 3,
				["boxId"] = 1120356,
				["state"]= {
				},
			},
			[99]= {
				["state"]= {
				},
				["hitedAnim"] = "end",
			},
			[3]= {
				["targetArea"] = 3,
				["targetChoose"] = 4,
				["state"]= {
				},
				["levelAtkEvents"]= {
					[2]= {
					},
					[3]= {
						["boxId"] = 1120357,
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
				["state"]= {
				},
				["addManaNumber"] = 30,
			},
			[13]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {112030015,112035002,112031007,},
				},
			},
			[100]= {
				["targetChoose"] = 4,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {112030011,112030012,},
				},
			},
			[4]= {
				["targetArea"] = 3,
				["boxId"] = 1120358,
				["state"]= {
				},
			},
		},

		["actTime"] = 65,
		["videoActTime"] = 60,
		["videoActCue"]= {
			["cueList"] = {112038001,112031004,},
		},
		["hideTime"] = 10,
		["hideEvent"] = 100,
		["prepareCamera"] = 1,
		["prepareCamDruation"] = 40,
	},
	[1120360] = {
		["bhEvent"] = "skill.1120360",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {112030008,112030009,},
				},
			},
			[1]= {
				["eventType"] = 1,
				["boxId"] = 1120360,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {112030010,},
				},
				["hitedAnim"] = "Hit",
			},
			[1001]= {
				["targetArea"] = 3,
				["boxId"] = 1120362,
				["state"]= {
					["chooseStateMode"] = 2,
				},
			},
			[13]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {112030014,112035001,112031005,},
				},
			},
			[99]= {
				["state"]= {
				},
				["hitedAnim"] = "end",
			},
			[3]= {
				["eventType"] = 1,
				["boxId"] = 1120360,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {112030010,112031006,},
				},
			},
			[2]= {
				["targetArea"] = 3,
				["boxId"] = 1120361,
				["state"]= {
					["stateId"] = 1120311,
					["duration"] = 3,
				},
			},
		},

		["actTime"] = 65,
		["hideEffect"] = 1,
		["videoActTime"] = 60,
		["videoActCue"]= {
			["cueList"] = {112038001,112031004,},
		},
		["hideTime"] = 10,
		["hideEvent"] = 100,
		["prepareCamera"] = 1,
		["prepareCamDruation"] = 50,
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
