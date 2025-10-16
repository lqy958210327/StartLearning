local Data = {
["cueFile"] = "33112",
	[3311201] = {
		["bhEvent"] = "skill.3311201",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331120001,331121001,},
				},
			},
			[1]= {
				["unitDelay"] = 0.12,
				["flyCueId"] = 331120002,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3311201,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331120003,331121002,},
				},
			},
		},

	},
	[3311202] = {
		["bhEvent"] = "skill.3311202",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331120004,331121003,},
				},
			},
			[1]= {
				["unitDelay"] = 0.12,
				["flyCueId"] = 331120005,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3311202,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331120006,},
				},
			},
			[2]= {
				["unitDelay"] = 0.12,
				["flyCueId"] = 331120005,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3311202,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331120007,331121004,},
				},
			},
		},

	},
	[3311251] = {
		["bhEvent"] = "skill.3311251",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331120008,331121005,},
				},
				["hitCue"]= {
					["cueList"] = {331120009,},
				},
			},
			[1]= {
				["delay"] = 0.3,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3311251,
				["state"]= {
					["stateId"] = 3311202,
					["duration"] = 5,
				},
				["hitCue"]= {
					["cueList"] = {331120010,331121006,},
				},
			},
			[1001]= {
				["boxId"] = 3311254,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331120003,},
				},
			},
		},

		["actTime"] = 80,
		["skillTarget"] = 2,
	},
	[3311252] = {
		["bhEvent"] = "skill.3311252",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331120013,331121007,},
				},
			},
			[1]= {
				["unitDelay"] = 0.12,
				["flyCueId"] = 331120014,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3311252,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331120016,331121008,},
				},
			},
			[99]= {
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331120015,},
				},
			},
		},

		["actTime"] = 65,
	},
	[3311253] = {
		["bhEvent"] = "skill.3311253",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331120017,331121009,},
				},
			},
			[1]= {
				["state"]= {
					["stateId"] = 3311201,
					["duration"] = 8,
				},
			},
		},

		["actTime"] = 75,
		["skillTarget"] = 1,
	},
	[3311254] = {
		["bhEvent"] = "skill.3311254",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331120008,331121005,},
				},
				["hitCue"]= {
					["cueList"] = {331120011,},
				},
			},
			[1]= {
				["targetChoose"] = 3,
				["delay"] = 0.3,
				["boxType"] = 1,
				["boxId"] = 3311253,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331120012,331121006,},
				},
			},
		},

		["actTime"] = 80,
	},
	[3311255] = {
		["bhEvent"] = "skill.3311255",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331120008,331121005,},
				},
				["hitCue"]= {
					["cueList"] = {331120009,},
				},
			},
			[101]= {
				["targetChoose"] = 9,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331120009,},
				},
			},
			[1]= {
				["delay"] = 0.3,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3311255,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331120010,331121006,},
				},
			},
			[2]= {
				["targetChoose"] = 9,
				["delay"] = 0.3,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3311255,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331120010,331121006,},
				},
			},
		},

		["actTime"] = 80,
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
