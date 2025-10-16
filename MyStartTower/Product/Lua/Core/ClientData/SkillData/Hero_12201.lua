local Data = {
["cueFile"] = "12201",
	[1220109] = {
		["bhEvent"] = "skill.1220109",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {122010001,122011001,},
				},
			},
			[99]= {
				["targetArea"] = 3,
				["state"]= {
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {1220101,},
				},
			},
			[1]= {
				["eventType"] = 1,
				["boxId"] = 1220109,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000062,},
				},
			},
		},

	},
	[1220159] = {
		["bhEvent"] = "skill.1220159",
		["atkEvents"]= {
			[1]= {
				["eventType"] = 1,
				["boxId"] = 1220159,
				["state"]= {
				},
			},
			[100]= {
				["targetArea"] = 2,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {122010007,},
				},
			},
			[27]= {
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {122010009,122010010,},
				},
				["levelAtkEvents"]= {
					[2]= {
						["hitCue"]= {
							["cueList"] = {122010014,122010015,},
						},
					},
					[3]= {
						["hitCue"]= {
							["cueList"] = {122010014,122010015,},
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
			[23]= {
				["state"]= {
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {0,},
				},
				["hitedAnim"] = "end",
			},
			[13]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {122015001,122010012,122011006,},
				},
			},
			[2]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {122013001,},
				},
				["hitCue"]= {
					["cueList"] = {10006003,},
				},
				["hitedAnim"] = "Hit",
			},
			[1002]= {
				["targetArea"] = 2,
				["delay"] = 0.5,
				["boxType"] = 1,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {122010011,},
				},
			},
			[3]= {
				["targetArea"] = 3,
				["boxId"] = 1220161,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {122010008,122013002,},
				},
			},
			[1003]= {
				["targetChoose"] = 3,
				["eventType"] = 1,
				["boxId"] = 1220160,
				["state"]= {
				},
				["baseCue"]= {
					["cueList"] = {122010013,},
				},
				["disablePassive"] = 1,
			},
			[1004]= {
				["state"]= {
				},
				["stunTime"] = 1,
			},
			[4]= {
				["state"]= {
				},
				["levelAtkEvents"]= {
					[2]= {
						["eventType"] = 1,
						["boxId"] = 1220159,
					},
					[3]= {
						["eventType"] = 1,
						["boxId"] = 1220159,
					},
					[4]= {
					},
					[5]= {
					},
					[6]= {
					},
				},

			},
			[5]= {
				["state"]= {
				},
			},
		},

		["actTime"] = 95,
		["hideEffect"] = 1,
		["videoActTime"] = 60,
		["videoActCue"]= {
			["cueList"] = {122018001,122011005,},
		},
		["hideTime"] = 10,
		["hideEvent"] = 1003,
		["prepareCamera"] = 1,
		["prepareCamDruation"] = 20,
	},
	[1220129] = {
		["bhEvent"] = "skill.1220129",
		["atkEvents"]= {
			[100]= {
				["targetArea"] = 2,
				["state"]= {
					["stateOperation"] = 1,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {1220105,},
				},
				["atkCue"]= {
					["cueList"] = {122010005,122011004,10005003,},
				},
			},
			[1]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1220102,
					["duration"] = 5.5,
				},
			},
			[1001]= {
				["targetArea"] = 3,
				["state"]= {
					["stateOperation"] = 1,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {1220101,},
				},
			},
			[1002]= {
				["targetArea"] = 3,
				["eventType"] = 1,
				["boxId"] = 1220130,
				["state"]= {
				},
			},
			[1003]= {
				["eventType"] = 1,
				["boxId"] = 1220131,
				["state"]= {
				},
			},
			[1004]= {
				["targetArea"] = 3,
				["state"]= {
					["stateOperation"] = 2,
					["duration"] = 2,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {1220102,},
				},
			},
			[1005]= {
				["targetChoose"] = 3,
				["eventType"] = 1,
				["boxId"] = 1220160,
				["state"]= {
				},
				["baseCue"]= {
					["cueList"] = {122010013,},
				},
				["disablePassive"] = 1,
			},
		},

		["actTime"] = 40,
		["skillTarget"] = 1,
	},
	[1220110] = {
		["bhEvent"] = "skill.1220110",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {122010002,122011002,},
				},
			},
			[1]= {
				["eventType"] = 1,
				["boxId"] = 1220109,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000062,},
				},
			},
			[99]= {
				["targetArea"] = 2,
				["state"]= {
				},
			},
		},

	},
	[1220111] = {
		["bhEvent"] = "skill.1220111",
	},
	[1220112] = {
		["bhEvent"] = "skill.1220112",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {122010003,122011003,},
				},
			},
			[1]= {
				["eventType"] = 1,
				["boxId"] = 1220109,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000062,},
				},
			},
			[99]= {
				["targetArea"] = 2,
				["state"]= {
				},
			},
		},

	},
	[1220130] = {
		["bhEvent"] = "skill.1220130",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {122010005,},
				},
			},
			[1]= {
				["state"]= {
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
