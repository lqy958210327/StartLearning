local Data = {
["cueFile"] = "11006",
	[1100609] = {
		["bhEvent"] = "skill.1100609",
		["atkEvents"]= {
			[0]= {
				["eventType"] = 1,
				["boxId"] = 1100609,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {110060002,},
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {110060001,110061003,},
				},
			},
		},

	},
	[1100610] = {
		["bhEvent"] = "skill.1100610",
		["atkEvents"]= {
			[0]= {
				["eventType"] = 1,
				["boxId"] = 1100609,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {110060004,},
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {110060003,110061004,},
				},
			},
		},

	},
	[1100629] = {
		["bhEvent"] = "skill.1100629",
		["atkEvents"]= {
			[0]= {
				["targetChoose"] = 2,
				["eventType"] = 1,
				["boxId"] = 1100629,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {110060007,},
				},
			},
			[100]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {110060005,110060006,110061005,},
				},
			},
			[1]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["levelAtkEvents"]= {
					[2]= {
						["state"]= {
							["stateId"] = 1100601,
							["duration"] = 5,
						},
					},
					[3]= {
						["state"]= {
							["stateId"] = 1100601,
							["duration"] = 5,
						},
						["addManaNumber"] = 5,
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
				["targetArea"] = 3,
				["boxId"] = 1100660,
				["state"]= {
				},
				["disablePassive"] = 1,
			},
		},

	},
	[1100659] = {
		["bhEvent"] = "skill.1100659",
		["atkEvents"]= {
			[100]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {110060008,110060009,},
				},
			},
			[0]= {
				["targetChoose"] = 2,
				["eventType"] = 1,
				["boxId"] = 1100659,
				["state"]= {
					["stateId"] = 1000001,
					["duration"] = 8,
				},
				["atkCue"]= {
					["cueList"] = {110063001,},
				},
				["hitCue"]= {
					["cueList"] = {110060010,10006003,},
				},
				["hitedAnim"] = "Hit",
				["levelAtkEvents"]= {
					[2]= {
					},
					[3]= {
					},
					[4]= {
						["state"]= {
						},
					},
					[5]= {
						["state"]= {
							["duration"] = 10,
						},
					},
					[6]= {
						["state"]= {
							["duration"] = 10,
						},
					},
				},

			},
			[13]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {110065001,110060011,110061006,},
				},
			},
			[2]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["levelAtkEvents"]= {
					[2]= {
						["state"]= {
							["stateId"] = 1100604,
							["duration"] = 8,
						},
					},
					[3]= {
						["state"]= {
							["stateId"] = 1100604,
							["duration"] = 8,
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
				["targetArea"] = 3,
				["state"]= {
				},
				["levelAtkEvents"]= {
					[2]= {
					},
					[3]= {
						["state"]= {
							["stateId"] = 1100603,
							["duration"] = 1,
						},
					},
					[4]= {
						["state"]= {
							["stateId"] = 1100603,
							["duration"] = 1,
						},
					},
					[5]= {
					},
					[6]= {
					},
				},

			},
			[1001]= {
				["targetArea"] = 3,
				["boxId"] = 1100660,
				["state"]= {
				},
				["disablePassive"] = 1,
			},
			[99]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {110060009,},
				},
			},
			[33]= {
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {110061002,},
				},
			},
			[90]= {
				["targetChoose"] = 2,
				["state"]= {
				},
				["hitedAnim"] = "end",
			},
		},

		["actTime"] = 65,
		["hideEffect"] = 1,
		["videoActTime"] = 40,
		["videoActCue"]= {
			["cueList"] = {110068001,110061001,},
		},
		["hideTime"] = 10,
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
