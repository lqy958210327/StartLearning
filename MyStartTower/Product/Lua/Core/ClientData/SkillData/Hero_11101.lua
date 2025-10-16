local Data = {
["cueFile"] = "11101",
	[1110109] = {
		["bhEvent"] = "skill.1110109",
		["atkEvents"]= {
			[1]= {
				["eventType"] = 1,
				["boxId"] = 1110109,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {111010002,},
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {111010001,},
				},
			},
		},

	},
	[1110110] = {
		["bhEvent"] = "skill.1110110",
		["atkEvents"]= {
			[1]= {
				["eventType"] = 1,
				["boxId"] = 1110109,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {111010002,},
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {111010003,},
				},
			},
		},

	},
	[1110129] = {
		["bhEvent"] = "skill.1110129",
		["atkEvents"]= {
			[0]= {
				["targetArea"] = 3,
				["state"]= {
				},
			},
			[1001]= {
				["targetArea"] = 2,
				["targetChoose"] = 3,
				["eventType"] = 1,
				["boxId"] = 1110129,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {111010010,111011006,},
				},
				["hitCue"]= {
					["cueList"] = {111010011,},
				},
				["randomTargetNumber"] = 1,
			},
			[100]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1110104,
					["duration"] = 3,
				},
				["levelAtkEvents"]= {
					[2]= {
					},
					[3]= {
						["state"]= {
							["stateId"] = 1110104,
							["duration"] = 4,
						},
					},
					[4]= {
						["state"]= {
							["stateId"] = 1110104,
							["duration"] = 4,
						},
					},
					[5]= {
					},
					[6]= {
					},
				},

			},
			[1002]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1110104,
					["duration"] = 3,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {1110104,},
				},
				["levelAtkEvents"]= {
					[2]= {
					},
					[3]= {
						["state"]= {
							["stateId"] = 1110104,
							["duration"] = 4,
							["chooseStateMode"] = 2,
							["chooseStateIds"] = {1110104,},
						},
					},
					[4]= {
						["state"]= {
							["stateId"] = 1110104,
							["duration"] = 4,
							["chooseStateMode"] = 2,
							["chooseStateIds"] = {1110104,},
						},
					},
					[5]= {
					},
					[6]= {
					},
				},

			},
			[1003]= {
				["state"]= {
				},
			},
		},

		["skillTarget"] = 1,
	},
	[1110159] = {
		["bhEvent"] = "skill.1110159",
		["atkEvents"]= {
			[2]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1110101,
					["duration"] = 8,
				},
				["levelAtkEvents"]= {
					[2]= {
						["targetChoose"] = 4,
					},
					[3]= {
						["targetChoose"] = 4,
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
				["eventType"] = 1,
				["boxId"] = 1110159,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {111013001,},
				},
				["hitCue"]= {
					["cueList"] = {111010007,111011005,10006003,},
				},
				["hitedAnim"] = "Hit",
			},
			[3]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["levelAtkEvents"]= {
					[2]= {
					},
					[3]= {
						["state"]= {
							["stateId"] = 1110102,
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
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {111010006,},
				},
			},
			[13]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {111015001,111010008,111011004,},
				},
			},
			[90]= {
				["state"]= {
				},
				["hitedAnim"] = "end",
			},
		},

		["actTime"] = 69,
		["hideEffect"] = 1,
		["videoActTime"] = 71,
		["videoActCue"]= {
			["cueList"] = {111018001,111011003,},
		},
		["hideTime"] = 10,
		["hideEvent"] = 100,
		["prepareCamera"] = 1,
		["prepareCamDruation"] = 37,
	},
	[1110160] = {
		["bhEvent"] = "skill.1110160",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {111010006,},
				},
			},
			[13]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {111010008,111015001,111011004,},
				},
			},
			[2]= {
				["state"]= {
				},
			},
			[1]= {
				["boxId"] = 1110159,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {111013001,},
				},
				["hitCue"]= {
					["cueList"] = {111010007,111011005,},
				},
				["hitedAnim"] = "Hit",
			},
			[3]= {
				["state"]= {
				},
			},
			[90]= {
				["state"]= {
				},
			},
		},

		["actTime"] = 78,
		["hideEffect"] = 1,
		["videoActTime"] = 71,
		["shortVideoActTime"] = 70,
		["videoActCue"]= {
			["cueList"] = {111018001,111011003,},
		},
		["shortVideoActCue"]= {
			["cueList"] = {111018001,111011003,},
		},
		["prepareCamera"] = 1,
		["prepareCamDruation"] = 105,
	},
	[1110191] = {
		["bhEvent"] = "skill.1110191",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {111010006,},
				},
			},
			[1]= {
				["boxId"] = 1110159,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {111010007,111011005,},
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
