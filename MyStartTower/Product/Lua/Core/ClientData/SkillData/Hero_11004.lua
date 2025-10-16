local Data = {
["cueFile"] = "10001",
	[1100401] = {
		["bhEvent"] = "skill.1100401",
		["atkEvents"]= {
			[0]= {
				["eventType"] = 1,
				["boxId"] = 1100409,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000062,},
				},
			},
			[99]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {100011004,},
				},
			},
		},

	},
	[1100402] = {
		["bhEvent"] = "skill.1100402",
		["atkEvents"]= {
			[0]= {
				["eventType"] = 1,
				["boxId"] = 1100409,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000062,},
				},
			},
			[99]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {100011005,},
				},
			},
		},

	},
	[1100421] = {
		["bhEvent"] = "skill.1100421",
		["atkEvents"]= {
			[1]= {
				["targetArea"] = 1,
				["targetChoose"] = 7,
				["boxId"] = 1100429,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {100011003,},
				},
				["hitCue"]= {
					["cueList"] = {10000025,},
				},
				["levelAtkEvents"]= {
					[2]= {
						["state"]= {
							["stateId"] = 1100403,
							["duration"] = 10,
						},
					},
					[3]= {
						["state"]= {
							["stateId"] = 1100403,
							["duration"] = 15,
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
			[2]= {
				["state"]= {
				},
			},
		},

		["skillTarget"] = 1,
	},
	[1100451] = {
		["bhEvent"] = "skill.1100451",
		["atkEvents"]= {
			[1]= {
				["targetArea"] = 2,
				["targetChoose"] = 3,
				["eventType"] = 1,
				["boxId"] = 1100451,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {100010004,},
				},
				["hitedAnim"] = "Hit",
			},
			[10]= {
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {100010003,},
				},
			},
			[2]= {
				["eventType"] = 1,
				["boxId"] = 1100452,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {100010003,},
				},
				["hitedAnim"] = "Hit",
			},
			[11]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {100015001,100010005,100011001,},
				},
			},
			[13]= {
				["targetChoose"] = 3,
				["state"]= {
				},
				["hitedAnim"] = "end",
			},
		},

		["actTime"] = 110,
		["prepareCamera"] = 1,
		["prepareCamDruation"] = 20,
	},
	[1100452] = {
		["bhEvent"] = "skill.1100452",
		["atkEvents"]= {
			[10]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {10000012,10001001,100011001,},
				},
			},
			[2]= {
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {100010003,10006003,},
				},
			},
			[1]= {
				["eventType"] = 1,
				["boxId"] = 1100452,
				["state"]= {
				},
				["levelAtkEvents"]= {
					[2]= {
						["state"]= {
							["stateId"] = 1000006,
							["duration"] = 5,
						},
					},
					[3]= {
						["state"]= {
							["stateId"] = 1000006,
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
			[3]= {
				["state"]= {
					["stateId"] = 1100402,
					["duration"] = 10,
				},
			},
		},

		["actTime"] = 51,
	},
	[1100422] = {
		["bhEvent"] = "skill.1100422",
		["atkEvents"]= {
			[1]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1110101,
					["duration"] = 10,
				},
				["hitCue"]= {
					["cueList"] = {10000008,100011003,},
				},
				["levelAtkEvents"]= {
					[2]= {
					},
					[3]= {
						["state"]= {
							["stateId"] = 1110101,
							["duration"] = 15,
						},
					},
					[4]= {
						["state"]= {
							["stateId"] = 1110101,
							["duration"] = 15,
						},
					},
					[5]= {
					},
					[6]= {
					},
				},

			},
			[2]= {
				["state"]= {
				},
				["levelAtkEvents"]= {
					[2]= {
						["state"]= {
							["stateOperation"] = 1,
							["chooseStateType"] = 2,
							["chooseStateMode"] = 1,
						},
					},
					[3]= {
						["state"]= {
							["stateOperation"] = 1,
							["chooseStateType"] = 2,
							["chooseStateMode"] = 1,
						},
					},
					[4]= {
						["state"]= {
							["stateOperation"] = 1,
							["chooseStateType"] = 2,
							["chooseStateMode"] = 1,
						},
					},
					[5]= {
					},
					[6]= {
					},
				},

			},
		},

		["skillTarget"] = 1,
	},
	[1100453] = {
		["bhEvent"] = "skill.1100453",
		["atkEvents"]= {
			[10]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {10002001,100019001,100011001,10001001,},
				},
			},
			[2]= {
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {100010007,},
				},
			},
			[3]= {
				["state"]= {
				},
			},
			[1]= {
				["boxId"] = 1110160,
				["state"]= {
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
