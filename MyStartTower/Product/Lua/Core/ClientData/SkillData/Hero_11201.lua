local Data = {
["cueFile"] = "11201",
	[1120101] = {
		["bhEvent"] = "skill.1120101",
		["atkEvents"]= {
			[1]= {
				["eventType"] = 1,
				["boxId"] = 1120109,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000062,},
				},
			},
			[100]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {112010001,112011001,},
				},
			},
		},

	},
	[1120102] = {
		["bhEvent"] = "skill.1120102",
		["atkEvents"]= {
			[1]= {
				["eventType"] = 1,
				["boxId"] = 1120109,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000062,},
				},
			},
			[100]= {
				["targetArea"] = 2,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {112010002,112011002,},
				},
			},
		},

	},
	[1120121] = {
		["bhEvent"] = "skill.1120121",
		["atkEvents"]= {
			[1]= {
				["eventType"] = 1,
				["boxId"] = 1120129,
				["state"]= {
				},
			},
			[2]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1120102,
					["duration"] = 2,
				},
			},
			[1001]= {
				["targetArea"] = 3,
				["boxId"] = 1120130,
				["state"]= {
				},
				["levelAtkEvents"]= {
					[2]= {
						["addManaNumber"] = 10,
					},
					[3]= {
						["addManaNumber"] = 10,
					},
					[4]= {
					},
					[5]= {
					},
					[6]= {
					},
				},

			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {112010003,112011003,},
				},
			},
			[5]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["levelAtkEvents"]= {
					[2]= {
					},
					[3]= {
						["state"]= {
							["stateId"] = 1120104,
							["duration"] = -999,
						},
					},
					[4]= {
						["state"]= {
							["duration"] = -999,
						},
					},
					[5]= {
						["state"]= {
							["duration"] = -999,
						},
					},
					[6]= {
						["state"]= {
							["duration"] = -999,
						},
					},
				},

			},
			[1002]= {
				["targetArea"] = 2,
				["targetChoose"] = 21,
				["boxId"] = 1120159,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {112010013,},
				},
				["subEventSkill"] = 1120121,
				["subEventId"] = 1003,
			},
			[1003]= {
				["targetArea"] = 3,
				["boxId"] = 1120160,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {10000047,},
				},
			},
		},

	},
	[1120151] = {
		["bhEvent"] = "skill.1120151",
		["atkEvents"]= {
			[1]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {112016001,112010008,112010014,},
				},
			},
			[100]= {
				["state"]= {
				},
				["baseCue"]= {
					["cueList"] = {112010007,},
				},
			},
			[1001]= {
				["targetArea"] = 2,
				["targetChoose"] = 21,
				["eventType"] = 1,
				["boxId"] = 1120159,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {112010013,},
				},
				["disablePassive"] = 1,
				["subEventSkill"] = 1120121,
				["subEventId"] = 1003,
			},
			[2]= {
				["targetArea"] = 2,
				["state"]= {
					["stateId"] = 1120101,
					["duration"] = -999,
				},
				["addManaNumber"] = 99,
			},
			[1002]= {
				["targetArea"] = 2,
				["state"]= {
					["stateOperation"] = 1,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {1120101,},
				},
				["levelAtkEvents"]= {
					[2]= {
					},
					[3]= {
						["addManaNumber"] = 20,
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
				["targetArea"] = 2,
				["delay"] = 0.1,
				["eventType"] = 1,
				["boxId"] = 1120160,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {10000047,},
				},
			},
			[1004]= {
				["targetArea"] = 2,
				["state"]= {
					["stateId"] = 1120105,
					["duration"] = 0.1,
				},
			},
			[13]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {112010019,112015001,112011006,},
				},
			},
		},

		["actTime"] = 90,
		["hideEffect"] = 1,
		["videoActTime"] = 64,
		["videoActCue"]= {
			["cueList"] = {112018001,112011007,},
		},
		["skillTarget"] = 1,
	},
	[1120103] = {
		["bhEvent"] = "skill.1120103",
		["atkEvents"]= {
			[1]= {
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {112010005,},
				},
			},
			[100]= {
				["eventType"] = 1,
				["boxId"] = 1120109,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {112010004,112011004,},
				},
			},
		},

	},
	[1120122] = {
		["bhEvent"] = "skill.1120122",
		["atkEvents"]= {
			[2]= {
				["targetArea"] = 2,
				["state"]= {
					["stateId"] = 1120102,
					["duration"] = 2,
				},
			},
			[1]= {
				["targetChoose"] = 1,
				["eventType"] = 1,
				["boxId"] = 1120129,
				["state"]= {
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {112010006,112011005,},
				},
			},
			[5]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["levelAtkEvents"]= {
					[2]= {
					},
					[3]= {
						["state"]= {
							["stateId"] = 1120104,
							["duration"] = -999,
						},
					},
					[4]= {
						["state"]= {
							["stateId"] = 1120104,
							["duration"] = -999,
						},
					},
					[5]= {
						["state"]= {
							["stateId"] = 1120104,
							["duration"] = -999,
						},
					},
					[6]= {
						["state"]= {
							["stateId"] = 1120104,
							["duration"] = -999,
						},
					},
				},

			},
		},

	},
	[1120152] = {
		["bhEvent"] = "skill.1120152",
		["atkEvents"]= {
			[100]= {
				["targetArea"] = 2,
				["state"]= {
					["chooseStateMode"] = 2,
				},
				["atkCue"]= {
					["cueList"] = {112010009,112010015,112010016,112010018,112010017,112011008,},
				},
			},
			[1]= {
				["targetArea"] = 2,
				["state"]= {
					["chooseStateMode"] = 2,
				},
				["atkCue"]= {
					["cueList"] = {112016002,112010010,},
				},
			},
			[2]= {
				["targetArea"] = 2,
				["state"]= {
					["chooseStateMode"] = 2,
				},
			},
			[99]= {
				["targetArea"] = 2,
				["state"]= {
				},
				["hitedAnim"] = "end",
			},
		},

		["actTime"] = 90,
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
