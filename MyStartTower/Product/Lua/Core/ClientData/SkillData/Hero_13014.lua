local Data = {
["cueFile"] = "13014",
	[1301409] = {
		["bhEvent"] = "skill.1301409",
		["atkEvents"]= {
			[1]= {
				["unitDelay"] = 0.15,
				["flyCueId"] = 130140002,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1301409,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {130140003,},
				},
			},
			[1001]= {
				["eventType"] = 1,
				["boxId"] = 1301410,
				["state"]= {
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {130140001,130141001,},
				},
			},
		},

	},
	[1301410] = {
		["bhEvent"] = "skill.1301410",
		["atkEvents"]= {
			[1]= {
				["unitDelay"] = 0.15,
				["flyCueId"] = 130140005,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1301409,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {130140003,},
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {130140004,130141001,},
				},
			},
		},

	},
	[1301459] = {
		["bhEvent"] = "skill.1301459",
		["atkEvents"]= {
			[1001]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1301407,
					["duration"] = 5,
				},
				["levelAtkEvents"]= {
					[2]= {
					},
					[3]= {
						["state"]= {
							["stateId"] = 1301407,
							["duration"] = 7,
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
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1301459,
				["state"]= {
					["stateId"] = 1000001,
					["duration"] = 5,
				},
				["hitedAnim"] = "Hit",
				["subEventSkill"] = 1301459,
				["subEventId"] = 1001,
				["levelAtkEvents"]= {
					[2]= {
					},
					[3]= {
						["state"]= {
							["stateId"] = 1000001,
							["duration"] = 7,
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
			[1002]= {
				["targetArea"] = 3,
				["state"]= {
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {1301408,},
				},
				["levelAtkEvents"]= {
					[2]= {
						["state"]= {
							["stateOperation"] = 1,
							["chooseStateMode"] = 2,
							["chooseStateIds"] = {1301408,},
						},
					},
					[3]= {
						["state"]= {
							["stateOperation"] = 1,
							["chooseStateMode"] = 2,
							["chooseStateIds"] = {1301408,},
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
			[1003]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["levelAtkEvents"]= {
					[2]= {
						["state"]= {
							["stateOperation"] = 1,
							["chooseStateMode"] = 2,
							["chooseStateIds"] = {1301409,},
						},
					},
					[3]= {
						["state"]= {
							["stateOperation"] = 1,
							["chooseStateMode"] = 2,
							["chooseStateIds"] = {1301409,},
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
					["cueList"] = {130140009,130140010,},
				},
			},
			[35]= {
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {130140012,},
				},
			},
			[13]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {130140013,130145001,130141004,},
				},
			},
			[15]= {
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {130140011,},
				},
			},
			[90]= {
				["state"]= {
				},
				["hitedAnim"] = "end",
			},
		},

		["actTime"] = 75,
		["hideEffect"] = 1,
		["videoActTime"] = 70,
		["videoActCue"]= {
			["cueList"] = {130148001,130141003,},
		},
		["hideTime"] = 10,
		["hideEvent"] = 100,
		["prepareCamera"] = 1,
		["prepareCamDruation"] = 25,
	},
	[1301429] = {
		["bhEvent"] = "skill.1301429",
		["atkEvents"]= {
			[1001]= {
				["targetChoose"] = 23,
				["unitDelay"] = 0.3,
				["flyCueId"] = 130140007,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1301429,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {130140008,},
				},
			},
			[1002]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["addManaNumber"] = 30,
			},
			[1003]= {
				["targetChoose"] = 23,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {130140006,130141002,},
				},
				["subEventSkill"] = 1301429,
				["subEventId"] = 1001,
			},
			[1004]= {
				["targetArea"] = 1,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000035,},
				},
				["addManaNumber"] = 20,
			},
			[1005]= {
				["state"]= {
				},
			},
			[1006]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000035,},
				},
				["addManaNumber"] = 6,
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
