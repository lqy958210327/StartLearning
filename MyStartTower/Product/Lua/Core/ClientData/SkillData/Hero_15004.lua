local Data = {
["cueFile"] = "15004",
	[1500409] = {
		["bhEvent"] = "skill.1500409",
		["atkEvents"]= {
			[0]= {
				["unitDelay"] = 0.12,
				["flyCueId"] = 150040002,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1500409,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {150040003,150041003,},
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {150040001,150041006,},
				},
			},
			[1]= {
				["state"]= {
				},
			},
		},

	},
	[1500410] = {
		["bhEvent"] = "skill.1500410",
		["atkEvents"]= {
			[0]= {
				["unitDelay"] = 0.08,
				["flyCueId"] = 90010003,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1500409,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {150040001,},
				},
			},
		},

	},
	[1500459] = {
		["bhEvent"] = "skill.1500459",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
			},
			[0]= {
				["targetArea"] = 3,
				["targetChoose"] = 10,
				["boxId"] = 1500459,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {150040007,},
				},
			},
			[10]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {150040009,},
				},
			},
			[1]= {
				["targetChoose"] = 7,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {150040006,150041002,},
				},
				["randomTargetNumber"] = 2,
				["recordSkillTargets"] = 1,
				["levelAtkEvents"]= {
					[2]= {
						["state"]= {
							["stateId"] = 1000003,
							["duration"] = 5,
						},
					},
					[3]= {
						["state"]= {
							["stateId"] = 1000003,
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
			[2]= {
				["targetArea"] = 3,
				["targetChoose"] = 10,
				["state"]= {
				},
				["addManaNumber"] = 16,
				["excludeTarget"] = 1,
				["levelAtkEvents"]= {
					[2]= {
						["addManaNumber"] = 20,
					},
					[3]= {
						["addManaNumber"] = 24,
					},
					[4]= {
						["addManaNumber"] = 24,
					},
					[5]= {
						["addManaNumber"] = 20,
					},
					[6]= {
						["addManaNumber"] = 20,
					},
				},

			},
			[3]= {
				["targetChoose"] = 12,
				["state"]= {
				},
				["levelAtkEvents"]= {
					[2]= {
						["state"]= {
							["stateId"] = 1500403,
							["duration"] = 5,
						},
					},
					[3]= {
						["state"]= {
							["stateId"] = 1500403,
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
			[13]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {150040008,150045001,},
				},
			},
		},

		["actTime"] = 50,
		["hideEffect"] = 1,
		["videoActTime"] = 83,
		["videoActCue"]= {
			["cueList"] = {150048002,150041001,},
		},
		["hideTime"] = 10,
		["prepareCamera"] = 1,
		["prepareCamDruation"] = 30,
	},
	[1500460] = {
		["bhEvent"] = "skill.1500460",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {150040001,},
				},
			},
			[0]= {
				["targetArea"] = 3,
				["targetChoose"] = 7,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {150040007,},
				},
				["addManaNumber"] = 80,
				["excludeTarget"] = 1,
			},
			[10]= {
				["state"]= {
				},
			},
			[1]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {150040006,},
				},
			},
			[3]= {
				["state"]= {
				},
			},
			[2]= {
				["state"]= {
				},
			},
			[13]= {
				["state"]= {
				},
			},
		},

		["actTime"] = 50,
		["videoActTime"] = 83,
		["videoActCue"]= {
			["cueList"] = {150048002,150041005,},
		},
		["hideTime"] = 10,
		["prepareCamera"] = 1,
		["prepareCamDruation"] = 30,
	},
	[1500429] = {
		["bhEvent"] = "skill.1500429",
		["atkEvents"]= {
			[100]= {
				["targetArea"] = 3,
				["targetChoose"] = 3,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {150040004,},
				},
				["excludeTarget"] = 1,
				["recordSkillTargets"] = 1,
				["levelAtkEvents"]= {
					[2]= {
					},
					[3]= {
						["targetChoose"] = 7,
					},
					[4]= {
						["targetChoose"] = 4,
					},
					[5]= {
						["targetChoose"] = 4,
					},
					[6]= {
						["targetChoose"] = 4,
					},
				},

			},
			[1]= {
				["targetArea"] = 3,
				["targetChoose"] = 12,
				["state"]= {
					["stateId"] = 1500402,
					["duration"] = -999,
				},
				["hitCue"]= {
					["cueList"] = {150040005,150041004,},
				},
			},
			[10]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {150041007,},
				},
			},
			[1001]= {
				["targetArea"] = 3,
				["targetChoose"] = 18,
				["state"]= {
					["stateId"] = 82150041,
					["duration"] = -999,
				},
			},
		},

		["actTime"] = 30,
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
