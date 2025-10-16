local Data = {
["cueFile"] = "33121",
	[3312101] = {
		["bhEvent"] = "skill.3312101",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331210001,331211001,},
				},
			},
			[1]= {
				["unitDelay"] = 0.12,
				["flyCueId"] = 331210002,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3312101,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000062,331211002,},
				},
			},
		},

	},
	[3312121] = {
		["bhEvent"] = "skill.3312121",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331210005,331211004,},
				},
			},
			[1]= {
				["unitDelay"] = 0.12,
				["flyCueId"] = 331210006,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3312121,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331210007,},
				},
			},
			[1001]= {
				["targetArea"] = 3,
				["targetChoose"] = 7,
				["delay"] = 0.5,
				["boxType"] = 1,
				["boxId"] = 3312122,
				["state"]= {
					["stateId"] = 3312102,
					["duration"] = -999,
				},
				["atkCue"]= {
					["cueList"] = {331210003,331211003,},
				},
				["hitCue"]= {
					["cueList"] = {10000008,331210004,},
				},
			},
		},

	},
	[3312151] = {
		["bhEvent"] = "skill.3312151",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331210009,331211005,},
				},
			},
			[1]= {
				["targetChoose"] = 7,
				["eventType"] = 1,
				["boxId"] = 3312151,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331210010,331211006,},
				},
				["randomTargetNumber"] = 1,
				["randomRule"] = 1,
			},
			[2]= {
				["targetChoose"] = 7,
				["eventType"] = 1,
				["boxId"] = 3312151,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331210010,},
				},
				["randomTargetNumber"] = 1,
				["randomRule"] = 1,
				["eventCondition"] = "1,1,3312111",
			},
			[3]= {
				["targetChoose"] = 7,
				["eventType"] = 1,
				["boxId"] = 3312151,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331210010,},
				},
				["randomTargetNumber"] = 1,
				["eventCondition"] = "1,1,3312112",
			},
			[4]= {
				["targetChoose"] = 7,
				["eventType"] = 1,
				["boxId"] = 3312151,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331210010,},
				},
				["randomTargetNumber"] = 1,
				["eventCondition"] = "1,1,3312113",
			},
			[5]= {
				["targetChoose"] = 7,
				["eventType"] = 1,
				["boxId"] = 3312151,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331210009,},
				},
				["randomTargetNumber"] = 1,
				["eventCondition"] = "1,1,3312114",
			},
			[6]= {
				["targetChoose"] = 7,
				["eventType"] = 1,
				["boxId"] = 3312151,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331210010,},
				},
				["randomTargetNumber"] = 1,
				["eventCondition"] = "1,1,3312115",
			},
			[1001]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 3312111,
					["duration"] = -999,
				},
			},
			[1002]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 3312112,
					["duration"] = -999,
				},
			},
			[1003]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 3312113,
					["duration"] = -999,
				},
			},
			[1004]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 3312114,
					["duration"] = -999,
				},
			},
			[1005]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 3312115,
					["duration"] = -999,
				},
			},
		},

		["actTime"] = 50,
		["skillTarget"] = 1,
	},
	[3312152] = {
		["bhEvent"] = "skill.3312152",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331210009,331211005,},
				},
			},
			[1]= {
				["state"]= {
				},
			},
			[2]= {
				["targetChoose"] = 7,
				["eventType"] = 1,
				["boxId"] = 3312152,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331210010,331211006,},
				},
				["randomTargetNumber"] = 3,
				["randomRule"] = 2,
			},
		},

		["actTime"] = 50,
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
