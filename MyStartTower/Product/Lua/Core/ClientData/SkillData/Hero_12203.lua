local Data = {
["cueFile"] = "12203",
	[1220301] = {
		["bhEvent"] = "skill.1220301",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {122030001,122031001,},
				},
			},
			[1]= {
				["eventType"] = 1,
				["boxId"] = 1220301,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {122030004,},
				},
			},
		},

	},
	[1220302] = {
		["bhEvent"] = "skill.1220302",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {122030002,122031002,},
				},
			},
			[1]= {
				["eventType"] = 1,
				["boxId"] = 1220301,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {122030004,},
				},
			},
		},

	},
	[1220303] = {
		["bhEvent"] = "skill.1220303",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {122030003,122030005,122031003,},
				},
			},
			[1]= {
				["eventType"] = 1,
				["boxId"] = 1220301,
				["state"]= {
				},
			},
		},

	},
	[1220321] = {
		["bhEvent"] = "skill.1220321",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {122030006,122031004,},
				},
			},
			[1]= {
				["eventType"] = 1,
				["boxId"] = 1220322,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {122030007,},
				},
				["levelAtkEvents"]= {
					[2]= {
						["addManaNumber"] = -20,
					},
					[3]= {
						["addManaNumber"] = -20,
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
				},
				["levelAtkEvents"]= {
					[2]= {
					},
					[3]= {
						["state"]= {
							["stateId"] = 1220302,
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
			[1001]= {
				["delay"] = 0.2,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1220321,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000041,},
				},
				["disablePassive"] = 1,
			},
			[1002]= {
				["eventType"] = 1,
				["boxId"] = 1220352,
				["state"]= {
				},
				["disablePassive"] = 1,
			},
			[1003]= {
				["targetArea"] = 3,
				["state"]= {
					["stateOperation"] = 1,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {1220307,},
				},
			},
		},

	},
	[1220351] = {
		["bhEvent"] = "skill.1220351",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {122030009,},
				},
			},
			[1]= {
				["eventType"] = 1,
				["boxId"] = 1220351,
				["state"]= {
					["stateId"] = 1220304,
					["duration"] = 5,
				},
				["hitCue"]= {
					["cueList"] = {122033001,122030014,},
				},
				["hitedAnim"] = "Hit",
				["subEventSkill"] = 1220351,
				["subEventId"] = 1004,
			},
			[2]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1220305,
					["duration"] = 5,
				},
				["subEventSkill"] = 1220351,
				["subEventId"] = 1005,
			},
			[1001]= {
				["targetArea"] = 3,
				["boxId"] = 1220360,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000047,},
				},
			},
			[1002]= {
				["eventType"] = 1,
				["boxId"] = 1220352,
				["state"]= {
				},
				["disablePassive"] = 1,
			},
			[13]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {122030012,122035001,122031006,},
				},
			},
			[99]= {
				["state"]= {
				},
				["hitedAnim"] = "end",
			},
			[1003]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1220306,
					["duration"] = 5,
				},
			},
			[1004]= {
				["state"]= {
					["stateId"] = 1220306,
					["duration"] = 5,
				},
			},
			[1005]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1220307,
					["duration"] = 5,
				},
			},
		},

		["actTime"] = 90,
		["hideEffect"] = 1,
		["videoActTime"] = 60,
		["videoActCue"]= {
			["cueList"] = {122038001,122031005,},
		},
		["hideTime"] = 10,
		["hideEvent"] = 1,
		["prepareCamera"] = 1,
		["prepareCamDruation"] = 25,
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
