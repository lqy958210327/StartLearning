local Data = {
["cueFile"] = "15007",
	[1500709] = {
		["bhEvent"] = "skill.1500709",
		["atkEvents"]= {
			[1]= {
				["unitDelay"] = 0.15,
				["flyCueId"] = 150070001,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1500709,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {150070002,150071002,},
				},
			},
		},

	},
	[1500729] = {
		["bhEvent"] = "skill.1500729",
		["atkEvents"]= {
			[1]= {
				["targetArea"] = 3,
				["targetChoose"] = 12,
				["state"]= {
					["stateId"] = 1500702,
					["duration"] = -999,
				},
			},
			[100]= {
				["targetArea"] = 3,
				["targetChoose"] = 4,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {150071003,},
				},
				["excludeTarget"] = 1,
				["recordSkillTargets"] = 1,
				["levelAtkEvents"]= {
					[2]= {
						["targetChoose"] = 3,
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
		},

		["actTime"] = 15,
		["skillTarget"] = 1,
	},
	[1500759] = {
		["bhEvent"] = "skill.1500759",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {150070001,150070001,},
				},
			},
			[0]= {
				["targetArea"] = 3,
				["targetChoose"] = 4,
				["state"]= {
					["stateId"] = 1500701,
					["duration"] = 10,
				},
				["hitCue"]= {
					["cueList"] = {10000001,},
				},
				["randomTargetNumber"] = 1,
				["randomRule"] = 1,
			},
			[10]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {150070003,150071004,},
				},
			},
			[1]= {
				["targetArea"] = 3,
				["targetChoose"] = 4,
				["state"]= {
					["stateId"] = 1500701,
					["duration"] = 10,
				},
				["hitCue"]= {
					["cueList"] = {150070004,},
				},
				["randomTargetNumber"] = 1,
				["randomRule"] = 1,
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
