local Data = {
["cueFile"] = "15003",
	[1500309] = {
		["bhEvent"] = "skill.1500309",
		["atkEvents"]= {
			[0]= {
				["unitDelay"] = 0.12,
				["flyCueId"] = 150030001,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1500309,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {150030002,150031004,},
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {150030008,},
				},
			},
		},

	},
	[1500310] = {
		["bhEvent"] = "skill.1500310",
		["atkEvents"]= {
			[0]= {
				["unitDelay"] = 0.08,
				["flyCueId"] = 90010003,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1500309,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {150030001,},
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {150030008,},
				},
			},
		},

	},
	[1500359] = {
		["bhEvent"] = "skill.1500359",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {150035001,150030005,},
				},
			},
			[0]= {
				["targetArea"] = 3,
				["targetChoose"] = 7,
				["state"]= {
					["stateId"] = 1500301,
					["duration"] = -999,
				},
			},
			[1]= {
				["targetArea"] = 3,
				["targetChoose"] = 7,
				["boxId"] = 1500359,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {150030004,150031003,},
				},
			},
			[2]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["levelAtkEvents"]= {
					[2]= {
						["state"]= {
							["stateId"] = 1500302,
							["duration"] = 5,
						},
					},
					[3]= {
						["state"]= {
							["stateId"] = 1500302,
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
			[99]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {150030006,150030007,},
				},
			},
		},

		["actTime"] = 60,
		["hideEffect"] = 1,
		["videoActTime"] = 39,
		["videoActCue"]= {
			["cueList"] = {150038002,150031006,},
		},
		["hideTime"] = 10,
		["prepareCamera"] = 1,
		["prepareCamDruation"] = 30,
	},
	[1500329] = {
		["bhEvent"] = "skill.1500329",
		["atkEvents"]= {
			[100]= {
				["targetArea"] = 3,
				["targetChoose"] = 3,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {150030009,150030010,},
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
					["stateId"] = 1500303,
					["duration"] = -999,
				},
				["hitCue"]= {
					["cueList"] = {150030003,150031005,},
				},
			},
		},

		["actTime"] = 51,
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
