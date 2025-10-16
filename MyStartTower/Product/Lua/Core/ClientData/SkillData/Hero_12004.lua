local Data = {
["cueFile"] = "12004",
	[1200401] = {
		["bhEvent"] = "skill.1200401",
		["atkEvents"]= {
			[0]= {
				["eventType"] = 1,
				["boxId"] = 1200409,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {120040003,},
				},
			},
			[100]= {
				["state"]= {
				},
			},
			[1]= {
				["targetArea"] = 3,
				["state"]= {
					["stateOperation"] = 1,
					["stateId"] = 1200404,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {1200404,},
				},
			},
		},

	},
	[1200402] = {
		["bhEvent"] = "skill.1200402",
		["atkEvents"]= {
			[0]= {
				["eventType"] = 1,
				["boxId"] = 1200409,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {120040003,},
				},
			},
			[100]= {
				["state"]= {
				},
			},
			[1]= {
				["targetArea"] = 3,
				["state"]= {
					["stateOperation"] = 1,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {1200404,},
				},
			},
		},

	},
	[1200421] = {
		["bhEvent"] = "skill.1200421",
		["atkEvents"]= {
			[100]= {
				["targetArea"] = 2,
				["targetChoose"] = 7,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {120040004,},
				},
			},
			[1]= {
				["targetChoose"] = 7,
				["eventType"] = 1,
				["boxId"] = 1200429,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {120040006,},
				},
				["levelAtkEvents"]= {
					[2]= {
						["state"]= {
							["stateId"] = 1200402,
							["duration"] = 8,
						},
					},
					[3]= {
						["state"]= {
							["stateId"] = 1200402,
							["duration"] = 8,
						},
					},
					[4]= {
						["state"]= {
							["stateId"] = 1200402,
							["duration"] = 8,
						},
					},
					[5]= {
					},
					[6]= {
					},
				},

			},
			[0]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {120040005,},
				},
			},
		},

		["actTime"] = 57,
		["skillTarget"] = 1,
	},
	[1200451] = {
		["bhEvent"] = "skill.1200451",
		["atkEvents"]= {
			[100]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1200401,
					["duration"] = 10,
				},
			},
			[101]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["levelAtkEvents"]= {
					[2]= {
						["state"]= {
							["stateId"] = 1200403,
							["duration"] = 2,
						},
					},
					[3]= {
						["state"]= {
							["stateId"] = 1200403,
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
			[1001]= {
				["eventType"] = 1,
				["boxId"] = 1200469,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {120040011,},
				},
				["disablePassive"] = 1,
			},
			[99]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {120040016,120040017,120040018,},
				},
			},
			[13]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {120040014,120045001,},
				},
			},
			[1002]= {
				["targetArea"] = 2,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {120040015,},
				},
			},
			[45]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {120041001,},
				},
			},
		},

		["actTime"] = 76,
		["hideEffect"] = 1,
		["videoActTime"] = 31,
		["videoActCue"]= {
			["cueList"] = {120048002,120041003,},
		},
		["hideTime"] = 10,
		["prepareCamera"] = 1,
		["prepareCamDruation"] = 50,
		["skillTarget"] = 1,
	},
	[1200403] = {
		["bhEvent"] = "skill.1200403",
		["atkEvents"]= {
			[100]= {
				["targetArea"] = 3,
				["unitDelay"] = 0.12,
				["flyCueId"] = 120040009,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {120041002,},
				},
			},
			[0]= {
				["unitDelay"] = 0.12,
				["flyCueId"] = 120040009,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1200459,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {120040010,},
				},
			},
			[1]= {
				["targetChoose"] = 7,
				["unitDelay"] = 0.12,
				["flyCueId"] = 120040009,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1200460,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {120040010,},
				},
				["disablePassive"] = 1,
				["randomTargetNumber"] = 1,
				["excludeTarget"] = 1,
				["levelAtkEvents"]= {
					[2]= {
					},
					[3]= {
						["randomTargetNumber"] = 2,
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
				["targetArea"] = 3,
				["state"]= {
					["stateOperation"] = 1,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {1200404,},
				},
			},
		},

	},
	[1200452] = {
		["bhEvent"] = "skill.1200452",
		["atkEvents"]= {
			[100]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 9900008,
					["duration"] = 90,
				},
				["baseCue"]= {
					["cueList"] = {120040012,},
				},
			},
			[101]= {
				["state"]= {
				},
				["addManaNumber"] = 75,
			},
			[1001]= {
				["targetChoose"] = 10,
				["boxId"] = 1200469,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {120040011,},
				},
			},
		},

		["actTime"] = 40,
		["videoActTime"] = 120,
		["shortVideoActTime"] = 60,
		["videoActCue"]= {
			["cueList"] = {120048001,120041001,},
		},
		["shortVideoActCue"]= {
			["cueList"] = {120048002,120041003,},
		},
		["hideTime"] = 10,
		["prepareCamera"] = 1,
		["prepareCamDruation"] = 30,
		["skillTarget"] = 1,
	},
	[1200453] = {
		["bhEvent"] = "skill.1200453",
		["atkEvents"]= {
			[100]= {
				["targetArea"] = 2,
				["state"]= {
				},
			},
			[0]= {
				["targetArea"] = 2,
				["targetChoose"] = 7,
				["boxId"] = 1200470,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {120041002,},
				},
			},
			[99]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {120040013,},
				},
			},
		},

		["actTime"] = 70,
		["skillTarget"] = 1,
	},
	[1200411] = {
		["bhEvent"] = "skill.1200411",
		["atkEvents"]= {
			[100]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {120041002,},
				},
			},
			[0]= {
				["unitDelay"] = 0.12,
				["flyCueId"] = 120040009,
				["boxType"] = 1,
				["boxId"] = 1200471,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {120040010,},
				},
			},
			[1]= {
				["targetChoose"] = 4,
				["state"]= {
				},
				["excludeTarget"] = 1,
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
