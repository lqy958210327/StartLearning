local Data = {
["cueFile"] = "13006",
	[1300609] = {
		["bhEvent"] = "skill.1300609",
		["atkEvents"]= {
			[0]= {
				["unitDelay"] = 0.15,
				["flyCueId"] = 130060003,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1300609,
				["state"]= {
					["stateId"] = 1300602,
					["duration"] = 3,
				},
				["hitCue"]= {
					["cueList"] = {130060004,130061005,},
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {130060001,130060002,130061004,},
				},
			},
			[1001]= {
				["targetChoose"] = 7,
				["unitDelay"] = 0.15,
				["flyCueId"] = 130060003,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1300609,
				["state"]= {
					["stateId"] = 1300602,
					["duration"] = 3,
				},
				["hitCue"]= {
					["cueList"] = {130060004,130061005,},
				},
				["randomTargetNumber"] = 1,
				["excludeTarget"] = 1,
			},
		},

	},
	[1300610] = {
		["bhEvent"] = "skill.1300610",
		["atkEvents"]= {
			[0]= {
				["unitDelay"] = 0.15,
				["flyCueId"] = 130060003,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1300609,
				["state"]= {
					["stateId"] = 1300602,
					["duration"] = 3,
				},
				["hitCue"]= {
					["cueList"] = {130060004,},
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {130060001,130060002,},
				},
			},
		},

	},
	[1300659] = {
		["bhEvent"] = "skill.1300659",
		["atkEvents"]= {
			[100]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1300601,
					["duration"] = 1,
				},
				["atkCue"]= {
					["cueList"] = {130060007,},
				},
			},
			[0]= {
				["unitDelay"] = 0.12,
				["flyCueId"] = 130060009,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1300659,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {130063001,},
				},
				["hitCue"]= {
					["cueList"] = {130060008,10006003,130061003,},
				},
			},
			[1001]= {
				["targetChoose"] = 7,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1300660,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {130060011,},
				},
				["baseCue"]= {
					["cueList"] = {130060010,},
				},
				["disablePassive"] = 1,
				["excludeTarget"] = 1,
			},
			[1002]= {
				["targetArea"] = 3,
				["delay"] = 0.2,
				["boxType"] = 1,
				["boxId"] = 1300630,
				["state"]= {
					["chooseStateMode"] = 2,
				},
				["hitCue"]= {
					["cueList"] = {10000008,},
				},
			},
			[1003]= {
				["boxId"] = 1300661,
				["state"]= {
				},
				["disablePassive"] = 1,
			},
			[1004]= {
				["targetChoose"] = 7,
				["state"]= {
				},
				["controlTime"] = 1,
				["controlAniName"] = "freeze",
			},
			[13]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {130065001,130060012,},
				},
			},
			[1005]= {
				["state"]= {
				},
				["baseCue"]= {
					["cueList"] = {130060010,},
				},
			},
			[33]= {
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {130061003,},
				},
			},
		},

		["actTime"] = 60,
		["hideEffect"] = 1,
		["videoActTime"] = 40,
		["videoActCue"]= {
			["cueList"] = {130068001,130061001,},
		},
		["hideTime"] = 10,
		["prepareCamera"] = 1,
		["prepareCamDruation"] = 30,
	},
	[1300629] = {
		["bhEvent"] = "skill.1300629",
		["atkEvents"]= {
			[1001]= {
				["delay"] = 0.1,
				["eventType"] = 1,
				["boxId"] = 1300629,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {130060005,},
				},
				["hitCue"]= {
					["cueList"] = {130060006,130060013,},
				},
			},
			[1002]= {
				["targetArea"] = 3,
				["delay"] = 0.05,
				["boxId"] = 1300630,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000008,},
				},
			},
		},

	},
	[1300691] = {
		["bhEvent"] = "skill.1300691",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {130060007,},
				},
			},
			[0]= {
				["unitDelay"] = 0.12,
				["flyCueId"] = 130060009,
				["boxType"] = 1,
				["boxId"] = 1300659,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {130060008,},
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
