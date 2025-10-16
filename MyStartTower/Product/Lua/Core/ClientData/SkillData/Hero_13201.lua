local Data = {
["cueFile"] = "13201",
	[1320109] = {
		["bhEvent"] = "skill.1320109",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {132010001,132011001,},
				},
			},
			[1]= {
				["unitDelay"] = 0.12,
				["flyCueId"] = 132010002,
				["boxType"] = 1,
				["boxId"] = 1320109,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {132010005,132011002,},
				},
			},
		},

	},
	[1320110] = {
		["bhEvent"] = "skill.1320110",
		["atkEvents"]= {
			[100]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {132010003,132011003,},
				},
			},
			[1]= {
				["unitDelay"] = 0.12,
				["flyCueId"] = 132010004,
				["boxType"] = 1,
				["boxId"] = 1320109,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {132010005,132011004,},
				},
			},
		},

	},
	[1320129] = {
		["bhEvent"] = "skill.1320129",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {132010008,132011005,},
				},
			},
			[1]= {
				["delay"] = 0.15,
				["boxType"] = 1,
				["state"]= {
					["stateId"] = 1320101,
					["duration"] = 3,
				},
				["hitCue"]= {
					["cueList"] = {132010009,132011006,},
				},
				["controlTime"] = 8,
				["controlAniName"] = "timelock",
				["levelAtkEvents"]= {
					[2]= {
					},
					[3]= {
						["state"]= {
							["stateId"] = 1320101,
							["duration"] = 8,
						},
						["controlTime"] = 10,
					},
					[4]= {
						["state"]= {
							["stateId"] = 1320101,
							["duration"] = 6,
						},
						["controlTime"] = 6,
					},
					[5]= {
						["state"]= {
							["stateId"] = 1320101,
							["duration"] = 6,
						},
						["controlTime"] = 6,
					},
					[6]= {
						["state"]= {
							["stateId"] = 1320101,
							["duration"] = 6,
						},
						["controlTime"] = 6,
					},
				},

			},
			[1001]= {
				["delay"] = 0.5,
				["boxType"] = 1,
				["state"]= {
					["stateId"] = 1320101,
					["duration"] = 4,
				},
				["controlTime"] = 6,
				["controlAniName"] = "timelock",
				["levelAtkEvents"]= {
					[2]= {
					},
					[3]= {
						["state"]= {
							["stateId"] = 1320101,
							["duration"] = 6,
						},
						["controlTime"] = 8,
					},
					[4]= {
						["controlTime"] = 4,
					},
					[5]= {
						["controlTime"] = 4,
					},
					[6]= {
						["controlTime"] = 4,
					},
				},

			},
			[1003]= {
				["boxId"] = 1320130,
				["state"]= {
				},
			},
			[1004]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["addManaNumber"] = 6,
				["levelAtkEvents"]= {
					[2]= {
						["addManaNumber"] = 8,
					},
					[3]= {
						["addManaNumber"] = 10,
					},
					[4]= {
					},
					[5]= {
					},
					[6]= {
					},
				},

			},
			[2]= {
				["targetChoose"] = 20,
				["delay"] = 0.15,
				["boxType"] = 1,
				["state"]= {
					["stateId"] = 1320101,
					["duration"] = 3,
				},
				["hitCue"]= {
					["cueList"] = {132010009,132011006,},
				},
				["controlTime"] = 8,
				["controlAniName"] = "timelock",
				["randomTargetNumber"] = 1,
				["excludeTarget"] = 1,
				["subEventSkill"] = 1320129,
				["subEventId"] = 1005,
				["eventCondition"] = "1,1,1320111",
				["levelAtkEvents"]= {
					[2]= {
					},
					[3]= {
						["state"]= {
							["stateId"] = 1320101,
							["duration"] = 8,
						},
						["controlTime"] = 10,
					},
					[4]= {
					},
					[5]= {
					},
					[6]= {
					},
				},

			},
			[1005]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1320102,
					["duration"] = 0.1,
				},
			},
		},

		["skillTarget"] = 2,
	},
	[1320159] = {
		["bhEvent"] = "skill.1320159",
		["atkEvents"]= {
			[100]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {132010011,},
				},
				["levelAtkEvents"]= {
					[2]= {
					},
					[3]= {
						["state"]= {
							["stateId"] = 1320105,
							["duration"] = 2,
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
			[1]= {
				["state"]= {
					["stateId"] = 1320106,
					["duration"] = 1,
				},
				["hitCue"]= {
					["cueList"] = {132010013,132010012,132010015,},
				},
			},
			[1001]= {
				["targetArea"] = 3,
				["state"]= {
					["stateOperation"] = 1,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {1320103,},
				},
			},
			[0]= {
				["targetChoose"] = 7,
				["boxId"] = 1320159,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10006003,},
				},
				["hitedAnim"] = "Hit",
			},
			[13]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {132015001,132010014,132011008,},
				},
			},
			[99]= {
				["targetChoose"] = 7,
				["state"]= {
					["stateOperation"] = 1,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {1320106,},
				},
				["hitedAnim"] = "end",
			},
			[1002]= {
				["state"]= {
					["stateOperation"] = 2,
					["duration"] = 2,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {1320101,},
				},
			},
			[3]= {
				["targetChoose"] = 7,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {132010012,132010013,132010015,},
				},
				["eventCondition"] = "1,3,1320106,1",
			},
			[2]= {
				["targetChoose"] = 7,
				["state"]= {
					["stateId"] = 1320106,
					["duration"] = 1,
				},
				["hitCue"]= {
					["cueList"] = {132010012,132010013,132010015,},
				},
				["randomTargetNumber"] = 2,
				["excludeTarget"] = 1,
			},
		},

		["actTime"] = 85,
		["hideEffect"] = 1,
		["videoActTime"] = 70,
		["videoActCue"]= {
			["cueList"] = {132018001,132011007,},
		},
		["hideTime"] = 10,
		["prepareCamera"] = 1,
		["prepareCamDruation"] = 30,
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
