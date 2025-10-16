local Data = {
["cueFile"] = "33007",
	[3300701] = {
		["bhEvent"] = "skill.3300701",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {330070001,330071001,},
				},
			},
			[1]= {
				["eventType"] = 1,
				["boxId"] = 3300701,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {330070003,},
				},
			},
		},

	},
	[3300702] = {
		["bhEvent"] = "skill.3300702",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {330070002,330071002,},
				},
			},
			[1]= {
				["eventType"] = 1,
				["boxId"] = 3300701,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {330070003,},
				},
			},
		},

	},
	[3300721] = {
		["bhEvent"] = "skill.3300721",
		["atkEvents"]= {
			[100]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 3300718,
					["duration"] = 2,
				},
				["atkCue"]= {
					["cueList"] = {330070004,330071003,},
				},
			},
			[1]= {
				["summonMonsters"] = "70000412",
				["summonLineChoose"] = 2,
				["state"]= {
				},
			},
			[2]= {
				["summonMonsters"] = "70000411",
				["summonLineChoose"] = 1,
				["state"]= {
				},
			},
			[3]= {
				["summonMonsters"] = "70000411",
				["summonLineChoose"] = 3,
				["state"]= {
				},
			},
			[4]= {
				["summonMonsters"] = "70000412",
				["summonLineChoose"] = 4,
				["state"]= {
				},
			},
			[1001]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 3300713,
					["duration"] = 10,
				},
			},
			[1002]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 3300715,
					["duration"] = 10,
				},
			},
			[1003]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 3300717,
					["duration"] = 10,
				},
			},
			[10]= {
				["targetArea"] = 3,
				["boxId"] = 3300721,
				["state"]= {
					["stateOperation"] = 1,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {3300711,3300712,3300713,3300714,3300715,3300716,3300717,},
				},
			},
			[11]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 3300710,
					["duration"] = -999,
				},
			},
			[1004]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 3300732,
					["duration"] = 10,
				},
			},
		},

		["actTime"] = 60,
		["skillTarget"] = 1,
	},
	[3300722] = {
		["bhEvent"] = "skill.3300722",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {330070005,330071004,},
				},
			},
			[1]= {
				["targetChoose"] = 12,
				["boxId"] = 3300722,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {330070007,330071006,},
				},
			},
			[2]= {
				["targetChoose"] = 7,
				["delay"] = 0.6,
				["flyCueId"] = 330070006,
				["boxType"] = 1,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {330071005,},
				},
				["randomTargetNumber"] = 1,
				["randomRule"] = 4,
				["recordSkillTargets"] = 1,
			},
		},

	},
	[3300751] = {
		["bhEvent"] = "skill.3300751",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {330070009,330070010,330071007,},
				},
			},
			[2]= {
				["state"]= {
				},
				["weatherFlag"] = 3300701,
				["weatherTime"] = 10,
			},
			[1]= {
				["targetChoose"] = 7,
				["eventType"] = 1,
				["boxId"] = 3300751,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {330070001,},
				},
				["hitCue"]= {
					["cueList"] = {10000062,},
				},
			},
			[1001]= {
				["targetArea"] = 3,
				["boxId"] = 3300752,
				["state"]= {
				},
			},
		},

		["actTime"] = 91,
		["hideEffect"] = 1,
		["skillTarget"] = 1,
	},
	[3300771] = {
		["bhEvent"] = "skill.3300771",
		["skillTarget"] = 1,
	},
	[3300723] = {
		["bhEvent"] = "skill.3300723",
		["atkEvents"]= {
			[100]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 3300718,
					["duration"] = 2,
				},
				["atkCue"]= {
					["cueList"] = {330070004,330071003,},
				},
			},
			[1]= {
				["summonMonsters"] = "70000422",
				["summonLineChoose"] = 2,
				["state"]= {
				},
			},
			[2]= {
				["summonMonsters"] = "70000421",
				["summonLineChoose"] = 1,
				["state"]= {
				},
			},
			[3]= {
				["summonMonsters"] = "70000421",
				["summonLineChoose"] = 3,
				["state"]= {
				},
			},
			[4]= {
				["summonMonsters"] = "70000422",
				["summonLineChoose"] = 4,
				["state"]= {
				},
			},
			[10]= {
				["targetArea"] = 3,
				["boxId"] = 3300723,
				["state"]= {
					["stateOperation"] = 1,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {3300711,3300712,3300713,3300714,3300715,3300716,3300717,},
				},
			},
			[11]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 3300710,
					["duration"] = -999,
				},
			},
		},

		["actTime"] = 60,
		["skillTarget"] = 1,
	},
	[3300724] = {
		["bhEvent"] = "skill.3300724",
		["atkEvents"]= {
			[100]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 3300718,
					["duration"] = 2,
				},
				["atkCue"]= {
					["cueList"] = {330070004,330071003,},
				},
			},
			[1]= {
				["summonMonsters"] = "70000432",
				["summonLineChoose"] = 2,
				["state"]= {
				},
			},
			[2]= {
				["summonMonsters"] = "70000431",
				["summonLineChoose"] = 1,
				["state"]= {
				},
			},
			[3]= {
				["summonMonsters"] = "70000431",
				["summonLineChoose"] = 3,
				["state"]= {
				},
			},
			[4]= {
				["summonMonsters"] = "70000432",
				["summonLineChoose"] = 4,
				["state"]= {
				},
			},
			[10]= {
				["targetArea"] = 3,
				["boxId"] = 3300724,
				["state"]= {
					["stateOperation"] = 1,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {3300711,3300712,3300713,3300714,3300715,3300716,3300717,},
				},
			},
			[11]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 3300710,
					["duration"] = -999,
				},
			},
		},

		["actTime"] = 60,
		["skillTarget"] = 1,
	},
	[3300752] = {
		["bhEvent"] = "skill.3300752",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {330070009,330070010,330071007,},
				},
			},
			[2]= {
				["state"]= {
				},
				["weatherFlag"] = 3300702,
				["weatherTime"] = 10,
			},
			[1]= {
				["targetChoose"] = 7,
				["eventType"] = 1,
				["boxId"] = 3300751,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {330070001,},
				},
				["hitCue"]= {
					["cueList"] = {10000062,},
				},
			},
		},

		["actTime"] = 91,
		["hideEffect"] = 1,
		["skillTarget"] = 1,
	},
	[3300731] = {
		["bhEvent"] = "skill.3300731",
		["atkEvents"]= {
			[100]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 3300718,
					["duration"] = 2,
				},
				["atkCue"]= {
					["cueList"] = {330070004,330071003,},
				},
			},
			[1]= {
				["targetArea"] = 3,
				["summonMonsters"] = "70000412",
				["summonLineChoose"] = 2,
				["state"]= {
				},
			},
			[2]= {
				["targetArea"] = 3,
				["summonMonsters"] = "70000412",
				["summonLineChoose"] = 4,
				["state"]= {
				},
			},
			[10]= {
				["targetArea"] = 3,
				["boxId"] = 3300731,
				["state"]= {
					["stateOperation"] = 1,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {3300711,3300712,3300713,3300714,3300715,3300716,3300717,},
				},
			},
			[11]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 3300710,
					["duration"] = -999,
				},
			},
		},

		["actTime"] = 60,
		["skillTarget"] = 1,
	},
	[3300732] = {
		["bhEvent"] = "skill.3300732",
		["atkEvents"]= {
			[100]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 3300718,
					["duration"] = 2,
				},
				["atkCue"]= {
					["cueList"] = {330070004,330071003,},
				},
			},
			[1]= {
				["targetArea"] = 3,
				["summonMonsters"] = "70000422",
				["summonLineChoose"] = 2,
				["state"]= {
				},
			},
			[2]= {
				["targetArea"] = 3,
				["summonMonsters"] = "70000422",
				["summonLineChoose"] = 4,
				["state"]= {
				},
			},
			[10]= {
				["targetArea"] = 3,
				["boxId"] = 3300732,
				["state"]= {
					["stateOperation"] = 1,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {3300711,3300712,3300713,3300714,3300715,3300716,3300717,},
				},
			},
			[11]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 3300710,
					["duration"] = -999,
				},
			},
		},

		["actTime"] = 60,
		["skillTarget"] = 1,
	},
	[3300733] = {
		["bhEvent"] = "skill.3300733",
		["atkEvents"]= {
			[100]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 3300718,
					["duration"] = 2,
				},
				["atkCue"]= {
					["cueList"] = {330070004,330071003,},
				},
			},
			[1]= {
				["targetArea"] = 3,
				["summonMonsters"] = "70000432",
				["summonLineChoose"] = 2,
				["state"]= {
				},
			},
			[2]= {
				["targetArea"] = 3,
				["summonMonsters"] = "70000432",
				["summonLineChoose"] = 4,
				["state"]= {
				},
			},
			[10]= {
				["targetArea"] = 3,
				["boxId"] = 3300733,
				["state"]= {
					["stateOperation"] = 1,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {3300711,3300712,3300713,3300714,3300715,3300716,3300717,},
				},
			},
			[11]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 3300710,
					["duration"] = -999,
				},
			},
			[3]= {
				["state"]= {
				},
			},
			[4]= {
				["state"]= {
				},
			},
		},

		["actTime"] = 60,
		["skillTarget"] = 1,
	},
	[3300725] = {
		["bhEvent"] = "skill.3300725",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {330070004,330071003,},
				},
			},
			[1]= {
				["targetArea"] = 3,
				["summonMonsters"] = "10701572",
				["summonLineChoose"] = 1,
				["state"]= {
				},
			},
			[2]= {
				["targetArea"] = 3,
				["summonMonsters"] = "10701572",
				["summonLineChoose"] = 3,
				["state"]= {
				},
			},
			[11]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 3300710,
					["duration"] = -999,
				},
			},
			[10]= {
				["targetArea"] = 3,
				["state"]= {
					["stateOperation"] = 1,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {3300711,3300731,3300732,},
				},
			},
		},

		["actTime"] = 60,
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
