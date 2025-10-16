local Data = {
["cueFile"] = "15008",
	[1500809] = {
		["bhEvent"] = "skill.1500809",
		["atkEvents"]= {
			[0]= {
				["unitDelay"] = 0.16,
				["flyCueId"] = 150080003,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1500809,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {150080004,150081002,},
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {150080001,150080002,150081001,},
				},
			},
		},

	},
	[1500810] = {
		["bhEvent"] = "skill.1500809",
		["atkEvents"]= {
			[0]= {
				["unitDelay"] = 0.08,
				["flyCueId"] = 90010003,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1500809,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {150080001,},
				},
			},
			[100]= {
				["state"]= {
				},
			},
		},

	},
	[1500859] = {
		["bhEvent"] = "skill.1500859",
		["atkEvents"]= {
			[0]= {
				["targetArea"] = 3,
				["targetChoose"] = 10,
				["state"]= {
					["stateId"] = 1500801,
					["duration"] = 12,
				},
				["filterChuyin"] = 1,
				["levelAtkEvents"]= {
					[2]= {
					},
					[3]= {
						["state"]= {
							["stateId"] = 1500801,
							["duration"] = 15,
						},
					},
					[4]= {
						["state"]= {
							["stateId"] = 1500801,
							["duration"] = 10,
						},
					},
					[5]= {
						["state"]= {
							["stateId"] = 1500801,
							["duration"] = 10,
						},
					},
					[6]= {
						["state"]= {
							["stateId"] = 1500801,
							["duration"] = 10,
						},
					},
				},

			},
			[1]= {
				["targetArea"] = 3,
				["targetChoose"] = 10,
				["state"]= {
					["stateId"] = 1500802,
					["duration"] = 10,
				},
				["filterChuyin"] = 1,
				["levelAtkEvents"]= {
					[2]= {
					},
					[3]= {
						["state"]= {
							["stateId"] = 1500802,
							["duration"] = 15,
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
			[100]= {
				["targetArea"] = 3,
				["targetChoose"] = 7,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {150080007,},
				},
			},
			[1001]= {
				["targetArea"] = 3,
				["targetChoose"] = 10,
				["state"]= {
					["stateId"] = 1500804,
					["duration"] = -999,
				},
			},
			[12]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {150085001,150080009,150081006,},
				},
			},
			[1002]= {
				["targetArea"] = 3,
				["targetChoose"] = 10,
				["state"]= {
					["stateId"] = 1500892,
					["duration"] = 15,
				},
			},
			[1003]= {
				["targetArea"] = 3,
				["targetChoose"] = 10,
				["state"]= {
					["stateId"] = 1500893,
					["duration"] = 15,
				},
			},
		},

		["actTime"] = 60,
		["hideEffect"] = 1,
		["videoActTime"] = 50,
		["videoActCue"]= {
			["cueList"] = {150088001,150081005,},
		},
		["hideTime"] = 10,
		["prepareCamera"] = 1,
		["prepareCamDruation"] = 30,
		["skillTarget"] = 1,
	},
	[1500829] = {
		["bhEvent"] = "skill.1500829",
		["atkEvents"]= {
			[100]= {
				["targetArea"] = 3,
				["targetChoose"] = 3,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {150080005,150081003,},
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
					["stateId"] = 1500803,
					["duration"] = -999,
				},
				["hitCue"]= {
					["cueList"] = {150080006,150081004,},
				},
			},
		},

		["actTime"] = 30,
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
