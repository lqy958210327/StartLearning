local Data = {
["cueFile"] = "15001",
	[1500101] = {
		["bhEvent"] = "skill.1500101",
		["atkEvents"]= {
			[1]= {
				["unitDelay"] = 0.15,
				["flyCueId"] = 150010006,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1500109,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {150010001,},
				},
			},
			[10]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {150010005,},
				},
			},
			[2]= {
				["targetArea"] = 3,
				["targetChoose"] = 14,
				["state"]= {
				},
				["levelAtkEvents"]= {
					[2]= {
						["boxId"] = 1500110,
						["hitCue"]= {
							["cueList"] = {150010009,},
						},
					},
					[3]= {
						["boxId"] = 1500110,
						["hitCue"]= {
							["cueList"] = {150010009,},
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
	[1500121] = {
		["bhEvent"] = "skill.1500121",
		["atkEvents"]= {
			[1]= {
				["targetArea"] = 3,
				["targetChoose"] = 12,
				["state"]= {
					["stateId"] = 1500102,
					["duration"] = 15,
				},
				["hitCue"]= {
					["cueList"] = {150010004,150011004,},
				},
				["levelAtkEvents"]= {
					[2]= {
						["state"]= {
							["stateId"] = 1500102,
							["duration"] = 20,
						},
					},
					[3]= {
						["state"]= {
							["stateId"] = 1500102,
							["duration"] = 20,
						},
					},
					[4]= {
						["state"]= {
							["stateId"] = 1500102,
							["duration"] = 20,
						},
					},
					[5]= {
						["state"]= {
							["stateId"] = 1500102,
							["duration"] = 20,
						},
					},
					[6]= {
					},
				},

			},
			[2]= {
				["targetArea"] = 3,
				["targetChoose"] = 12,
				["state"]= {
				},
				["levelAtkEvents"]= {
					[2]= {
					},
					[3]= {
						["state"]= {
							["stateId"] = 1500103,
							["duration"] = 10,
						},
					},
					[4]= {
						["state"]= {
							["stateId"] = 1500103,
							["duration"] = 10,
						},
					},
					[5]= {
						["state"]= {
							["stateId"] = 1500103,
							["duration"] = 10,
						},
					},
					[6]= {
					},
				},

			},
			[100]= {
				["targetArea"] = 3,
				["targetChoose"] = 3,
				["state"]= {
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
		},

		["actTime"] = 30,
		["skillTarget"] = 1,
	},
	[1500151] = {
		["bhEvent"] = "skill.1500151",
		["atkEvents"]= {
			[2]= {
				["targetChoose"] = 12,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {150010002,150011002,10006003,},
				},
			},
			[1]= {
				["targetChoose"] = 12,
				["eventType"] = 1,
				["boxId"] = 1500159,
				["state"]= {
					["stateId"] = 1000004,
					["duration"] = 8,
				},
				["hitedAnim"] = "Hit",
				["levelAtkEvents"]= {
					[2]= {
						["state"]= {
							["stateId"] = 1000004,
							["duration"] = 10,
						},
					},
					[3]= {
						["state"]= {
							["stateId"] = 1000004,
							["duration"] = 10,
						},
					},
					[4]= {
						["state"]= {
							["stateId"] = 1000004,
							["duration"] = 12,
						},
					},
					[5]= {
						["state"]= {
							["stateId"] = 1000004,
							["duration"] = 10,
						},
					},
					[6]= {
						["state"]= {
							["stateId"] = 1000004,
							["duration"] = 10,
						},
					},
				},

			},
			[3]= {
				["targetChoose"] = 7,
				["state"]= {
				},
				["hitedAnim"] = "Hit",
				["randomTargetNumber"] = 2,
				["randomRule"] = 2,
				["recordSkillTargets"] = 1,
				["levelAtkEvents"]= {
					[2]= {
					},
					[3]= {
						["randomTargetNumber"] = 3,
					},
					[4]= {
						["randomTargetNumber"] = 3,
					},
					[5]= {
						["randomTargetNumber"] = 3,
					},
					[6]= {
						["randomTargetNumber"] = 3,
					},
				},

			},
			[10]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {150010010,},
				},
			},
			[11]= {
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {150010003,},
				},
			},
			[13]= {
				["targetChoose"] = 12,
				["state"]= {
				},
				["hitedAnim"] = "end",
			},
			[4]= {
				["targetChoose"] = 12,
				["state"]= {
				},
				["levelAtkEvents"]= {
					[2]= {
						["state"]= {
							["stateId"] = 1500104,
							["duration"] = 12,
						},
					},
					[3]= {
						["state"]= {
							["stateId"] = 1500104,
							["duration"] = 12,
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
			[12]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {150010007,150015001,},
				},
			},
		},

		["actTime"] = 115,
		["hideEffect"] = 1,
		["videoActTime"] = 35,
		["videoActCue"]= {
			["cueList"] = {150011005,150018002,},
		},
		["hideTime"] = 10,
		["hideEvent"] = 3,
		["prepareCamera"] = 1,
		["prepareCamDruation"] = 30,
	},
	[1500152] = {
		["bhEvent"] = "skill.1500152",
		["atkEvents"]= {
			[10]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {150010010,},
				},
			},
			[1]= {
				["targetChoose"] = 7,
				["boxId"] = 1500160,
				["state"]= {
					["stateId"] = 1000004,
					["duration"] = 15,
				},
				["hitedAnim"] = "Hit",
			},
			[12]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {150010007,150015001,},
				},
			},
			[2]= {
				["targetChoose"] = 7,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {150010002,150011002,10006003,},
				},
			},
			[4]= {
				["state"]= {
				},
			},
			[13]= {
				["targetChoose"] = 7,
				["state"]= {
				},
				["hitedAnim"] = "end",
			},
			[3]= {
				["targetChoose"] = 10,
				["state"]= {
				},
			},
		},

		["actTime"] = 115,
		["hideEffect"] = 1,
		["videoActTime"] = 35,
		["videoActCue"]= {
			["cueList"] = {150011005,150018002,},
		},
		["hideTime"] = 10,
		["hideEvent"] = 3,
		["prepareCamera"] = 1,
		["prepareCamDruation"] = 30,
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
