local Data = {
["cueFile"] = "33120",
	[3312001] = {
		["bhEvent"] = "skill.3312001",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331200001,331201001,},
				},
			},
			[1]= {
				["unitDelay"] = 0.2,
				["flyCueId"] = 331200002,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3312001,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000062,331201002,},
				},
			},
		},

	},
	[3312002] = {
		["bhEvent"] = "skill.3312002",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331200003,331201001,},
				},
			},
			[1]= {
				["unitDelay"] = 0.15,
				["flyCueId"] = 331200004,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3312001,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000062,331201002,},
				},
				["subEventSkill"] = 3312002,
				["subEventId"] = 1001,
			},
			[1001]= {
				["targetChoose"] = 3,
				["unitDelay"] = 0.24,
				["flyCueId"] = 331200005,
				["baseToTarget"] = 1,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3312001,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000062,},
				},
				["randomTargetNumber"] = 1,
				["excludeTarget"] = 1,
				["subEventSkill"] = 3312002,
				["subEventId"] = 1002,
			},
			[1002]= {
				["targetChoose"] = 3,
				["unitDelay"] = 0.24,
				["flyCueId"] = 331200005,
				["baseToTarget"] = 1,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3312001,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000062,},
				},
				["randomTargetNumber"] = 1,
				["excludeTarget"] = 1,
				["subEventSkill"] = 3312002,
				["subEventId"] = 1003,
			},
			[1003]= {
				["targetChoose"] = 3,
				["unitDelay"] = 0.24,
				["flyCueId"] = 331200005,
				["baseToTarget"] = 1,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3312001,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000062,},
				},
				["randomTargetNumber"] = 1,
				["excludeTarget"] = 1,
			},
		},

	},
	[3312021] = {
		["bhEvent"] = "skill.3312021",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331200006,331201003,},
				},
			},
			[1]= {
				["targetArea"] = 3,
				["summonMonsters"] = "3312010",
				["state"]= {
				},
			},
			[1001]= {
				["state"]= {
					["stateId"] = 3312001,
					["duration"] = 0.5,
				},
				["stunTime"] = 0.5,
			},
		},

		["skillTarget"] = 1,
	},
	[3312051] = {
		["bhEvent"] = "skill.3312051",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331200007,331200008,331201004,},
				},
			},
			[1]= {
				["targetChoose"] = 7,
				["unitDelay"] = 0.25,
				["flyCueId"] = 10000067,
				["eventType"] = 1,
				["boxId"] = 3312051,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331200010,},
				},
				["stunTime"] = 1,
				["randomTargetNumber"] = 3,
				["randomRule"] = 2,
			},
			[2]= {
				["targetChoose"] = 7,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331200009,},
				},
			},
		},

		["actTime"] = 66,
	},
	[3312052] = {
		["bhEvent"] = "skill.3312052",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331201005,331201006,},
				},
			},
			[1]= {
				["targetChoose"] = 7,
				["unitDelay"] = 0.12,
				["flyCueId"] = 331200012,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3312052,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331200011,},
				},
				["hitCue"]= {
					["cueList"] = {331200013,331201007,},
				},
				["randomTargetNumber"] = 1,
			},
		},

		["actTime"] = 50,
	},
	[3312053] = {
		["bhEvent"] = "skill.3312053",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331201005,331201006,},
				},
			},
			[1]= {
				["targetChoose"] = 7,
				["unitDelay"] = 0.15,
				["flyCueId"] = 331200012,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3312053,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331200014,},
				},
				["hitCue"]= {
					["cueList"] = {331200013,331201007,},
				},
			},
		},

		["actTime"] = 50,
		["skillTarget"] = 1,
	},
	[3312054] = {
		["bhEvent"] = "skill.3312021",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000008,},
				},
			},
			[1]= {
				["targetArea"] = 3,
				["targetChoose"] = 15,
				["boxId"] = 3312054,
				["state"]= {
				},
				["subEventSkill"] = 3312054,
				["subEventId"] = 1001,
			},
			[1001]= {
				["targetChoose"] = 7,
				["eventType"] = 1,
				["boxId"] = 3312055,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {10003001,},
				},
				["hitCue"]= {
					["cueList"] = {331201007,},
				},
				["subEventSkill"] = 3312054,
				["subEventId"] = 1002,
			},
			[1002]= {
				["targetArea"] = 3,
				["eventType"] = 1,
				["boxId"] = 3312056,
				["state"]= {
				},
			},
		},

		["actTime"] = 50,
		["skillTarget"] = 1,
	},
	[3312003] = {
		["bhEvent"] = "skill.3312001",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331201005,331201006,},
				},
			},
			[1]= {
				["targetChoose"] = 7,
				["unitDelay"] = 0.15,
				["flyCueId"] = 331200012,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3312003,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331200014,},
				},
				["hitCue"]= {
					["cueList"] = {331200013,331201007,},
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
