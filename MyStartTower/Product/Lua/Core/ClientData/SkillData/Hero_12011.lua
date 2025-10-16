local Data = {
["cueFile"] = "12011",
	[1201109] = {
		["bhEvent"] = "skill.1201109",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {120110001,120111001,},
				},
			},
			[1]= {
				["eventType"] = 1,
				["boxId"] = 1201109,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000062,},
				},
			},
			[1001]= {
				["state"]= {
				},
				["stunTime"] = 1,
			},
		},

	},
	[1201110] = {
		["bhEvent"] = "skill.1201110",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {120110002,120111002,},
				},
			},
			[1]= {
				["eventType"] = 1,
				["boxId"] = 1201109,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000062,},
				},
			},
		},

	},
	[1201129] = {
		["bhEvent"] = "skill.1201129",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {120110003,120111003,},
				},
			},
			[1]= {
				["delay"] = 0.15,
				["flyCueId"] = 120110004,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1201129,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {120116001,},
				},
				["hitCue"]= {
					["cueList"] = {120110005,120111004,},
				},
				["subEventSkill"] = 1201129,
				["subEventId"] = 1001,
			},
			[1001]= {
				["delay"] = 0.15,
				["flyCueId"] = 120110004,
				["baseToTarget"] = 1,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1201129,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {120110005,120111004,},
				},
				["subEventSkill"] = 1201129,
				["subEventId"] = 1002,
			},
			[1002]= {
				["delay"] = 0.15,
				["flyCueId"] = 120110004,
				["baseToTarget"] = 1,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1201129,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {120110005,120111004,},
				},
				["levelAtkEvents"]= {
					[2]= {
					},
					[3]= {
						["subEventSkill"] = 1201129,
						["subEventId"] = 1003,
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
				["delay"] = 0.15,
				["flyCueId"] = 120110004,
				["baseToTarget"] = 1,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1201129,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {120110005,120111004,},
				},
			},
			[1004]= {
				["targetArea"] = 3,
				["boxId"] = 1201131,
				["state"]= {
				},
			},
			[1005]= {
				["delay"] = 0.2,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1201130,
				["state"]= {
				},
				["disablePassive"] = 1,
			},
		},

	},
	[1201159] = {
		["bhEvent"] = "skill.1201159",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {120110006,120110007,120110010,120110011,120110012,120115002,},
				},
			},
			[1]= {
				["eventType"] = 1,
				["boxId"] = 1201159,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {120113001,},
				},
				["hitCue"]= {
					["cueList"] = {120110008,10006003,},
				},
				["hitedAnim"] = "Hit",
				["stunTime"] = 1,
				["levelAtkEvents"]= {
					[2]= {
					},
					[3]= {
						["addManaNumber"] = -9,
					},
					[4]= {
					},
					[5]= {
					},
					[6]= {
					},
				},

			},
			[13]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {120115001,120110009,120111006,},
				},
			},
			[99]= {
				["state"]= {
				},
				["hitedAnim"] = "end",
			},
			[1001]= {
				["targetArea"] = 3,
				["state"]= {
					["stateOperation"] = 2,
					["duration"] = 1,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {1201102,},
				},
			},
		},

		["actTime"] = 62,
		["hideEffect"] = 1,
		["videoActTime"] = 72,
		["videoActCue"]= {
			["cueList"] = {120118001,120111005,},
		},
		["hideTime"] = 10,
		["hideEvent"] = 100,
		["prepareCamera"] = 1,
		["prepareCamDruation"] = 40,
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
