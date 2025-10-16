local Data = {
["cueFile"] = "15201",
	[1520109] = {
		["bhEvent"] = "skill.1520109",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {152010001,152010002,152011001,},
				},
			},
			[1]= {
				["unitDelay"] = 0.15,
				["flyCueId"] = 152010005,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1520109,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {152010006,152011004,},
				},
			},
		},

	},
	[1520110] = {
		["bhEvent"] = "skill.1520110",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {152010003,152010004,152011003,},
				},
			},
			[1]= {
				["unitDelay"] = 0.15,
				["flyCueId"] = 152010019,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1520109,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {152010006,152011004,},
				},
			},
		},

	},
	[1520129] = {
		["bhEvent"] = "skill.1520129",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {152010007,152010008,152010009,152010010,152011005,},
				},
			},
			[1]= {
				["targetArea"] = 3,
				["targetChoose"] = 3,
				["state"]= {
					["stateId"] = 1520105,
					["duration"] = -999,
				},
				["levelAtkEvents"]= {
					[2]= {
					},
					[3]= {
						["targetChoose"] = 7,
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
				["targetChoose"] = 3,
				["state"]= {
					["stateId"] = 1520106,
					["duration"] = -999,
				},
				["eventCondition"] = "1,2,1520105",
				["levelAtkEvents"]= {
					[2]= {
					},
					[3]= {
						["targetChoose"] = 7,
					},
					[4]= {
					},
					[5]= {
					},
					[6]= {
					},
				},

			},
			[3]= {
				["targetArea"] = 3,
				["targetChoose"] = 3,
				["state"]= {
					["stateId"] = 8350012,
					["duration"] = -999,
				},
				["eventCondition"] = "1,2,1520105",
				["levelAtkEvents"]= {
					[2]= {
					},
					[3]= {
						["targetChoose"] = 10,
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
				["addManaNumber"] = 30,
			},
		},

		["actTime"] = 45,
		["skillTarget"] = 1,
	},
	[1520159] = {
		["bhEvent"] = "skill.1520159",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {152010013,152010014,152010015,152010012,},
				},
			},
			[1]= {
				["targetChoose"] = 7,
				["eventType"] = 1,
				["boxId"] = 1520160,
				["state"]= {
					["stateId"] = 1520107,
					["duration"] = 20,
				},
				["hitCue"]= {
					["cueList"] = {152010017,},
				},
			},
			[1001]= {
				["targetChoose"] = 7,
				["boxId"] = 1520151,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {10000025,},
				},
				["hitCue"]= {
					["cueList"] = {10000024,},
				},
				["baseCue"]= {
					["cueList"] = {10000056,},
				},
				["excludeTarget"] = 1,
			},
			[1002]= {
				["boxId"] = 1520161,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000078,},
				},
				["eventCondition"] = "1,2,1000001",
			},
			[10]= {
				["targetChoose"] = 7,
				["state"]= {
				},
			},
			[13]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {152010018,152015001,152011007,},
				},
				["weatherFlag"] = 1520101,
				["weatherTime"] = 10,
				["levelAtkEvents"]= {
					[2]= {
						["weatherFlag"] = 1520102,
					},
					[3]= {
						["weatherFlag"] = 1520103,
						["weatherTime"] = 12,
					},
					[4]= {
						["weatherTime"] = 8,
					},
					[5]= {
						["weatherTime"] = 8,
					},
					[6]= {
						["weatherTime"] = 8,
					},
				},

			},
			[11]= {
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {152010016,},
				},
			},
			[99]= {
				["state"]= {
				},
			},
		},

		["actTime"] = 81,
		["videoActTime"] = 75,
		["videoActCue"]= {
			["cueList"] = {152018001,152011006,},
		},
		["hideTime"] = 10,
		["hideEvent"] = 10,
		["prepareCamera"] = 1,
		["prepareCamDruation"] = 35,
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
