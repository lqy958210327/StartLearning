local Data = {
["cueFile"] = "12001",
	[1200101] = {
		["bhEvent"] = "skill.1200101",
		["atkEvents"]= {
			[1]= {
				["eventType"] = 1,
				["boxId"] = 1200109,
				["state"]= {
				},
			},
		},

	},
	[1200102] = {
		["bhEvent"] = "skill.1200102",
		["atkEvents"]= {
			[1]= {
				["eventType"] = 1,
				["boxId"] = 1200109,
				["state"]= {
				},
			},
		},

	},
	[1200121] = {
		["bhEvent"] = "skill.1200121",
		["atkEvents"]= {
			[1]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1200101,
					["duration"] = 12,
				},
				["levelAtkEvents"]= {
					[2]= {
					},
					[3]= {
						["state"]= {
							["stateId"] = 1200101,
							["duration"] = 16,
						},
					},
					[4]= {
						["state"]= {
							["stateId"] = 1200101,
							["duration"] = 16,
						},
					},
					[5]= {
						["state"]= {
							["stateId"] = 1200101,
							["duration"] = 18,
						},
					},
					[6]= {
						["state"]= {
							["stateId"] = 1200101,
							["duration"] = 15,
						},
					},
				},

			},
			[1001]= {
				["targetArea"] = 2,
				["targetChoose"] = 3,
				["eventType"] = 1,
				["boxId"] = 1200161,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {120010004,},
				},
				["randomTargetNumber"] = 1,
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {120010006,},
				},
			},
		},

		["actTime"] = 45,
		["skillTarget"] = 1,
	},
	[1200151] = {
		["bhEvent"] = "skill.1200151",
		["atkEvents"]= {
			[10]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {120010005,},
				},
				["levelAtkEvents"]= {
					[2]= {
						["state"]= {
							["stateId"] = 1200102,
							["duration"] = 1,
						},
					},
					[3]= {
						["state"]= {
							["stateId"] = 1200102,
							["duration"] = 1,
						},
					},
					[4]= {
						["state"]= {
							["stateId"] = 1200102,
							["duration"] = 1,
						},
					},
					[5]= {
					},
					[6]= {
					},
				},

			},
			[1]= {
				["eventType"] = 1,
				["boxId"] = 1200159,
				["state"]= {
				},
				["hitedAnim"] = "Hit",
			},
			[1001]= {
				["state"]= {
				},
				["stunTime"] = 3,
			},
			[20]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {120015002,120010003,120011002,},
				},
			},
			[1002]= {
				["targetArea"] = 3,
				["state"]= {
					["stateOperation"] = 2,
					["duration"] = 5,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {1200101,},
				},
				["hitCue"]= {
					["cueList"] = {10000035,},
				},
				["addManaNumber"] = 30,
			},
			[2]= {
				["targetArea"] = 3,
				["boxId"] = 1200160,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000008,},
				},
			},
			[0]= {
				["state"]= {
				},
			},
			[27]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {120013002,},
				},
				["hitedAnim"] = "Hit",
			},
			[90]= {
				["state"]= {
				},
				["hitedAnim"] = "end",
			},
			[26]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {120013001,},
				},
				["hitCue"]= {
					["cueList"] = {120010002,},
				},
			},
		},

		["actTime"] = 64,
		["hideEffect"] = 1,
		["videoActTime"] = 43,
		["videoActCue"]= {
			["cueList"] = {120018002,120011001,},
		},
		["hideTime"] = 10,
		["hideEvent"] = 1,
		["prepareCamera"] = 1,
		["prepareCamDruation"] = 45,
	},
	[1200103] = {
		["bhEvent"] = "skill.1200103",
		["atkEvents"]= {
			[1]= {
				["eventType"] = 1,
				["boxId"] = 1200109,
				["state"]= {
				},
			},
		},

	},
	[1200191] = {
		["bhEvent"] = "skill.1200191",
		["atkEvents"]= {
			[10]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {120010005,},
				},
			},
			[1]= {
				["boxId"] = 1200159,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {120011002,120010002,},
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
