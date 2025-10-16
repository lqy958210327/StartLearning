local Data = {
["cueFile"] = "14201",
	[1420109] = {
		["bhEvent"] = "skill.1420109",
		["atkEvents"]= {
			[1]= {
				["unitDelay"] = 0.15,
				["flyCueId"] = 142010003,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1420109,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {142010005,142011002,},
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {142010001,142011001,},
				},
			},
		},

	},
	[1420129] = {
		["bhEvent"] = "skill.1420129",
		["atkEvents"]= {
			[1]= {
				["targetArea"] = 3,
				["targetChoose"] = 4,
				["unitDelay"] = 0.2,
				["flyCueId"] = 142010011,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1420130,
				["state"]= {
					["stateId"] = 1420101,
					["duration"] = 8,
				},
				["hitCue"]= {
					["cueList"] = {142010012,142011008,},
				},
				["randomTargetNumber"] = 1,
				["randomRule"] = 3,
				["excludeTarget"] = 1,
				["levelAtkEvents"]= {
					[2]= {
						["state"]= {
							["stateId"] = 1420101,
							["duration"] = 10,
						},
					},
					[3]= {
						["state"]= {
							["stateId"] = 1420101,
							["duration"] = 15,
						},
					},
					[4]= {
						["state"]= {
							["stateId"] = 1420101,
							["duration"] = 12,
						},
					},
					[5]= {
						["state"]= {
							["stateId"] = 1420101,
							["duration"] = 12,
						},
					},
					[6]= {
						["state"]= {
							["stateId"] = 1420101,
							["duration"] = 12,
						},
					},
				},

			},
			[1001]= {
				["targetArea"] = 3,
				["targetChoose"] = 7,
				["boxId"] = 1420129,
				["state"]= {
				},
				["eventCondition"] = "1,3,1420101",
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {142010010,142011007,},
				},
			},
			[1002]= {
				["boxId"] = 1420131,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000008,},
				},
			},
			[1003]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["levelAtkEvents"]= {
					[2]= {
					},
					[3]= {
						["boxId"] = 1420160,
					},
					[4]= {
					},
					[5]= {
					},
					[6]= {
					},
				},

			},
			[1004]= {
				["targetArea"] = 3,
				["targetChoose"] = 7,
				["boxId"] = 1420160,
				["state"]= {
				},
				["eventCondition"] = "1,3,1420101",
			},
			[1005]= {
				["targetArea"] = 3,
				["targetChoose"] = 4,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000035,},
				},
				["addManaNumber"] = 25,
				["excludeTarget"] = 1,
			},
		},

		["skillTarget"] = 1,
	},
	[1420159] = {
		["bhEvent"] = "skill.1420159",
		["atkEvents"]= {
			[5]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1420102,
					["duration"] = 3,
				},
			},
			[1]= {
				["targetChoose"] = 4,
				["eventType"] = 1,
				["boxId"] = 1420159,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {142010015,10006003,},
				},
				["hitedAnim"] = "Hit",
			},
			[1001]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["levelAtkEvents"]= {
					[2]= {
					},
					[3]= {
						["boxId"] = 1420160,
					},
					[4]= {
					},
					[5]= {
					},
					[6]= {
					},
				},

			},
			[1002]= {
				["targetArea"] = 1,
				["targetChoose"] = 7,
				["boxId"] = 1420160,
				["state"]= {
				},
				["eventCondition"] = "1,3,1420101",
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {142010014,},
				},
			},
			[13]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {142010016,142015001,142011010,},
				},
			},
			[99]= {
				["targetChoose"] = 4,
				["state"]= {
				},
				["hitedAnim"] = "end",
			},
			[2]= {
				["targetArea"] = 1,
				["targetChoose"] = 7,
				["state"]= {
				},
				["eventCondition"] = "1,3,1420101",
				["levelAtkEvents"]= {
					[2]= {
						["addManaNumber"] = 30,
					},
					[3]= {
						["addManaNumber"] = 30,
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
		["videoActTime"] = 70,
		["videoActCue"]= {
			["cueList"] = {142018001,142011009,},
		},
		["hideEvent"] = 10,
		["prepareCamera"] = 1,
		["prepareCamDruation"] = 25,
	},
	[1420110] = {
		["bhEvent"] = "skill.1420110",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {142010002,142011003,},
				},
			},
			[1]= {
				["unitDelay"] = 0.15,
				["flyCueId"] = 142010004,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1420109,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {142010005,142011004,},
				},
			},
		},

	},
	[1420111] = {
		["bhEvent"] = "skill.1420111",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {142010006,142011005,},
				},
			},
			[1]= {
				["unitDelay"] = 0.15,
				["flyCueId"] = 142010007,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1420109,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {142010009,142011008,},
				},
			},
			[2]= {
				["targetChoose"] = 7,
				["unitDelay"] = 0.15,
				["flyCueId"] = 142010008,
				["boxType"] = 1,
				["boxId"] = 1420110,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {142010009,},
				},
				["disablePassive"] = 1,
				["randomTargetNumber"] = 1,
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
