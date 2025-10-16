local Data = {
["cueFile"] = "11005",
	[1100509] = {
		["bhEvent"] = "skill.1100509",
		["atkEvents"]= {
			[0]= {
				["eventType"] = 1,
				["boxId"] = 1100509,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {110050001,},
				},
			},
			[1]= {
				["eventType"] = 1,
				["boxId"] = 1100509,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {110050011,},
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {110050009,110051001,},
				},
			},
		},

	},
	[1100510] = {
		["bhEvent"] = "skill.1100510",
		["atkEvents"]= {
			[1]= {
				["eventType"] = 1,
				["boxId"] = 1100509,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {110050011,},
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {110050010,110051002,},
				},
			},
		},

	},
	[1100529] = {
		["bhEvent"] = "skill.1100529",
		["atkEvents"]= {
			[1]= {
				["targetArea"] = 2,
				["targetChoose"] = 3,
				["eventType"] = 1,
				["boxId"] = 1100529,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {110050013,},
				},
				["stunTime"] = 3,
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {110050012,110051003,},
				},
			},
			[2]= {
				["targetArea"] = 3,
				["state"]= {
					["stateCondition"] = 1,
				},
				["levelAtkEvents"]= {
					[2]= {
						["addManaNumber"] = 40,
					},
					[3]= {
						["hitCue"]= {
							["cueList"] = {10000035,},
						},
						["addManaNumber"] = 40,
					},
					[4]= {
					},
					[5]= {
					},
					[6]= {
					},
				},

			},
			[3]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1100502,
					["duration"] = 3,
				},
			},
			[1001]= {
				["state"]= {
					["stateId"] = 1100503,
					["duration"] = 0.05,
				},
			},
			[1002]= {
				["state"]= {
				},
				["stunTime"] = 3,
			},
			[1003]= {
				["targetArea"] = 3,
				["targetChoose"] = 11,
				["boxId"] = 1100530,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000008,},
				},
			},
		},

	},
	[1100559] = {
		["bhEvent"] = "skill.1100559",
		["atkEvents"]= {
			[100]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1100501,
					["duration"] = 8.5,
				},
				["atkCue"]= {
					["cueList"] = {110050014,110051004,},
				},
				["levelAtkEvents"]= {
					[2]= {
					},
					[3]= {
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
					},
				},

			},
			[0]= {
				["targetArea"] = 2,
				["targetChoose"] = 7,
				["eventType"] = 1,
				["boxId"] = 1100559,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {110050016,},
				},
			},
			[1]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {110050015,110051005,},
				},
			},
			[2]= {
				["targetArea"] = 3,
				["state"]= {
					["stateOperation"] = 1,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {8540341,8540351,8540361,8813101,},
				},
			},
			[13]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {110055001,110050018,},
				},
			},
			[1001]= {
				["state"]= {
				},
				["controlTime"] = 2,
				["controlAniName"] = "Float",
			},
			[1002]= {
				["delay"] = 0.2,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1100560,
				["state"]= {
				},
			},
		},

		["actTime"] = 60,
		["hideEffect"] = 1,
		["videoActTime"] = 50,
		["videoActCue"]= {
			["cueList"] = {110058001,110051006,},
		},
		["prepareCamera"] = 1,
		["prepareCamDruation"] = 25,
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
