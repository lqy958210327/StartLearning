local Data = {
["cueFile"] = "32105",
	[3210501] = {
		["bhEvent"] = "skill.3210501",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {321050001,321051001,},
				},
			},
			[1]= {
				["eventType"] = 1,
				["boxId"] = 3210501,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000062,},
				},
			},
		},

	},
	[3210502] = {
		["bhEvent"] = "skill.3210502",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {321050002,321051002,},
				},
			},
			[1]= {
				["eventType"] = 1,
				["boxId"] = 3210501,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000062,},
				},
			},
		},

	},
	[3210503] = {
		["bhEvent"] = "skill.3210503",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {321050003,321051003,},
				},
			},
			[1]= {
				["targetChoose"] = 1,
				["eventType"] = 1,
				["boxId"] = 3210503,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {321050004,},
				},
			},
		},

	},
	[3210551] = {
		["bhEvent"] = "skill.3210551",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {321050006,321051004,},
				},
			},
			[2]= {
				["state"]= {
				},
			},
			[1]= {
				["eventType"] = 1,
				["boxId"] = 3210551,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {321050007,},
				},
			},
		},

		["actTime"] = 45,
	},
	[3210552] = {
		["bhEvent"] = "skill.3210552",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {321050008,321051005,},
				},
			},
			[1]= {
				["targetArea"] = 3,
				["state"]= {
					["stateOperation"] = 1,
					["chooseStateType"] = 2,
					["chooseStateMode"] = 1,
				},
			},
			[2]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 3210502,
					["duration"] = 7,
				},
			},
			[1001]= {
				["targetArea"] = 3,
				["boxId"] = 3210552,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000047,},
				},
			},
		},

		["actTime"] = 60,
		["skillTarget"] = 1,
	},
	[3210553] = {
		["bhEvent"] = "skill.3210553",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {321050010,321051006,},
				},
			},
			[1]= {
				["targetChoose"] = 1,
				["eventType"] = 1,
				["boxId"] = 3210553,
				["state"]= {
					["stateOperation"] = 1,
					["chooseStateType"] = 1,
					["chooseStateMode"] = 1,
				},
				["hitCue"]= {
					["cueList"] = {321050011,},
				},
			},
		},

		["actTime"] = 40,
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
