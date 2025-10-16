local Data = {
["cueFile"] = "33110",
	[3311001] = {
		["bhEvent"] = "skill.3311001",
		["atkEvents"]= {
			[1]= {
				["unitDelay"] = 0.12,
				["flyCueId"] = 331100012,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3311001,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000062,331101002,},
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331100011,331101001,},
				},
			},
		},

	},
	[3311002] = {
		["bhEvent"] = "skill.3311002",
		["atkEvents"]= {
			[1]= {
				["delay"] = 0.4,
				["flyCueId"] = 331100015,
				["boxType"] = 1,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331100016,},
				},
			},
			[2]= {
				["targetChoose"] = 3,
				["eventType"] = 1,
				["boxId"] = 3311002,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331100026,},
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331100014,},
				},
			},
		},

	},
	[3311029] = {
		["bhEvent"] = "skill.3311029",
		["atkEvents"]= {
			[1]= {
				["targetArea"] = 3,
				["targetChoose"] = 3,
				["delay"] = 0.1,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3311029,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {10005008,10003001,},
				},
				["hitCue"]= {
					["cueList"] = {331100002,},
				},
				["excludeTarget"] = 1,
			},
			[10]= {
				["targetArea"] = 3,
				["state"]= {
					["stateOperation"] = 1,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {3311001,},
				},
				["atkCue"]= {
					["cueList"] = {10006006,},
				},
			},
			[2]= {
				["targetArea"] = 3,
				["eventType"] = 1,
				["boxId"] = 3311060,
				["state"]= {
				},
			},
			[1001]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["addManaNumber"] = -100,
				["manaNotShow"] = 1,
				["controlTime"] = 0.1,
				["controlAniName"] = "idle",
			},
			[100]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {10005003,331100001,331101003,},
				},
			},
		},

		["actTime"] = 63,
		["skillTarget"] = 1,
	},
	[3311051] = {
		["bhEvent"] = "skill.3311051",
		["atkEvents"]= {
			[1]= {
				["eventType"] = 1,
				["boxId"] = 3311051,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331100007,331101004,},
				},
				["hitCue"]= {
					["cueList"] = {331100008,331100009,},
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331100007,},
				},
				["hitCue"]= {
					["cueList"] = {331100027,},
				},
			},
			[90]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331100010,},
				},
			},
		},

		["actTime"] = 16,
	},
	[3311052] = {
		["bhEvent"] = "skill.3311052",
		["atkEvents"]= {
			[1]= {
				["delay"] = 0.6,
				["flyCueId"] = 331100018,
				["boxType"] = 1,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331100020,331101006,},
				},
			},
			[2]= {
				["targetChoose"] = 3,
				["eventType"] = 1,
				["boxId"] = 3311052,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331100021,},
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331100017,331101005,},
				},
				["hitCue"]= {
					["cueList"] = {331100019,},
				},
			},
		},

		["actTime"] = 60,
	},
	[3311053] = {
		["bhEvent"] = "skill.3311053",
		["atkEvents"]= {
			[1]= {
				["targetChoose"] = 7,
				["eventType"] = 1,
				["boxId"] = 3311053,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331100005,},
				},
				["hitCue"]= {
					["cueList"] = {331100006,},
				},
			},
			[2]= {
				["targetArea"] = 3,
				["boxId"] = 3311060,
				["state"]= {
					["stateOperation"] = 1,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {3311001,},
				},
				["atkCue"]= {
					["cueList"] = {10006006,},
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331100003,331100004,331101007,},
				},
			},
		},

		["actTime"] = 40,
	},
	[3311054] = {
		["bhEvent"] = "skill.3311054",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331100003,331100004,331101007,},
				},
			},
			[1]= {
				["eventType"] = 1,
				["boxId"] = 3311054,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331100005,},
				},
				["hitCue"]= {
					["cueList"] = {331100006,},
				},
			},
			[2]= {
				["targetArea"] = 3,
				["eventType"] = 1,
				["boxId"] = 3311061,
				["state"]= {
					["stateOperation"] = 1,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {3311001,},
				},
				["atkCue"]= {
					["cueList"] = {10006006,},
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
