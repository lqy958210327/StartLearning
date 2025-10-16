local Data = {
["cueFile"] = "12101",
	[1210109] = {
		["bhEvent"] = "skill.1210109",
		["atkEvents"]= {
			[1]= {
				["eventType"] = 1,
				["boxId"] = 1210109,
				["state"]= {
					["stateId"] = 1210102,
					["duration"] = 3,
				},
				["hitCue"]= {
					["cueList"] = {121010011,},
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {121010009,121011001,},
				},
			},
		},

	},
	[1210110] = {
		["bhEvent"] = "skill.1210110",
		["atkEvents"]= {
			[1]= {
				["eventType"] = 1,
				["boxId"] = 1210109,
				["state"]= {
					["stateId"] = 1210102,
					["duration"] = 3,
				},
				["hitCue"]= {
					["cueList"] = {121010011,},
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {121010010,121011002,},
				},
			},
		},

	},
	[1210159] = {
		["bhEvent"] = "skill.1210159",
		["atkEvents"]= {
			[1]= {
				["targetArea"] = 3,
				["boxId"] = 1210160,
				["state"]= {
				},
				["levelAtkEvents"]= {
					[2]= {
					},
					[3]= {
						["state"]= {
							["stateId"] = 1210101,
							["duration"] = 2,
						},
					},
					[4]= {
						["state"]= {
							["stateId"] = 1210101,
							["duration"] = 2,
						},
					},
					[5]= {
					},
					[6]= {
					},
				},

			},
			[0]= {
				["eventType"] = 1,
				["boxId"] = 1210159,
				["state"]= {
					["stateId"] = 1210102,
					["duration"] = 3,
				},
				["hitCue"]= {
					["cueList"] = {121010015,10006003,},
				},
			},
			[2]= {
				["targetArea"] = 3,
				["boxId"] = 1210163,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000025,},
				},
			},
			[1001]= {
				["delay"] = 0.3,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1210162,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {121010008,},
				},
				["disablePassive"] = 1,
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {121010013,121010014,121011003,},
				},
			},
		},

		["actTime"] = 48,
	},
	[1210129] = {
		["bhEvent"] = "skill.1210129",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
			},
			[1001]= {
				["targetArea"] = 3,
				["boxId"] = 1210129,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {121010012,},
				},
				["levelAtkEvents"]= {
					[2]= {
						["hitCue"]= {
							["cueList"] = {10000025,10000035,},
						},
						["addManaNumber"] = 20,
					},
					[3]= {
						["hitCue"]= {
							["cueList"] = {10000025,10000035,},
						},
						["addManaNumber"] = 20,
					},
					[4]= {
						["hitCue"]= {
							["cueList"] = {10000025,},
						},
						["addManaNumber"] = 30,
					},
					[5]= {
						["hitCue"]= {
							["cueList"] = {10000025,},
						},
					},
					[6]= {
						["hitCue"]= {
							["cueList"] = {10000025,},
						},
					},
				},

			},
			[1]= {
				["state"]= {
				},
			},
			[1002]= {
				["targetArea"] = 3,
				["boxId"] = 1210130,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000025,},
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
