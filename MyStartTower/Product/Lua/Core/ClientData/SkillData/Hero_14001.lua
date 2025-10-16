local Data = {
["cueFile"] = "33108",
	[1400109] = {
		["bhEvent"] = "skill.1400109",
		["atkEvents"]= {
			[0]= {
				["unitDelay"] = 0.08,
				["flyCueId"] = 331080002,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1400109,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331080003,331081002,},
				},
			},
			[1]= {
				["unitDelay"] = 0.08,
				["flyCueId"] = 331080002,
				["boxType"] = 1,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331080003,331081002,},
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331080001,331081001,},
				},
			},
		},

	},
	[1400110] = {
		["bhEvent"] = "skill.1400110",
		["atkEvents"]= {
			[0]= {
				["unitDelay"] = 0.08,
				["flyCueId"] = 90010002,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1400109,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {130080001,130081002,},
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {140010002,},
				},
			},
			[1]= {
				["unitDelay"] = 0.08,
				["flyCueId"] = 140010003,
				["boxType"] = 1,
				["boxId"] = 1400109,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {140010005,},
				},
			},
		},

	},
	[1400129] = {
		["bhEvent"] = "skill.1400129",
		["atkEvents"]= {
			[0]= {
				["targetArea"] = 2,
				["targetChoose"] = 4,
				["delay"] = 0.5,
				["flyCueId"] = 90010021,
				["boxType"] = 1,
				["boxId"] = 1400129,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331080001,},
				},
			},
			[1001]= {
				["targetArea"] = 3,
				["targetChoose"] = 7,
				["boxId"] = 1400129,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000008,},
				},
			},
			[1002]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1400102,
					["duration"] = 0.1,
				},
			},
			[1003]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["addManaNumber"] = 30,
			},
		},

		["actTime"] = 40,
	},
	[1400159] = {
		["bhEvent"] = "skill.1400159",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331080015,331081003,},
				},
			},
			[1001]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["addManaNumber"] = 20,
			},
			[1]= {
				["eventType"] = 1,
				["state"]= {
					["stateId"] = 1400101,
					["duration"] = 10,
				},
				["levelAtkEvents"]= {
					[2]= {
					},
					[3]= {
						["state"]= {
							["stateId"] = 1400101,
							["duration"] = 15,
						},
					},
					[4]= {
						["state"]= {
							["stateId"] = 1400101,
							["duration"] = 15,
						},
					},
					[5]= {
						["state"]= {
							["stateId"] = 1400101,
							["duration"] = 15,
						},
					},
					[6]= {
					},
				},

			},
			[11]= {
				["unitDelay"] = 0.12,
				["flyCueId"] = 331080017,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1400159,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331080016,331081004,},
				},
			},
			[12]= {
				["state"]= {
				},
			},
		},

		["actTime"] = 60,
		["hideEvent"] = 100,
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
