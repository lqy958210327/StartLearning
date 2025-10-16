local Data = {
["cueFile"] = "13004",
	[1300409] = {
		["bhEvent"] = "skill.1300409",
		["atkEvents"]= {
			[0]= {
				["unitDelay"] = 0.08,
				["flyCueId"] = 130040001,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1300409,
				["state"]= {
					["stateId"] = 1300402,
					["duration"] = 3,
				},
				["hitCue"]= {
					["cueList"] = {10000062,130041002,},
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {130041001,},
				},
			},
		},

	},
	[1300459] = {
		["bhEvent"] = "skill.1300459",
		["atkEvents"]= {
			[100]= {
				["targetChoose"] = 7,
				["state"]= {
				},
			},
			[0]= {
				["targetArea"] = 2,
				["targetChoose"] = 7,
				["delay"] = 0.15,
				["flyCueId"] = 90010021,
				["eventType"] = 1,
				["boxId"] = 1300459,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {130043001,},
				},
				["hitCue"]= {
					["cueList"] = {130040007,130041007,10006003,},
				},
				["hitedAnim"] = "Hit",
			},
			[11]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1300401,
					["duration"] = 3,
				},
				["atkCue"]= {
					["cueList"] = {130040005,},
				},
			},
			[12]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {130040006,},
				},
			},
			[13]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {130045001,130040008,130041006,},
				},
			},
			[14]= {
				["targetArea"] = 2,
				["targetChoose"] = 7,
				["state"]= {
				},
				["hitedAnim"] = "end",
			},
			[1001]= {
				["state"]= {
				},
				["controlTime"] = 2,
				["controlAniName"] = "freeze",
			},
			[1002]= {
				["delay"] = 0.1,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1300461,
				["state"]= {
				},
				["disablePassive"] = 1,
			},
			[90]= {
				["targetArea"] = 2,
				["targetChoose"] = 7,
				["state"]= {
				},
				["hitedAnim"] = "end",
			},
			[1003]= {
				["targetChoose"] = 7,
				["delay"] = 0.2,
				["flyCueId"] = 130040001,
				["baseToTarget"] = 1,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1300462,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {130040002,},
				},
				["disablePassive"] = 1,
				["eventCondition"] = "1,2,1300402",
			},
		},

		["actTime"] = 55,
		["hideEffect"] = 1,
		["videoActTime"] = 51,
		["videoActCue"]= {
			["cueList"] = {130048001,130041005,},
		},
		["hideTime"] = 10,
		["hideEvent"] = 100,
		["prepareCamera"] = 1,
		["prepareCamDruation"] = 30,
	},
	[1300429] = {
		["bhEvent"] = "skill.1300429",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {130040003,130041003,},
				},
			},
			[0]= {
				["targetChoose"] = 7,
				["eventType"] = 1,
				["boxId"] = 1300460,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {130040004,130041004,},
				},
			},
			[1]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["levelAtkEvents"]= {
					[2]= {
						["hitCue"]= {
							["cueList"] = {10000035,},
						},
						["addManaNumber"] = 10,
					},
					[3]= {
						["hitCue"]= {
							["cueList"] = {10000035,},
						},
						["addManaNumber"] = 10,
					},
					[4]= {
					},
					[5]= {
					},
					[6]= {
					},
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
