local Data = {
["cueFile"] = "33118",
	[3311801] = {
		["bhEvent"] = "skill.3311801",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331180001,331181001,},
				},
			},
			[1]= {
				["unitDelay"] = 0.12,
				["flyCueId"] = 331180002,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3311801,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331180004,331181002,},
				},
			},
			[2]= {
				["unitDelay"] = 0.12,
				["flyCueId"] = 331180003,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3311801,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331180004,331181002,},
				},
			},
		},

	},
	[3311802] = {
		["bhEvent"] = "skill.3311802",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331180022,331181003,},
				},
			},
			[10]= {
				["state"]= {
				},
			},
			[1]= {
				["targetChoose"] = 4,
				["eventType"] = 1,
				["boxId"] = 3311802,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331180023,},
				},
			},
		},

	},
	[3311803] = {
		["bhEvent"] = "skill.3311803",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331180005,331181004,},
				},
			},
			[1]= {
				["unitDelay"] = 0.1,
				["flyCueId"] = 331180007,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3311803,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331180008,331181005,},
				},
			},
			[11]= {
				["unitDelay"] = 0.1,
				["flyCueId"] = 331180006,
				["boxType"] = 1,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331180008,},
				},
			},
		},

	},
	[3311821] = {
		["bhEvent"] = "skill.3311821",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331180009,331189001,331181006,},
				},
			},
			[1]= {
				["targetArea"] = 3,
				["summonMonsters"] = "0",
				["state"]= {
				},
			},
			[2]= {
				["targetArea"] = 3,
				["summonMonsters"] = "0",
				["state"]= {
				},
			},
			[10]= {
				["state"]= {
				},
			},
			[99]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331180010,},
				},
			},
		},

		["actTime"] = 45,
		["skillTarget"] = 1,
	},
	[3311831] = {
		["bhEvent"] = "skill.3311831",
		["atkEvents"]= {
			[0]= {
				["state"]= {
				},
			},
			[1]= {
				["targetArea"] = 3,
				["targetChoose"] = 7,
				["state"]= {
				},
			},
			[100]= {
				["targetArea"] = 3,
				["state"]= {
					["stateOperation"] = 1,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {3311802,},
				},
				["atkCue"]= {
					["cueList"] = {331189001,331180024,331181007,},
				},
			},
		},

		["actTime"] = 50,
	},
	[3311841] = {
		["bhEvent"] = "skill.3311841",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
			},
			[1]= {
				["targetChoose"] = 19,
				["unitDelay"] = 0.12,
				["flyCueId"] = 331180012,
				["eventType"] = 1,
				["boxId"] = 3311841,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331180013,331180017,331181008,},
				},
			},
		},

	},
	[3311842] = {
		["bhEvent"] = "skill.3311842",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331180014,331181009,},
				},
			},
			[1]= {
				["targetChoose"] = 7,
				["unitDelay"] = 0.12,
				["flyCueId"] = 331180015,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3311842,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331180016,},
				},
				["randomTargetNumber"] = 3,
			},
		},

	},
	[3311851] = {
		["bhEvent"] = "skill.3311851",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331181011,},
				},
			},
			[1]= {
				["targetChoose"] = 7,
				["delay"] = 0.1,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3311851,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331180018,},
				},
				["hitCue"]= {
					["cueList"] = {331180019,331181012,},
				},
				["randomTargetNumber"] = 1,
			},
		},

		["actTime"] = 85,
		["skillTarget"] = 1,
	},
	[3311852] = {
		["bhEvent"] = "skill.3311852",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331180026,331181013,},
				},
			},
			[1]= {
				["targetChoose"] = 7,
				["eventType"] = 1,
				["boxId"] = 3311852,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331180027,},
				},
				["controlTime"] = 2,
				["controlAniName"] = "Float",
			},
		},

		["actTime"] = 35,
	},
	[3311853] = {
		["bhEvent"] = "skill.3311853",
		["atkEvents"]= {
			[100]= {
				["targetChoose"] = 7,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331180020,331181014,},
				},
				["hitCue"]= {
					["cueList"] = {331180021,},
				},
			},
			[1]= {
				["targetChoose"] = 7,
				["delay"] = 0.1,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3311853,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10005008,10003001,},
				},
			},
			[2]= {
				["targetChoose"] = 7,
				["delay"] = 0.1,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3311853,
				["state"]= {
					["stateId"] = 3311801,
					["duration"] = 5,
				},
				["hitCue"]= {
					["cueList"] = {10005008,10003001,},
				},
			},
			[1001]= {
				["eventType"] = 1,
				["boxId"] = 3311860,
				["state"]= {
				},
				["disablePassive"] = 1,
			},
		},

		["actTime"] = 100,
		["skillTarget"] = 1,
	},
	[3311854] = {
		["bhEvent"] = "skill.3311854",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331180028,331181015,},
				},
			},
			[1]= {
				["unitDelay"] = 0.15,
				["flyCueId"] = 331180029,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3311854,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331180030,331181016,},
				},
			},
		},

		["actTime"] = 60,
	},
	[3311822] = {
		["bhEvent"] = "skill.3311823",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331180009,331189001,331181006,},
				},
			},
			[1]= {
				["targetArea"] = 3,
				["summonMonsters"] = "40302022",
				["summonLineChoose"] = 3,
				["state"]= {
				},
			},
			[2]= {
				["targetArea"] = 3,
				["summonMonsters"] = "0",
				["state"]= {
				},
			},
			[99]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331180010,},
				},
			},
			[10]= {
				["state"]= {
				},
			},
		},

		["actTime"] = 45,
		["skillTarget"] = 1,
	},
	[3311823] = {
		["bhEvent"] = "skill.3311823",
		["atkEvents"]= {
			[100]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331180009,331189001,331181006,},
				},
			},
			[1]= {
				["targetArea"] = 3,
				["summonMonsters"] = "40302032",
				["summonLineChoose"] = 3,
				["state"]= {
				},
			},
			[2]= {
				["targetArea"] = 3,
				["summonMonsters"] = "0",
				["state"]= {
				},
			},
			[99]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331180010,},
				},
			},
		},

		["actTime"] = 45,
		["skillTarget"] = 1,
	},
	[3311824] = {
		["bhEvent"] = "skill.3311824",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331180009,331189001,331181006,},
				},
			},
			[1]= {
				["targetArea"] = 3,
				["summonMonsters"] = "40302042",
				["summonLineChoose"] = 1,
				["state"]= {
				},
			},
			[2]= {
				["targetArea"] = 3,
				["summonMonsters"] = "40302043",
				["summonLineChoose"] = 3,
				["state"]= {
				},
			},
			[99]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331180010,},
				},
			},
		},

		["actTime"] = 45,
		["skillTarget"] = 1,
	},
	[3311825] = {
		["bhEvent"] = "skill.3311825",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331180009,331189001,331181006,},
				},
			},
			[1]= {
				["targetArea"] = 3,
				["summonMonsters"] = "40302052",
				["summonLineChoose"] = 1,
				["state"]= {
				},
			},
			[2]= {
				["targetArea"] = 3,
				["summonMonsters"] = "40302053",
				["summonLineChoose"] = 3,
				["state"]= {
				},
			},
			[99]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331180010,},
				},
			},
		},

		["actTime"] = 45,
		["skillTarget"] = 1,
	},
	[3311826] = {
		["bhEvent"] = "skill.3311826",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331180008,331189001,331181006,},
				},
			},
			[1]= {
				["targetArea"] = 3,
				["summonMonsters"] = "40302062",
				["summonLineChoose"] = 1,
				["state"]= {
				},
			},
			[2]= {
				["targetArea"] = 3,
				["summonMonsters"] = "40302063",
				["summonLineChoose"] = 3,
				["state"]= {
				},
			},
			[99]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331180010,},
				},
			},
		},

		["actTime"] = 45,
		["skillTarget"] = 1,
	},
	[3311827] = {
		["bhEvent"] = "skill.3311827",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331180009,331189001,331181006,},
				},
			},
			[1]= {
				["targetArea"] = 3,
				["summonMonsters"] = "40302072",
				["summonLineChoose"] = 1,
				["state"]= {
				},
			},
			[2]= {
				["targetArea"] = 3,
				["summonMonsters"] = "40302073",
				["summonLineChoose"] = 3,
				["state"]= {
				},
			},
			[99]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331180010,},
				},
			},
			[10]= {
				["state"]= {
				},
			},
		},

		["actTime"] = 45,
		["skillTarget"] = 1,
	},
	[3311832] = {
		["bhEvent"] = "skill.3311832",
		["atkEvents"]= {
			[100]= {
				["targetArea"] = 3,
				["state"]= {
					["stateOperation"] = 1,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {3311802,},
				},
				["atkCue"]= {
					["cueList"] = {331189001,331180024,331181007,},
				},
			},
			[1]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 3311803,
					["duration"] = -999,
				},
			},
			[1001]= {
				["targetArea"] = 3,
				["targetChoose"] = 7,
				["boxId"] = 3311832,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000008,10000045,},
				},
			},
		},

		["actTime"] = 50,
		["skillTarget"] = 1,
	},
	[3311828] = {
		["bhEvent"] = "skill.3311828",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331180009,331189001,331181006,},
				},
			},
			[10]= {
				["state"]= {
				},
			},
			[99]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331180010,},
				},
			},
			[1]= {
				["targetArea"] = 3,
				["summonMonsters"] = "40302082",
				["summonLineChoose"] = 1,
				["state"]= {
				},
			},
			[2]= {
				["targetArea"] = 3,
				["summonMonsters"] = "40302083",
				["summonLineChoose"] = 3,
				["state"]= {
				},
			},
		},

		["actTime"] = 45,
		["skillTarget"] = 1,
	},
	[3311829] = {
		["bhEvent"] = "skill.3311829",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331180009,331189001,331181006,},
				},
			},
			[10]= {
				["state"]= {
				},
			},
			[99]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331180010,},
				},
			},
			[1]= {
				["targetArea"] = 3,
				["summonMonsters"] = "40302092",
				["summonLineChoose"] = 1,
				["state"]= {
				},
			},
			[2]= {
				["targetArea"] = 3,
				["summonMonsters"] = "40302093",
				["summonLineChoose"] = 3,
				["state"]= {
				},
			},
		},

		["actTime"] = 45,
		["skillTarget"] = 1,
	},
	[3311855] = {
		["bhEvent"] = "skill.3311854",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331180028,331181015,},
				},
			},
			[1]= {
				["unitDelay"] = 0.15,
				["flyCueId"] = 331180029,
				["boxType"] = 1,
				["boxId"] = 3311855,
				["state"]= {
					["stateId"] = 3311805,
					["duration"] = 5,
				},
				["hitCue"]= {
					["cueList"] = {331180030,331181016,},
				},
				["stunTime"] = 5,
			},
			[1001]= {
				["eventType"] = 1,
				["boxId"] = 3311855,
				["state"]= {
				},
			},
		},

		["actTime"] = 60,
	},
	[3311830] = {
		["bhEvent"] = "skill.3311830",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331180009,331189001,331181006,},
				},
			},
			[1]= {
				["targetArea"] = 3,
				["summonMonsters"] = "40302102",
				["summonLineChoose"] = 1,
				["state"]= {
				},
			},
			[99]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331180035,},
				},
			},
			[2]= {
				["state"]= {
				},
			},
			[10]= {
				["state"]= {
				},
			},
		},

		["actTime"] = 45,
		["skillTarget"] = 1,
	},
	[3311833] = {
		["bhEvent"] = "skill.3311821",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
			},
			[1]= {
				["targetArea"] = 3,
				["boxId"] = 3311833,
				["state"]= {
					["stateId"] = 3311806,
					["duration"] = 5,
				},
			},
			[2]= {
				["targetChoose"] = 7,
				["state"]= {
					["stateId"] = 3311807,
					["duration"] = 5,
				},
			},
			[1001]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 3311809,
					["duration"] = 1,
				},
			},
			[10]= {
				["state"]= {
				},
			},
			[99]= {
				["state"]= {
				},
			},
		},

		["actTime"] = 60,
	},
	[3311843] = {
		["bhEvent"] = "skill.3311842",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {331180014,331181009,},
				},
			},
			[1]= {
				["targetChoose"] = 7,
				["unitDelay"] = 0.12,
				["flyCueId"] = 331180015,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 3311842,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {331180016,},
				},
				["randomTargetNumber"] = 3,
				["subEventSkill"] = 3311843,
				["subEventId"] = 1001,
			},
			[1001]= {
				["targetArea"] = 3,
				["state"]= {
					["stateOperation"] = 1,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {1000002,1000004,1000006,},
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
