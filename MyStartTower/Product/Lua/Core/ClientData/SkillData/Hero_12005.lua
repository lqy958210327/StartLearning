local Data = {
["cueFile"] = "12005",
	[1200509] = {
		["bhEvent"] = "skill.1200509",
		["atkEvents"]= {
			[1]= {
				["eventType"] = 1,
				["boxId"] = 1200509,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000062,},
				},
			},
			[1001]= {
				["targetArea"] = 3,
				["state"]= {
					["stateOperation"] = 1,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {1200507,},
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {120050001,120051001,},
				},
			},
			[1002]= {
				["eventType"] = 1,
				["boxId"] = 1200512,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000041,},
				},
				["disablePassive"] = 1,
			},
		},

	},
	[1200510] = {
		["bhEvent"] = "skill.1200510",
		["atkEvents"]= {
			[1]= {
				["eventType"] = 1,
				["boxId"] = 1200509,
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
					["cueList"] = {120050003,120051002,},
				},
			},
		},

	},
	[1200559] = {
		["bhEvent"] = "skill.1200559",
		["atkEvents"]= {
			[0]= {
				["targetChoose"] = 1,
				["eventType"] = 1,
				["boxId"] = 1200559,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {120053001,},
				},
				["hitCue"]= {
					["cueList"] = {120050009,10006003,},
				},
				["hitedAnim"] = "Hit",
			},
			[1]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["levelAtkEvents"]= {
					[2]= {
					},
					[3]= {
						["state"]= {
							["stateId"] = 1200501,
							["duration"] = 5,
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
			[1001]= {
				["targetArea"] = 3,
				["delay"] = 1.5,
				["boxType"] = 1,
				["boxId"] = 1200561,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000025,},
				},
			},
			[1002]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000001,},
				},
			},
			[2]= {
				["targetArea"] = 3,
				["boxId"] = 1200560,
				["state"]= {
				},
				["levelAtkEvents"]= {
					[2]= {
						["state"]= {
							["stateId"] = 1200503,
							["duration"] = 3,
						},
					},
					[3]= {
						["state"]= {
							["stateId"] = 1200503,
							["duration"] = 3,
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
			[100]= {
				["targetChoose"] = 1,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {120050008,},
				},
			},
			[11]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {120055001,120050010,120051005,},
				},
			},
			[3]= {
				["targetArea"] = 3,
				["state"]= {
				},
			},
			[1003]= {
				["targetArea"] = 2,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {120050012,},
				},
			},
			[90]= {
				["targetChoose"] = 1,
				["state"]= {
				},
				["hitedAnim"] = "end",
			},
			[27]= {
				["targetChoose"] = 1,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10006003,},
				},
				["hitedAnim"] = "Hit",
			},
		},

		["actTime"] = 70,
		["hideEffect"] = 1,
		["videoActTime"] = 65,
		["videoActCue"]= {
			["cueList"] = {120058001,120051004,},
		},
		["hideTime"] = 10,
		["hideEvent"] = 100,
		["prepareCamera"] = 1,
		["prepareCamDruation"] = 20,
	},
	[1200529] = {
		["bhEvent"] = "skill.1200529",
		["atkEvents"]= {
			[0]= {
				["eventType"] = 1,
				["boxId"] = 1200509,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {90010007,},
				},
			},
		},

	},
	[1200511] = {
		["bhEvent"] = "skill.1200511",
		["atkEvents"]= {
			[0]= {
				["targetChoose"] = 1,
				["eventType"] = 1,
				["boxId"] = 1200511,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {120050006,},
				},
			},
			[1]= {
				["state"]= {
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {120050005,120051003,},
				},
			},
		},

	},
	[1200591] = {
		["bhEvent"] = "skill.1200591",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {120050008,},
				},
			},
			[0]= {
				["targetChoose"] = 1,
				["boxId"] = 1200559,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {120050009,120051005,},
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
