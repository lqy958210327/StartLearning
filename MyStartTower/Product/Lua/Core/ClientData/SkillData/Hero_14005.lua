local Data = {
["cueFile"] = "14005",
	[1400509] = {
		["bhEvent"] = "skill.1400509",
		["atkEvents"]= {
			[0]= {
				["unitDelay"] = 0.08,
				["flyCueId"] = 140050012,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1400509,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {140050015,140051011,},
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {140050011,140051010,},
				},
			},
		},

	},
	[1400529] = {
		["bhEvent"] = "skill.1400529",
		["atkEvents"]= {
			[0]= {
				["targetChoose"] = 7,
				["delay"] = 0.15,
				["flyCueId"] = 90010002,
				["state"]= {
				},
				["levelAtkEvents"]= {
					[2]= {
						["state"]= {
							["stateId"] = 1400502,
							["duration"] = -999,
						},
						["hitCue"]= {
							["cueList"] = {140050017,},
						},
					},
					[3]= {
						["state"]= {
							["stateId"] = 1400502,
							["duration"] = -999,
						},
						["hitCue"]= {
							["cueList"] = {140050017,},
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
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {140050016,140051008,},
				},
			},
			[1]= {
				["targetArea"] = 2,
				["targetChoose"] = 4,
				["eventType"] = 1,
				["boxId"] = 1400529,
				["state"]= {
					["stateId"] = 1000001,
					["duration"] = 12,
				},
				["hitCue"]= {
					["cueList"] = {140050017,},
				},
				["levelAtkEvents"]= {
					[2]= {
					},
					[3]= {
						["targetChoose"] = 7,
					},
					[4]= {
						["state"]= {
						},
					},
					[5]= {
						["state"]= {
						},
					},
					[6]= {
						["state"]= {
						},
						["hitCue"]= {
							["cueList"] = {140050005,},
						},
					},
				},

			},
		},

	},
	[1400559] = {
		["bhEvent"] = "skill.1400559",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {140050018,140050020,},
				},
			},
			[0]= {
				["unitDelay"] = 0.05,
				["flyCueId"] = 140050008,
				["eventType"] = 1,
				["boxId"] = 1400559,
				["state"]= {
					["stateId"] = 1400501,
					["duration"] = 5,
				},
				["atkCue"]= {
					["cueList"] = {140053001,},
				},
				["hitCue"]= {
					["cueList"] = {140050021,10006003,},
				},
				["hitedAnim"] = "Hit",
			},
			[1001]= {
				["targetArea"] = 3,
				["targetChoose"] = 7,
				["boxId"] = 1400560,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000008,},
				},
			},
			[1002]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000035,},
				},
				["addManaNumber"] = 20,
			},
			[13]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {140055001,140051009,},
				},
			},
			[21]= {
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {140050019,},
				},
			},
			[99]= {
				["state"]= {
				},
				["hitedAnim"] = "end",
			},
		},

		["actTime"] = 82,
		["hideEffect"] = 1,
		["videoActTime"] = 50,
		["shortVideoActTime"] = 1,
		["videoActCue"]= {
			["cueList"] = {140058001,140051006,},
		},
		["shortVideoActCue"]= {
			["cueList"] = {140051008,},
		},
		["hideEvent"] = 21,
		["prepareCamera"] = 1,
		["prepareCamDruation"] = 25,
	},
	[1400510] = {
		["bhEvent"] = "skill.1400510",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {140050013,140051012,},
				},
			},
			[0]= {
				["unitDelay"] = 0.08,
				["flyCueId"] = 140050014,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1400509,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {140050015,140051013,},
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
