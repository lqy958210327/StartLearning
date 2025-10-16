local Data = {
["cueFile"] = "13001",
	[1300101] = {
		["bhEvent"] = "skill.1300101",
		["atkEvents"]= {
			[1]= {
				["unitDelay"] = 0.25,
				["flyCueId"] = 130010001,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1300109,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000063,130011004,},
				},
			},
			[10]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {130010003,130011003,},
				},
			},
		},

	},
	[1300102] = {
		["bhEvent"] = "skill.1300102",
		["atkEvents"]= {
			[10]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {130010011,130011005,},
				},
			},
			[1]= {
				["unitDelay"] = 0.08,
				["flyCueId"] = 130010012,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1300109,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {130010013,130011006,},
				},
			},
		},

	},
	[1300151] = {
		["bhEvent"] = "skill.1300151",
		["atkEvents"]= {
			[1]= {
				["targetChoose"] = 7,
				["eventType"] = 1,
				["boxId"] = 1300159,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {130010007,10006003,},
				},
				["hitedAnim"] = "Hit",
				["randomTargetNumber"] = 1,
			},
			[12]= {
				["targetChoose"] = 7,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {130015004,130010009,},
				},
			},
			[20]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {130010010,},
				},
			},
			[30]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1300102,
					["duration"] = 1,
				},
				["atkCue"]= {
					["cueList"] = {130015004,130010009,},
				},
			},
			[2]= {
				["targetChoose"] = 7,
				["state"]= {
				},
				["levelAtkEvents"]= {
					[2]= {
						["eventType"] = 1,
						["boxId"] = 1300159,
						["hitCue"]= {
							["cueList"] = {130010007,10006003,},
						},
						["hitedAnim"] = "Hit",
						["randomTargetNumber"] = 1,
					},
					[3]= {
						["eventType"] = 1,
						["boxId"] = 1300159,
						["hitCue"]= {
							["cueList"] = {130010007,10006003,},
						},
						["hitedAnim"] = "Hit",
						["randomTargetNumber"] = 1,
					},
					[4]= {
						["eventType"] = 1,
						["boxId"] = 1300159,
						["hitCue"]= {
							["cueList"] = {130010007,},
						},
						["randomTargetNumber"] = 1,
					},
					[5]= {
					},
					[6]= {
					},
				},

			},
			[13]= {
				["targetChoose"] = 7,
				["state"]= {
				},
				["hitedAnim"] = "end",
			},
			[1001]= {
				["eventType"] = 1,
				["boxId"] = 1300160,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000078,},
				},
				["disablePassive"] = 1,
			},
			[1002]= {
				["eventProbId"] = 1300102,
				["state"]= {
				},
				["stunTime"] = 2,
			},
			[1003]= {
				["targetArea"] = 3,
				["state"]= {
					["stateOperation"] = 1,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {1300105,},
				},
			},
			[1004]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1300105,
					["duration"] = -999,
				},
			},
			[3]= {
				["targetChoose"] = 7,
				["state"]= {
				},
				["levelAtkEvents"]= {
					[2]= {
					},
					[3]= {
						["eventType"] = 1,
						["boxId"] = 1300159,
						["hitCue"]= {
							["cueList"] = {130010007,10006003,},
						},
						["hitedAnim"] = "Hit",
						["randomTargetNumber"] = 1,
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
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 3311410,
					["duration"] = 1,
				},
			},
		},

		["actTime"] = 97,
		["hideEffect"] = 1,
		["videoActTime"] = 30,
		["videoActCue"]= {
			["cueList"] = {130018002,130011007,},
		},
		["hideTime"] = 10,
		["hideEvent"] = 12,
		["prepareCamera"] = 1,
		["prepareCamDruation"] = 20,
	},
	[1300191] = {
		["bhEvent"] = "skill.1300191",
		["atkEvents"]= {
			[20]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {130010010,},
				},
			},
			[1]= {
				["targetChoose"] = 7,
				["boxId"] = 1300159,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {130011002,130010007,},
				},
				["randomTargetNumber"] = 1,
			},
		},

	},
	[1300103] = {
		["bhEvent"] = "skill.1300103",
		["atkEvents"]= {
			[10]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {130010011,130011005,},
				},
			},
			[1]= {
				["targetChoose"] = 7,
				["unitDelay"] = 0.08,
				["flyCueId"] = 130010012,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1300109,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {130010013,130011006,},
				},
				["randomTargetNumber"] = 3,
				["randomRule"] = 2,
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
