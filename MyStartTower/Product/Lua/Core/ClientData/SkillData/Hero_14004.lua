local Data = {
["cueFile"] = "14004",
	[1400409] = {
		["bhEvent"] = "skill.1400409",
		["atkEvents"]= {
			[0]= {
				["eventType"] = 1,
				["boxId"] = 1400409,
				["state"]= {
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {140040010,140041007,},
				},
			},
			[1]= {
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {140040011,140041008,},
				},
			},
		},

	},
	[1400429] = {
		["bhEvent"] = "skill.1400429",
		["atkEvents"]= {
			[0]= {
				["targetArea"] = 2,
				["targetChoose"] = 12,
				["delay"] = 0.35,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {140041004,},
				},
				["levelAtkEvents"]= {
					[2]= {
						["targetChoose"] = 7,
						["state"]= {
							["stateId"] = 1400401,
							["duration"] = -999,
						},
						["hitCue"]= {
							["cueList"] = {140040013,},
						},
					},
					[3]= {
						["targetChoose"] = 7,
						["state"]= {
							["stateId"] = 1400401,
							["duration"] = -999,
						},
						["hitCue"]= {
							["cueList"] = {140040013,},
						},
					},
					[4]= {
						["targetChoose"] = 7,
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
					["cueList"] = {140040012,140041009,},
				},
			},
			[1]= {
				["targetArea"] = 2,
				["targetChoose"] = 7,
				["eventType"] = 1,
				["boxId"] = 1400429,
				["state"]= {
					["stateId"] = 1000003,
					["duration"] = 12,
				},
				["hitCue"]= {
					["cueList"] = {140040014,140041010,},
				},
				["randomTargetNumber"] = 3,
				["recordSkillTargets"] = 1,
				["levelAtkEvents"]= {
					[2]= {
					},
					[3]= {
						["hitCue"]= {
							["cueList"] = {140040014,140040013,},
						},
						["randomTargetNumber"] = 100,
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
							["cueList"] = {140040005,140041004,},
						},
					},
				},

			},
			[1001]= {
				["targetChoose"] = 7,
				["state"]= {
					["stateId"] = 1400411,
					["duration"] = -999,
				},
			},
			[1002]= {
				["delay"] = 0.1,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1400430,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000042,},
				},
				["disablePassive"] = 1,
				["eventCondition"] = "1,2,1000003",
			},
		},

	},
	[1400459] = {
		["bhEvent"] = "skill.1400459",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {140040015,},
				},
			},
			[0]= {
				["targetChoose"] = 3,
				["eventType"] = 1,
				["boxId"] = 1400459,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {140043001,},
				},
				["hitCue"]= {
					["cueList"] = {10006003,},
				},
				["hitedAnim"] = "Hit",
			},
			[1]= {
				["targetArea"] = 1,
				["targetChoose"] = 3,
				["state"]= {
				},
				["levelAtkEvents"]= {
					[2]= {
						["boxId"] = 1400460,
						["hitCue"]= {
							["cueList"] = {10000008,},
						},
					},
					[3]= {
						["boxId"] = 1400460,
						["state"]= {
							["stateId"] = 1400402,
							["duration"] = 5,
						},
						["hitCue"]= {
							["cueList"] = {10000008,},
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
			[2]= {
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {140040016,},
				},
			},
			[3]= {
				["state"]= {
				},
				["levelAtkEvents"]= {
					[2]= {
						["hitCue"]= {
							["cueList"] = {140040017,},
						},
					},
					[3]= {
						["hitCue"]= {
							["cueList"] = {140040017,},
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
			[13]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {140045001,140040019,140041012,},
				},
			},
			[99]= {
				["targetChoose"] = 3,
				["state"]= {
				},
				["hitedAnim"] = "end",
			},
			[1001]= {
				["delay"] = 0.15,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1400461,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {140040013,},
				},
				["disablePassive"] = 1,
			},
		},

		["actTime"] = 100,
		["hideEffect"] = 1,
		["videoActTime"] = 60,
		["videoActCue"]= {
			["cueList"] = {140048001,140041011,},
		},
		["prepareCamera"] = 1,
		["prepareCamDruation"] = 30,
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
