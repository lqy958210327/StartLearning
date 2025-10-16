local Data = {
["cueFile"] = "33115",
	[3311501] = {
		["bhEvent"] = "skill.3311501",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331150001,331151001,},
				},
			},
			[1]= {
				["eventType"] = 1,
				["boxId"] = 3311501,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000062,},
				},
			},
		},

	},
	[3311502] = {
		["bhEvent"] = "skill.3311502",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331150002,331151002,},
				},
			},
			[1]= {
				["eventType"] = 1,
				["boxId"] = 3311501,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000062,},
				},
			},
			[1001]= {
				["targetArea"] = 3,
				["summonMonsters"] = "90312343,90312342,90312342",
				["state"]= {
				},
			},
		},

	},
	[3311551] = {
		["bhEvent"] = "skill.3311551",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331150003,331151003,},
				},
			},
			[1]= {
				["eventType"] = 1,
				["boxId"] = 3311551,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000062,},
				},
			},
			[2]= {
				["targetArea"] = 3,
				["boxId"] = 3311560,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000008,},
				},
			},
		},

		["actTime"] = 55,
	},
	[3311552] = {
		["bhEvent"] = "skill.3311552",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331150004,331151004,},
				},
			},
			[1]= {
				["eventType"] = 1,
				["boxId"] = 3311552,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331150005,},
				},
				["hitCue"]= {
					["cueList"] = {331150007,331151005,},
				},
				["controlTime"] = 0.51,
			},
			[15]= {
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331150006,},
				},
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
