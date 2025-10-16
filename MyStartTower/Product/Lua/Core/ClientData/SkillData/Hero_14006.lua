local Data = {
["cueFile"] = "14006",
	[1400609] = {
		["bhEvent"] = "skill.1400609",
		["atkEvents"]= {
			[0]= {
				["unitDelay"] = 0.12,
				["eventType"] = 1,
				["boxId"] = 1400609,
				["state"]= {
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {140060001,140061001,},
				},
				["hitCue"]= {
					["cueList"] = {140060003,},
				},
			},
			[11]= {
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {140060002,},
				},
			},
		},

	},
	[1400629] = {
		["bhEvent"] = "skill.1400629",
		["atkEvents"]= {
			[100]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1400601,
					["duration"] = 3,
				},
				["atkCue"]= {
					["cueList"] = {140060008,140061005,},
				},
			},
			[0]= {
				["targetChoose"] = 7,
				["unitDelay"] = 0.12,
				["flyCueId"] = 140060009,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1400629,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {140060010,140061006,},
				},
				["randomTargetNumber"] = 2,
			},
		},

	},
	[1400659] = {
		["bhEvent"] = "skill.1400659",
		["atkEvents"]= {
			[100]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {140060005,140060011,},
				},
			},
			[2]= {
				["targetChoose"] = 7,
				["eventType"] = 1,
				["boxId"] = 1400659,
				["state"]= {
					["stateProbId"] = 1400601,
					["stateId"] = 1000003,
					["duration"] = 8,
				},
				["atkCue"]= {
					["cueList"] = {140063001,},
				},
				["hitCue"]= {
					["cueList"] = {140060006,140061004,},
				},
				["hitedAnim"] = "Hit",
				["levelAtkEvents"]= {
					[2]= {
					},
					[3]= {
						["addManaNumber"] = -15,
					},
					[4]= {
					},
					[5]= {
					},
					[6]= {
					},
				},

			},
			[21]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {140060007,140065001,},
				},
			},
			[22]= {
				["delay"] = 0.5,
				["flyCueId"] = 140060012,
				["boxType"] = 1,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {140060013,140063001,},
				},
			},
			[1001]= {
				["state"]= {
				},
				["controlTime"] = 2,
				["controlAniName"] = "freeze",
				["levelAtkEvents"]= {
					[2]= {
					},
					[3]= {
						["controlTime"] = 3,
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
				["targetChoose"] = 7,
				["state"]= {
				},
			},
			[90]= {
				["targetChoose"] = 7,
				["state"]= {
				},
				["hitedAnim"] = "end",
			},
		},

		["actTime"] = 70,
		["hideEffect"] = 1,
		["videoActTime"] = 40,
		["videoActCue"]= {
			["cueList"] = {140068001,140061003,},
		},
		["hideTime"] = 10,
		["hideEvent"] = 2,
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
