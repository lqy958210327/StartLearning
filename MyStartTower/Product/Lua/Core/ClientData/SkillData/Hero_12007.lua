local Data = {
["cueFile"] = "12007",
	[1200709] = {
		["bhEvent"] = "skill.1200709",
		["atkEvents"]= {
			[0]= {
				["eventType"] = 1,
				["boxId"] = 1200709,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {120070003,},
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {120070001,120071003,},
				},
			},
		},

	},
	[1200710] = {
		["bhEvent"] = "skill.1200710",
		["atkEvents"]= {
			[0]= {
				["eventType"] = 1,
				["boxId"] = 1200709,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {120070003,},
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {120070002,120071004,},
				},
			},
		},

	},
	[1200759] = {
		["bhEvent"] = "skill.1200759",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {120070006,120070007,10005010,},
				},
			},
			[0]= {
				["eventType"] = 1,
				["boxId"] = 1200759,
				["state"]= {
					["stateId"] = 1000003,
					["duration"] = 5,
				},
				["atkCue"]= {
					["cueList"] = {120073001,},
				},
				["hitCue"]= {
					["cueList"] = {120070008,10006003,},
				},
				["hitedAnim"] = "Hit",
			},
			[2]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1200703,
					["duration"] = 5,
				},
			},
			[13]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {120075001,120070009,},
				},
			},
			[33]= {
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {120071002,},
				},
			},
			[90]= {
				["state"]= {
				},
				["hitedAnim"] = "end",
			},
		},

		["actTime"] = 65,
		["hideEffect"] = 1,
		["videoActTime"] = 75,
		["videoActCue"]= {
			["cueList"] = {120078001,120071001,},
		},
		["hideTime"] = 10,
		["hideEvent"] = 100,
		["prepareCamera"] = 1,
		["prepareCamDruation"] = 45,
	},
	[1200729] = {
		["bhEvent"] = "skill.1200729",
		["atkEvents"]= {
			[0]= {
				["eventType"] = 1,
				["boxId"] = 1200729,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {120070005,},
				},
			},
			[100]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1200701,
					["duration"] = 2,
				},
				["atkCue"]= {
					["cueList"] = {120070004,120071005,},
				},
			},
			[101]= {
				["state"]= {
				},
			},
			[1001]= {
				["targetArea"] = 3,
				["boxId"] = 1200730,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000008,},
				},
				["disablePassive"] = 1,
			},
			[1002]= {
				["eventType"] = 1,
				["boxId"] = 1200731,
				["state"]= {
				},
				["disablePassive"] = 1,
			},
			[1003]= {
				["eventProbId"] = 1200702,
				["state"]= {
				},
				["controlTime"] = 2,
				["controlAniName"] = "freeze",
			},
			[2]= {
				["targetArea"] = 3,
				["state"]= {
					["stateOperation"] = 1,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {1000004,1500101,},
				},
				["eventCondition"] = "1,1,1200711",
			},
			[1]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["eventCondition"] = "1,1,1200711",
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
