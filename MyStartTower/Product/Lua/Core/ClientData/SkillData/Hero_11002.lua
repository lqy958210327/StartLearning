local Data = {
["cueFile"] = "11002",
	[1100201] = {
		["bhEvent"] = "skill.1100201",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {110020005,110021001,},
				},
			},
			[1]= {
				["eventType"] = 1,
				["boxId"] = 1100201,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000062,},
				},
			},
		},

	},
	[1100202] = {
		["bhEvent"] = "skill.1100202",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {110020006,110021002,},
				},
			},
			[1]= {
				["eventType"] = 1,
				["boxId"] = 1100201,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000062,},
				},
			},
		},

	},
	[1100221] = {
		["bhEvent"] = "skill.1100221",
		["atkEvents"]= {
			[100]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1100205,
					["duration"] = 2,
				},
				["atkCue"]= {
					["cueList"] = {110020011,110021003,},
				},
			},
			[1]= {
				["targetArea"] = 2,
				["targetChoose"] = 7,
				["eventType"] = 1,
				["boxId"] = 1100221,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000063,},
				},
			},
			[1001]= {
				["targetArea"] = 3,
				["boxId"] = 1100222,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000025,},
				},
			},
			[1002]= {
				["unitDelay"] = 0.15,
				["flyCueId"] = 110020009,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1100223,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {110020010,},
				},
				["hitCue"]= {
					["cueList"] = {10000063,},
				},
			},
			[1003]= {
				["targetArea"] = 3,
				["boxId"] = 1100254,
				["state"]= {
				},
			},
			[1004]= {
				["targetArea"] = 2,
				["targetChoose"] = 3,
				["boxId"] = 1100252,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000063,},
				},
				["excludeTarget"] = 1,
				["levelAtkEvents"]= {
					[2]= {
						["state"]= {
							["stateId"] = 1100202,
							["duration"] = 1.1,
						},
					},
					[3]= {
						["state"]= {
							["stateId"] = 1100202,
							["duration"] = 1.1,
						},
						["subEventSkill"] = 1100221,
						["subEventId"] = 1003,
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

		["actTime"] = 60,
		["skillTarget"] = 1,
	},
	[1100251] = {
		["bhEvent"] = "skill.1100251",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {110020002,},
				},
			},
			[1]= {
				["targetArea"] = 3,
				["boxId"] = 1100251,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000025,},
				},
			},
			[2]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1100201,
					["duration"] = 8,
				},
			},
			[1001]= {
				["targetArea"] = 2,
				["targetChoose"] = 3,
				["eventType"] = 1,
				["boxId"] = 1100252,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000063,},
				},
				["levelAtkEvents"]= {
					[2]= {
						["state"]= {
							["stateId"] = 1100202,
							["duration"] = 1.1,
						},
					},
					[3]= {
						["state"]= {
							["stateId"] = 1100202,
							["duration"] = 1.1,
						},
						["subEventSkill"] = 1100221,
						["subEventId"] = 1003,
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
				["targetArea"] = 3,
				["boxId"] = 1100254,
				["state"]= {
				},
			},
			[13]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {110020012,110025001,110021006,},
				},
			},
		},

		["actTime"] = 90,
		["hideEffect"] = 1,
		["videoActTime"] = 55,
		["videoActCue"]= {
			["cueList"] = {110028001,110021004,},
		},
		["prepareCamera"] = 1,
		["prepareCamDruation"] = 30,
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
