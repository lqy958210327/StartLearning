local Data = {
["cueFile"] = "33111",
	[3311101] = {
		["bhEvent"] = "skill.3311101",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331110001,331111001,},
				},
			},
			[1]= {
				["eventType"] = 1,
				["boxId"] = 3311101,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331110002,331111002,},
				},
			},
		},

	},
	[3311102] = {
		["bhEvent"] = "skill.3311102",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331110003,331111001,},
				},
			},
			[1]= {
				["eventType"] = 1,
				["boxId"] = 3311101,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331110004,331111002,},
				},
			},
		},

	},
	[3311151] = {
		["bhEvent"] = "skill.3311151",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331110005,331110006,331111003,},
				},
			},
			[1]= {
				["eventType"] = 1,
				["boxId"] = 3311151,
				["state"]= {
					["stateId"] = 3311102,
					["duration"] = 5,
				},
				["hitCue"]= {
					["cueList"] = {331110007,331111004,},
				},
			},
			[2]= {
				["state"]= {
					["stateId"] = 1000001,
					["duration"] = 5,
				},
			},
		},

		["actTime"] = 50,
	},
	[3311152] = {
		["bhEvent"] = "skill.3311152",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331110013,331111005,},
				},
			},
			[1]= {
				["targetChoose"] = 2,
				["eventType"] = 1,
				["boxId"] = 3311152,
				["state"]= {
					["stateId"] = 3311102,
					["duration"] = 5,
				},
				["hitCue"]= {
					["cueList"] = {331110014,},
				},
			},
			[2]= {
				["targetChoose"] = 2,
				["state"]= {
					["stateId"] = 1000001,
					["duration"] = 5,
				},
			},
		},

		["actTime"] = 40,
	},
	[3311153] = {
		["bhEvent"] = "skill.3311153",
		["atkEvents"]= {
			[1]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 3311101,
					["duration"] = 8,
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331110017,331110019,331110020,331110021,331111006,},
				},
			},
		},

		["actTime"] = 60,
		["skillTarget"] = 1,
	},
	[3311154] = {
		["bhEvent"] = "skill.3311154",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331110009,331110010,331111003,},
				},
			},
			[1]= {
				["eventType"] = 1,
				["boxId"] = 3311151,
				["state"]= {
					["stateId"] = 3311103,
					["duration"] = 5,
				},
				["hitCue"]= {
					["cueList"] = {331110011,331111004,},
				},
			},
			[2]= {
				["state"]= {
					["stateId"] = 1000003,
					["duration"] = 5,
				},
			},
		},

		["actTime"] = 50,
	},
	[3311155] = {
		["bhEvent"] = "skill.3311155",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331110015,331111005,},
				},
			},
			[1]= {
				["targetChoose"] = 2,
				["eventType"] = 1,
				["boxId"] = 3311152,
				["state"]= {
					["stateId"] = 3311103,
					["duration"] = 5,
				},
				["hitCue"]= {
					["cueList"] = {331110016,},
				},
			},
			[2]= {
				["targetChoose"] = 2,
				["state"]= {
					["stateId"] = 1000003,
					["duration"] = 5,
				},
			},
		},

		["actTime"] = 40,
	},
	[3311121] = {
		["bhEvent"] = "skill.3311121",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331110017,331110019,331110020,331110021,331111006,},
				},
			},
			[1]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 3311101,
					["duration"] = 8,
				},
			},
			[1001]= {
				["targetArea"] = 3,
				["boxId"] = 3311121,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000047,},
				},
			},
		},

		["skillTarget"] = 1,
	},
	[3311122] = {
		["bhEvent"] = "skill.3311122",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331110013,331111005,},
				},
			},
			[1]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 3311104,
					["duration"] = 3,
				},
			},
			[2]= {
				["targetChoose"] = 2,
				["eventType"] = 1,
				["boxId"] = 3311122,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331110014,},
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
