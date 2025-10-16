local Data = {
["cueFile"] = "14101",
	[1410109] = {
		["bhEvent"] = "skill.1410109",
		["atkEvents"]= {
			[0]= {
				["unitDelay"] = 0.1,
				["flyCueId"] = 141010002,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1410109,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {141010003,141011002,},
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {141010001,141011001,},
				},
			},
		},

	},
	[1410129] = {
		["bhEvent"] = "skill.1410129",
		["atkEvents"]= {
			[0]= {
				["targetArea"] = 2,
				["targetChoose"] = 4,
				["delay"] = 0.15,
				["flyCueId"] = 90010005,
				["eventType"] = 1,
				["boxId"] = 1410129,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {141010005,},
				},
				["levelAtkEvents"]= {
					[2]= {
						["state"]= {
							["stateId"] = 1410102,
							["duration"] = 8,
						},
					},
					[3]= {
						["state"]= {
							["stateId"] = 1410102,
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
							["stateId"] = 1410103,
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
				["targetArea"] = 3,
				["targetChoose"] = 4,
				["state"]= {
					["stateId"] = 1410104,
					["duration"] = -999,
				},
			},
			[100]= {
				["targetArea"] = 2,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {141010004,},
				},
			},
			[15]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {141011003,},
				},
			},
		},

		["skillTarget"] = 1,
	},
	[1410159] = {
		["bhEvent"] = "skill.1410159",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {141010006,141010011,141010012,141010013,141010014,141010015,141010016,},
				},
			},
			[0]= {
				["targetChoose"] = 4,
				["delay"] = 0.15,
				["flyCueId"] = 90010005,
				["eventType"] = 1,
				["boxId"] = 1410159,
				["state"]= {
				},
			},
			[1]= {
				["targetChoose"] = 9,
				["delay"] = 0.2,
				["boxType"] = 1,
				["state"]= {
				},
				["levelAtkEvents"]= {
					[2]= {
						["eventType"] = 1,
						["boxId"] = 1410160,
						["state"]= {
							["stateId"] = 1410101,
							["duration"] = 5,
						},
					},
					[3]= {
						["eventType"] = 1,
						["boxId"] = 1410160,
						["state"]= {
							["stateId"] = 1410101,
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
				["targetArea"] = 3,
				["state"]= {
				},
				["addManaNumber"] = 20,
			},
			[2]= {
				["state"]= {
				},
			},
			[13]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {141010009,141015001,},
				},
			},
			[90]= {
				["targetChoose"] = 4,
				["state"]= {
				},
				["hitedAnim"] = "end",
			},
			[27]= {
				["targetChoose"] = 4,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {141013001,},
				},
				["hitedAnim"] = "Hit",
			},
			[26]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {141011005,},
				},
				["hitCue"]= {
					["cueList"] = {141010007,},
				},
			},
		},

		["actTime"] = 75,
		["hideEffect"] = 1,
		["videoActTime"] = 70,
		["videoActCue"]= {
			["cueList"] = {141018001,141011004,},
		},
		["hideTime"] = 15,
		["prepareCamera"] = 1,
		["prepareCamDruation"] = 40,
		["skillTarget"] = 5,
	},
	[1410160] = {
		["bhEvent"] = "skill.1410160",
		["atkEvents"]= {
			[100]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {141010006,},
				},
			},
			[0]= {
				["boxId"] = 1410159,
				["state"]= {
				},
				["hitedAnim"] = "Hit",
			},
			[1]= {
				["state"]= {
				},
			},
			[13]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {141019001,141010009,141015001,},
				},
			},
			[2]= {
				["state"]= {
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
					["cueList"] = {141011005,},
				},
				["hitCue"]= {
					["cueList"] = {141010007,},
				},
			},
		},

		["actTime"] = 65,
		["hideEffect"] = 1,
		["videoActTime"] = 70,
		["shortVideoActTime"] = 70,
		["videoActCue"]= {
			["cueList"] = {141018001,141011004,},
		},
		["shortVideoActCue"]= {
			["cueList"] = {141018001,141011004,},
		},
		["prepareCamera"] = 1,
		["prepareCamDruation"] = 110,
	},
	[1410110] = {
		["bhEvent"] = "skill.1410110",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {141011001,141010017,},
				},
			},
			[1]= {
				["unitDelay"] = 0.1,
				["flyCueId"] = 141010018,
				["boxType"] = 1,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {141011002,},
				},
			},
			[0]= {
				["unitDelay"] = 0.1,
				["flyCueId"] = 141010019,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1410109,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {141010003,141011002,},
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
