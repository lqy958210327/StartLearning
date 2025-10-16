local Data = {
["cueFile"] = "13003",
	[1300309] = {
		["bhEvent"] = "skill.1300309",
		["atkEvents"]= {
			[0]= {
				["unitDelay"] = 0.12,
				["flyCueId"] = 130030002,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1300309,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {130030003,130031003,},
				},
			},
			[1]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {130030001,},
				},
			},
			[100]= {
				["state"]= {
				},
			},
		},

	},
	[1300310] = {
		["bhEvent"] = "skill.1300310",
		["atkEvents"]= {
			[0]= {
				["unitDelay"] = 0.12,
				["flyCueId"] = 130030010,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1300309,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {130030003,130031004,},
				},
			},
			[1]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {130030009,},
				},
			},
			[100]= {
				["state"]= {
				},
			},
		},

	},
	[1300359] = {
		["bhEvent"] = "skill.1300359",
		["atkEvents"]= {
			[11]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {130035001,130030015,},
				},
			},
			[1]= {
				["targetChoose"] = 4,
				["eventType"] = 1,
				["boxId"] = 1300359,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {130033001,},
				},
				["hitCue"]= {
					["cueList"] = {130030008,10006003,130031002,},
				},
				["hitedAnim"] = "Hit",
				["randomTargetNumber"] = 1,
				["recordSkillTargets"] = 1,
			},
			[1001]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["addManaNumber"] = -15,
				["manaNotShow"] = 1,
			},
			[2]= {
				["targetChoose"] = 4,
				["eventType"] = 1,
				["boxId"] = 1300359,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {130030008,},
				},
				["randomTargetNumber"] = 1,
				["levelAtkEvents"]= {
					[2]= {
					},
					[3]= {
					},
					[4]= {
					},
					[5]= {
					},
					[6]= {
					},
				},

			},
			[12]= {
				["targetChoose"] = 4,
				["state"]= {
					["stateOperation"] = 1,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {1300303,},
				},
			},
			[13]= {
				["targetArea"] = 3,
				["state"]= {
				},
			},
			[10]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["levelAtkEvents"]= {
					[2]= {
						["state"]= {
							["stateId"] = 1300302,
							["duration"] = 4,
						},
						["addManaNumber"] = 60,
						["manaNotShow"] = 1,
					},
					[3]= {
						["state"]= {
							["stateId"] = 1300302,
							["duration"] = 4,
						},
						["addManaNumber"] = 60,
						["manaNotShow"] = 1,
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
				["state"]= {
				},
				["addManaNumber"] = -15,
				["manaNotShow"] = 1,
			},
			[100]= {
				["targetChoose"] = 7,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {130030016,},
				},
			},
			[90]= {
				["targetChoose"] = 12,
				["state"]= {
					["stateId"] = 1300303,
					["duration"] = 2,
				},
				["hitedAnim"] = "end",
			},
			[1003]= {
				["delay"] = 0.1,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1300361,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {130030008,130031002,10006003,},
				},
				["disablePassive"] = 1,
			},
		},

		["actTime"] = 76,
		["hideEffect"] = 1,
		["videoActTime"] = 50,
		["videoActCue"]= {
			["cueList"] = {130038002,130031006,},
		},
		["hideTime"] = 10,
		["hideEvent"] = 100,
		["prepareCamera"] = 1,
		["prepareCamDruation"] = 25,
		["skillTarget"] = 5,
	},
	[1300329] = {
		["bhEvent"] = "skill.1300329",
		["atkEvents"]= {
			[100]= {
				["targetArea"] = 2,
				["targetChoose"] = 7,
				["eventType"] = 1,
				["boxId"] = 1300360,
				["state"]= {
					["stateId"] = 1300302,
					["duration"] = 10,
				},
				["hitCue"]= {
					["cueList"] = {130030003,},
				},
			},
			[0]= {
				["state"]= {
				},
			},
			[1001]= {
				["targetArea"] = 2,
				["targetChoose"] = 7,
				["unitDelay"] = 0.1,
				["flyCueId"] = 130030001,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1300360,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {130030007,},
				},
			},
			[1002]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1300301,
					["duration"] = -999,
				},
			},
			[1003]= {
				["targetArea"] = 1,
				["unitDelay"] = 0.25,
				["flyCueId"] = 130030004,
				["boxType"] = 1,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {130030018,},
				},
			},
			[1]= {
				["targetArea"] = 2,
				["targetChoose"] = 7,
				["unitDelay"] = 0.08,
				["flyCueId"] = 130030001,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1300360,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {130030007,},
				},
			},
			[10]= {
				["targetArea"] = 3,
				["state"]= {
					["stateOperation"] = 1,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {1300304,},
				},
			},
			[2]= {
				["targetArea"] = 3,
				["boxId"] = 1300329,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10006006,},
				},
			},
			[1004]= {
				["targetChoose"] = 7,
				["eventType"] = 1,
				["boxId"] = 1300330,
				["state"]= {
				},
				["baseCue"]= {
					["cueList"] = {10000058,},
				},
				["disablePassive"] = 1,
				["stunTime"] = 1,
			},
		},

		["actTime"] = 48,
		["skillTarget"] = 1,
	},
	[1300321] = {
		["bhEvent"] = "skill.1300321",
		["atkEvents"]= {
			[1]= {
				["targetArea"] = 2,
				["targetChoose"] = 7,
				["unitDelay"] = 0.12,
				["flyCueId"] = 130030002,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1300309,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {130030006,},
				},
			},
		},

		["actTime"] = 300,
	},
	[1300391] = {
		["bhEvent"] = "skill.1300391",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
			},
			[1]= {
				["targetChoose"] = 4,
				["boxId"] = 1300359,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {130030008,},
				},
				["randomTargetNumber"] = 1,
			},
		},

	},
	[1300311] = {
		["bhEvent"] = "skill.1300311",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
			},
			[0]= {
				["targetChoose"] = 7,
				["unitDelay"] = 0.12,
				["flyCueId"] = 130030002,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3300401,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {130030003,130031003,},
				},
				["randomTargetNumber"] = 3,
			},
			[1]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {130030001,},
				},
			},
		},

	},
	[1300312] = {
		["bhEvent"] = "skill.1300312",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
			},
			[0]= {
				["targetChoose"] = 7,
				["unitDelay"] = 0.12,
				["flyCueId"] = 130030010,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3300401,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {130030003,130031004,},
				},
				["randomTargetNumber"] = 3,
			},
			[1]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {130030009,},
				},
			},
		},

	},
	[1300331] = {
		["bhEvent"] = "skill.1300331",
		["atkEvents"]= {
			[1]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 3300405,
					["duration"] = -999,
				},
			},
			[1001]= {
				["targetChoose"] = 3,
				["eventType"] = 1,
				["boxId"] = 3300431,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {130030017,},
				},
				["hitCue"]= {
					["cueList"] = {130030003,},
				},
			},
		},

		["skillTarget"] = 1,
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
