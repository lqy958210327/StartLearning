local Data = {
["cueFile"] = "12003",
	[1200309] = {
		["bhEvent"] = "skill.1200309",
		["atkEvents"]= {
			[1]= {
				["eventType"] = 1,
				["boxId"] = 1200309,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000062,},
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {120030008,120030009,},
				},
			},
		},

	},
	[1200310] = {
		["bhEvent"] = "skill.1200310",
		["atkEvents"]= {
			[1]= {
				["eventType"] = 1,
				["boxId"] = 1200309,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000062,},
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {120030010,120030011,},
				},
			},
		},

	},
	[1200359] = {
		["bhEvent"] = "skill.1200359",
		["atkEvents"]= {
			[1]= {
				["eventType"] = 1,
				["boxId"] = 1200359,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {120031002,120033001,},
				},
				["hitCue"]= {
					["cueList"] = {120030002,120031003,10006003,},
				},
				["hitedAnim"] = "Hit",
			},
			[10]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {120030005,120030006,120030007,},
				},
			},
			[2]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["levelAtkEvents"]= {
					[2]= {
						["state"]= {
							["stateId"] = 1200301,
							["duration"] = -999,
						},
					},
					[3]= {
						["state"]= {
							["stateId"] = 1200301,
							["duration"] = -999,
						},
					},
					[4]= {
					},
					[5]= {
					},
					[6]= {
					},
				},

			},
			[11]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1200303,
					["duration"] = 3,
				},
				["atkCue"]= {
					["cueList"] = {120035001,120030003,},
				},
			},
			[1001]= {
				["delay"] = 0.25,
				["boxType"] = 1,
				["boxId"] = 1200360,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000078,},
				},
				["disablePassive"] = 1,
			},
			[1002]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000035,},
				},
				["addManaNumber"] = 10,
			},
			[90]= {
				["state"]= {
				},
				["hitedAnim"] = "end",
			},
		},

		["actTime"] = 60,
		["hideEffect"] = 1,
		["videoActTime"] = 60,
		["videoActCue"]= {
			["cueList"] = {120038002,120031005,},
		},
		["hideTime"] = 10,
		["hideEvent"] = 1,
		["prepareCamera"] = 1,
		["prepareCamDruation"] = 30,
		["skillTarget"] = 2,
	},
	[1200329] = {
		["bhEvent"] = "skill.1200329",
		["atkEvents"]= {
			[1]= {
				["eventType"] = 1,
				["boxId"] = 1200329,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {120030001,120031004,},
				},
			},
			[2]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1200302,
					["duration"] = 1,
				},
			},
			[1001]= {
				["state"]= {
				},
				["controlTime"] = 2,
				["controlAniName"] = "Float",
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {120030014,},
				},
			},
		},

		["skillTarget"] = 2,
	},
	[1200311] = {
		["bhEvent"] = "skill.1200311",
		["atkEvents"]= {
			[10]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1200305,
					["duration"] = 2,
				},
			},
			[1]= {
				["eventType"] = 1,
				["boxId"] = 1200309,
				["state"]= {
				},
			},
			[2]= {
				["targetArea"] = 3,
				["state"]= {
					["stateOperation"] = 1,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {1200304,},
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {120030004,120030013,},
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
