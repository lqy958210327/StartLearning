local Data = {
["cueFile"] = "13012",
	[1301209] = {
		["bhEvent"] = "skill.1301209",
		["atkEvents"]= {
			[100]= {
				["targetArea"] = 3,
				["state"]= {
					["stateOperation"] = 1,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {1301211,},
				},
				["atkCue"]= {
					["cueList"] = {130121001,},
				},
			},
			[1]= {
				["unitDelay"] = 0.2,
				["flyCueId"] = 130120001,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1301209,
				["state"]= {
					["stateId"] = 1301203,
					["duration"] = 3,
				},
				["hitCue"]= {
					["cueList"] = {130120002,130121002,},
				},
			},
			[1001]= {
				["targetChoose"] = 23,
				["state"]= {
					["stateId"] = 1301203,
					["duration"] = 3,
				},
			},
		},

	},
	[1301210] = {
		["bhEvent"] = "skill.1301210",
		["atkEvents"]= {
			[100]= {
				["targetArea"] = 3,
				["state"]= {
					["stateOperation"] = 1,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {1301211,},
				},
				["atkCue"]= {
					["cueList"] = {130121003,},
				},
			},
			[1]= {
				["unitDelay"] = 0.1,
				["flyCueId"] = 130120014,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1301209,
				["state"]= {
					["stateId"] = 1301203,
					["duration"] = 3,
				},
				["hitCue"]= {
					["cueList"] = {130120004,130121002,},
				},
			},
		},

	},
	[1301229] = {
		["bhEvent"] = "skill.1301229",
		["atkEvents"]= {
			[100]= {
				["state"]= {
					["stateId"] = 1301203,
					["duration"] = 3,
				},
				["atkCue"]= {
					["cueList"] = {130120005,130120006,130121004,},
				},
			},
			[1]= {
				["unitDelay"] = 0.08,
				["flyCueId"] = 130120007,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1301229,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {130120008,130121005,},
				},
				["levelAtkEvents"]= {
					[2]= {
						["stunTime"] = 1,
					},
					[3]= {
						["stunTime"] = 1,
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
				["delay"] = 0.5,
				["boxType"] = 1,
				["state"]= {
				},
				["levelAtkEvents"]= {
					[2]= {
					},
					[3]= {
						["state"]= {
							["stateId"] = 1301201,
							["duration"] = -999,
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
				["state"]= {
					["stateId"] = 1301203,
					["duration"] = -999,
				},
			},
			[1002]= {
				["targetChoose"] = 7,
				["eventType"] = 1,
				["boxId"] = 1301230,
				["state"]= {
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {0,},
				},
				["stunTime"] = 1,
				["randomTargetNumber"] = 1,
				["excludeTarget"] = 1,
			},
			[1003]= {
				["targetArea"] = 3,
				["state"]= {
					["stateOperation"] = 1,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {1301220,},
				},
			},
			[3]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1301212,
					["duration"] = 1,
				},
			},
		},

	},
	[1301259] = {
		["bhEvent"] = "skill.1301259",
		["atkEvents"]= {
			[100]= {
				["targetChoose"] = 7,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {130120009,130120012,130120010,},
				},
			},
			[11]= {
				["targetChoose"] = 23,
				["unitDelay"] = 0.1,
				["flyCueId"] = 130120013,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1301259,
				["state"]= {
				},
			},
			[17]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {130120021,130125001,130121007,},
				},
			},
			[12]= {
				["targetChoose"] = 23,
				["unitDelay"] = 0.1,
				["flyCueId"] = 130120014,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1301259,
				["state"]= {
				},
			},
			[13]= {
				["targetChoose"] = 23,
				["unitDelay"] = 0.1,
				["flyCueId"] = 130120015,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1301259,
				["state"]= {
				},
			},
			[14]= {
				["targetChoose"] = 23,
				["unitDelay"] = 0.1,
				["boxType"] = 1,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {130120016,130120019,},
				},
			},
			[1001]= {
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1301260,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {130120018,},
				},
				["disablePassive"] = 1,
			},
			[1002]= {
				["targetArea"] = 5,
				["state"]= {
					["stateOperation"] = 1,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {1301202,},
				},
			},
			[1]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1301202,
					["duration"] = 5,
				},
			},
		},

		["actTime"] = 95,
		["hideEffect"] = 1,
		["videoActTime"] = 70,
		["videoActCue"]= {
			["cueList"] = {130128001,130121006,},
		},
		["hideTime"] = 10,
		["hideEvent"] = 100,
		["prepareCamera"] = 1,
		["prepareCamDruation"] = 30,
	},
	[1301260] = {
		["bhEvent"] = "skill.1301260",
		["atkEvents"]= {
			[100]= {
				["targetChoose"] = 7,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {130120009,130120011,130120012,},
				},
			},
			[11]= {
				["targetChoose"] = 23,
				["unitDelay"] = 0.1,
				["flyCueId"] = 130120013,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1301259,
				["state"]= {
				},
			},
			[17]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {130120021,130125002,130121007,},
				},
			},
			[14]= {
				["targetChoose"] = 23,
				["unitDelay"] = 0.1,
				["boxType"] = 1,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {130120020,130120017,},
				},
			},
			[12]= {
				["targetChoose"] = 23,
				["unitDelay"] = 0.1,
				["flyCueId"] = 130120014,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1301259,
				["state"]= {
				},
			},
			[13]= {
				["targetChoose"] = 23,
				["unitDelay"] = 0.1,
				["flyCueId"] = 130120015,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1301259,
				["state"]= {
				},
			},
			[1]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1301202,
					["duration"] = 5,
				},
			},
		},

		["actTime"] = 103,
		["hideEffect"] = 1,
		["videoActTime"] = 70,
		["videoActCue"]= {
			["cueList"] = {130128001,130121006,},
		},
		["hideTime"] = 10,
		["hideEvent"] = 100,
		["prepareCamera"] = 1,
		["prepareCamDruation"] = 30,
	},
	[1301230] = {
		["bhEvent"] = "skill.1301230",
		["atkEvents"]= {
			[100]= {
				["state"]= {
					["stateId"] = 1301203,
					["duration"] = 3,
				},
				["atkCue"]= {
					["cueList"] = {130120005,130120006,130121004,},
				},
			},
			[1]= {
				["targetChoose"] = 3,
				["unitDelay"] = 0.08,
				["flyCueId"] = 130120007,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1301229,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {130120008,130121005,},
				},
				["levelAtkEvents"]= {
					[2]= {
						["stunTime"] = 1,
					},
					[3]= {
						["stunTime"] = 1,
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
				["delay"] = 0.5,
				["boxType"] = 1,
				["state"]= {
				},
				["levelAtkEvents"]= {
					[2]= {
					},
					[3]= {
						["state"]= {
							["stateId"] = 1301201,
							["duration"] = -999,
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
