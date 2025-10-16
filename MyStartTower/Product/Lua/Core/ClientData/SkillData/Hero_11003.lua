local Data = {
["cueFile"] = "11003",
	[1100351] = {
		["bhEvent"] = "skill.1100351",
		["atkEvents"]= {
			[10]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {110035002,110030002,},
				},
			},
			[100]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1100301,
					["duration"] = -999,
				},
			},
			[1]= {
				["targetArea"] = 2,
				["targetChoose"] = 3,
				["eventType"] = 1,
				["boxId"] = 1100359,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {110033001,},
				},
				["hitCue"]= {
					["cueList"] = {110030003,10006003,},
				},
				["hitedAnim"] = "Hit",
				["levelAtkEvents"]= {
					[2]= {
						["stunTime"] = 2,
					},
					[3]= {
						["stunTime"] = 2,
					},
					[4]= {
						["stunTime"] = 3,
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
					["stateId"] = 1100303,
					["duration"] = -999,
				},
			},
			[12]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {110035003,},
				},
			},
			[20]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {110038001,},
				},
			},
			[30]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {110035004,110030004,},
				},
				["levelAtkEvents"]= {
					[2]= {
					},
					[3]= {
						["state"]= {
							["stateId"] = 1100305,
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
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {110036001,},
				},
			},
			[1002]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {110036002,},
				},
			},
			[1003]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["addManaNumber"] = 10,
			},
			[99]= {
				["state"]= {
				},
			},
			[11]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {110030006,110030007,110031002,},
				},
			},
			[90]= {
				["targetArea"] = 2,
				["targetChoose"] = 3,
				["state"]= {
				},
				["hitedAnim"] = "end",
			},
		},

		["actTime"] = 62,
		["hideEffect"] = 1,
		["videoActTime"] = 59,
		["videoActCue"]= {
			["cueList"] = {110038002,110031006,},
		},
		["hideTime"] = 10,
		["hideEvent"] = 1,
		["prepareCamera"] = 1,
		["prepareCamDruation"] = 30,
	},
	[1100301] = {
		["bhEvent"] = "skill.1100301",
		["atkEvents"]= {
			[1]= {
				["eventType"] = 1,
				["boxId"] = 1100309,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {110030001,},
				},
			},
			[10]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {110031003,},
				},
			},
			[99]= {
				["state"]= {
				},
			},
		},

	},
	[1100302] = {
		["bhEvent"] = "skill.1100302",
		["atkEvents"]= {
			[1]= {
				["eventType"] = 1,
				["boxId"] = 1100309,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {110030001,},
				},
			},
			[10]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {110031005,},
				},
			},
			[99]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {110031004,},
				},
			},
			[2]= {
				["state"]= {
				},
			},
		},

	},
	[1100321] = {
		["bhEvent"] = "skill.1100321",
		["atkEvents"]= {
			[1]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1100302,
					["duration"] = 2,
				},
				["atkCue"]= {
					["cueList"] = {110031005,},
				},
			},
			[1001]= {
				["targetArea"] = 3,
				["boxId"] = 1100329,
				["state"]= {
					["stateOperation"] = 1,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {1100304,},
				},
				["subEventSkill"] = 1100321,
				["subEventId"] = 1003,
				["levelAtkEvents"]= {
					[2]= {
						["hitCue"]= {
							["cueList"] = {10000035,},
						},
						["addManaNumber"] = 30,
					},
					[3]= {
						["hitCue"]= {
							["cueList"] = {10000035,},
						},
						["addManaNumber"] = 30,
					},
					[4]= {
						["addManaNumber"] = 30,
					},
					[5]= {
					},
					[6]= {
					},
				},

			},
			[10]= {
				["state"]= {
				},
			},
			[1002]= {
				["targetArea"] = 3,
				["boxId"] = 1100330,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000047,},
				},
				["eventCondition"] = "1,1,1100316",
			},
			[1003]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1100316,
					["duration"] = 7,
				},
				["eventCondition"] = "1,1,1100313",
			},
		},

	},
	[1100371] = {
		["bhEvent"] = "skill.1100371",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {110038002,},
				},
			},
			[2]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1100303,
					["duration"] = -999,
				},
				["atkCue"]= {
					["cueList"] = {110035004,},
				},
			},
			[1]= {
				["targetArea"] = 2,
				["targetChoose"] = 3,
				["eventType"] = 1,
				["boxId"] = 1100359,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {110030003,},
				},
				["stunTime"] = 3,
			},
		},

		["actTime"] = 110,
		["prepareCamera"] = 1,
		["prepareCamDruation"] = 30,
	},
	[1100303] = {
		["bhEvent"] = "skill.1100303",
		["atkEvents"]= {
			[1]= {
				["eventType"] = 1,
				["boxId"] = 1100309,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {110030008,},
				},
				["stunTime"] = 1.5,
			},
			[2]= {
				["targetArea"] = 3,
				["state"]= {
					["stateOperation"] = 1,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {1100306,1100315,},
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {110030005,110031007,},
				},
			},
			[1001]= {
				["targetArea"] = 3,
				["boxId"] = 1100310,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000047,},
				},
				["addManaNumber"] = 3,
			},
			[1002]= {
				["targetArea"] = 3,
				["delay"] = 0.2,
				["boxType"] = 1,
				["state"]= {
					["stateId"] = 1100315,
					["duration"] = -999,
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
