local Data = {
["cueFile"] = "15006",
	[1500609] = {
		["bhEvent"] = "skill.1500609",
		["atkEvents"]= {
			[0]= {
				["unitDelay"] = 0.12,
				["flyCueId"] = 150060002,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1500609,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {150060003,150061002,},
				},
			},
			[1001]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000035,},
				},
				["addManaNumber"] = 10,
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {150061001,},
				},
			},
		},

	},
	[1500659] = {
		["bhEvent"] = "skill.1500659",
		["atkEvents"]= {
			[100]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {150060006,150060007,},
				},
			},
			[0]= {
				["targetArea"] = 3,
				["targetChoose"] = 10,
				["boxId"] = 1500660,
				["state"]= {
					["stateId"] = 1500601,
					["duration"] = 5,
				},
				["hitCue"]= {
					["cueList"] = {150060008,150061007,},
				},
			},
			[1]= {
				["targetArea"] = 2,
				["targetChoose"] = 7,
				["state"]= {
					["stateId"] = 1000001,
					["duration"] = 5,
				},
			},
			[11]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {150065001,150060009,150061006,},
				},
			},
		},

		["actTime"] = 61,
		["hideEffect"] = 1,
		["videoActTime"] = 70,
		["videoActCue"]= {
			["cueList"] = {150068001,150061005,},
		},
		["hideTime"] = 10,
		["prepareCamera"] = 1,
		["prepareCamDruation"] = 40,
		["skillTarget"] = 1,
	},
	[1500629] = {
		["bhEvent"] = "skill.1500629",
		["atkEvents"]= {
			[100]= {
				["targetArea"] = 3,
				["targetChoose"] = 3,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {150060004,150061003,},
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
				["targetChoose"] = 4,
				["state"]= {
				},
				["excludeTarget"] = 1,
				["levelAtkEvents"]= {
					[2]= {
					},
					[3]= {
						["state"]= {
							["stateId"] = 1500603,
							["duration"] = -999,
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
			[0]= {
				["targetArea"] = 3,
				["targetChoose"] = 12,
				["state"]= {
					["stateId"] = 1500602,
					["duration"] = -999,
				},
				["hitCue"]= {
					["cueList"] = {150060005,150061004,},
				},
			},
		},

		["actTime"] = 40,
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
