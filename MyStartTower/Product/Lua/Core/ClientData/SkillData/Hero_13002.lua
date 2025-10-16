local Data = {
["cueFile"] = "13002",
	[1300209] = {
		["bhEvent"] = "skill.1300209",
		["atkEvents"]= {
			[0]= {
				["unitDelay"] = 0.08,
				["flyCueId"] = 130020001,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1300209,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {130020002,130021003,},
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {130021005,},
				},
			},
		},

	},
	[1300221] = {
		["bhEvent"] = "skill.1300221",
		["atkEvents"]= {
			[0]= {
				["state"]= {
				},
			},
			[1001]= {
				["targetChoose"] = 7,
				["eventType"] = 1,
				["boxId"] = 1300229,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {130020004,},
				},
				["disablePassive"] = 1,
			},
			[1002]= {
				["targetChoose"] = 7,
				["eventType"] = 1,
				["boxId"] = 1300230,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {130020004,},
				},
				["disablePassive"] = 1,
			},
		},

	},
	[1300259] = {
		["bhEvent"] = "skill.1300259",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {130020007,},
				},
			},
			[2]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1300201,
					["duration"] = 0.2,
				},
				["addManaNumber"] = -100,
				["manaNotShow"] = 1,
			},
			[10]= {
				["unitDelay"] = 0.12,
				["flyCueId"] = 130020008,
				["boxType"] = 1,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {130020004,130021002,},
				},
				["hitedAnim"] = "Hit",
			},
			[1]= {
				["unitDelay"] = 0.12,
				["flyCueId"] = 130020008,
				["eventType"] = 1,
				["boxId"] = 1300259,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {130021002,130020004,10006003,},
				},
				["hitedAnim"] = "Hit",
			},
			[11]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {130020005,130025001,},
				},
			},
			[90]= {
				["state"]= {
				},
				["hitedAnim"] = "end",
			},
		},

		["actTime"] = 50,
		["hideEffect"] = 1,
		["videoActTime"] = 49,
		["videoActCue"]= {
			["cueList"] = {130028002,130021004,},
		},
		["prepareCamera"] = 1,
		["prepareCamDruation"] = 20,
		["skillTarget"] = 4,
	},
	[1300271] = {
		["bhEvent"] = "skill.1300271",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {130020006,130025002,},
				},
			},
			[2]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1300201,
					["duration"] = 1.8,
				},
				["addManaNumber"] = -100,
				["manaNotShow"] = 1,
			},
			[10]= {
				["unitDelay"] = 0.12,
				["flyCueId"] = 130020008,
				["boxType"] = 1,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {130020004,130021002,},
				},
				["hitedAnim"] = "Hit",
			},
			[1]= {
				["unitDelay"] = 0.12,
				["flyCueId"] = 130020008,
				["eventType"] = 1,
				["boxId"] = 1300259,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {130020004,130021002,10006003,},
				},
				["hitedAnim"] = "Hit",
			},
			[11]= {
				["state"]= {
				},
			},
			[0]= {
				["state"]= {
				},
			},
			[90]= {
				["state"]= {
				},
				["hitedAnim"] = "end",
			},
		},

		["actTime"] = 50,
		["hideEffect"] = 1,
		["prepareCamera"] = 1,
		["prepareCamDruation"] = 20,
		["skillTarget"] = 4,
	},
	[1300210] = {
		["bhEvent"] = "skill.1300210",
		["atkEvents"]= {
			[0]= {
				["targetChoose"] = 9,
				["unitDelay"] = 0.08,
				["flyCueId"] = 130020001,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1300209,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {130020002,130021003,},
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {130021005,},
				},
			},
		},

		["skillTarget"] = 2,
	},
	[1300291] = {
		["bhEvent"] = "skill.1300291",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {130020007,},
				},
			},
			[10]= {
				["unitDelay"] = 0.12,
				["flyCueId"] = 130020008,
				["boxType"] = 1,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {130021002,130020004,},
				},
			},
			[1]= {
				["boxId"] = 1300259,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {130020004,130021002,},
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
