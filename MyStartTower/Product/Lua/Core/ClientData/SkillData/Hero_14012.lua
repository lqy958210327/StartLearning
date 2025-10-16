local Data = {
["cueFile"] = "14012",
	[1401201] = {
		["bhEvent"] = "skill.1401209",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {140120001,140121001,},
				},
			},
			[1]= {
				["unitDelay"] = 0.1,
				["flyCueId"] = 140120002,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1401201,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {140120003,140121002,},
				},
			},
			[1001]= {
				["delay"] = 0.1,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1401202,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {140120007,},
				},
				["disablePassive"] = 1,
			},
			[1002]= {
				["delay"] = 0.1,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1401203,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {140120007,},
				},
				["disablePassive"] = 1,
			},
		},

	},
	[1401221] = {
		["bhEvent"] = "skill.1401229",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {140120005,140121003,},
				},
			},
			[1]= {
				["unitDelay"] = 0.15,
				["flyCueId"] = 140120006,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1401221,
				["state"]= {
					["stateId"] = 1401201,
					["duration"] = -999,
				},
				["hitCue"]= {
					["cueList"] = {140120007,},
				},
			},
			[1001]= {
				["boxId"] = 1401222,
				["state"]= {
				},
				["disablePassive"] = 1,
			},
			[1002]= {
				["priorUsePreTarget"] = 1,
				["state"]= {
					["stateId"] = 1401201,
					["duration"] = -999,
				},
			},
			[2]= {
				["state"]= {
				},
			},
			[3]= {
				["state"]= {
				},
			},
		},

	},
	[1401251] = {
		["bhEvent"] = "skill.1401259",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {140120009,},
				},
			},
			[2]= {
				["state"]= {
					["stateId"] = 1401202,
					["duration"] = 5,
				},
			},
			[1]= {
				["eventType"] = 1,
				["boxId"] = 1401251,
				["state"]= {
				},
			},
			[1001]= {
				["eventType"] = 1,
				["boxId"] = 1401252,
				["state"]= {
					["stateOperation"] = 1,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {1401205,},
				},
				["hitCue"]= {
					["cueList"] = {140120012,},
				},
			},
			[1002]= {
				["targetChoose"] = 7,
				["boxId"] = 1401253,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {140120012,},
				},
				["excludeTarget"] = 1,
			},
			[1003]= {
				["state"]= {
				},
				["addManaNumber"] = -6,
			},
			[13]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {140120013,140125001,140121006,},
				},
			},
			[20]= {
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {140120010,140120014,},
				},
			},
			[1004]= {
				["targetChoose"] = 7,
				["state"]= {
				},
				["addManaNumber"] = -6,
			},
			[1005]= {
				["targetChoose"] = 7,
				["state"]= {
				},
				["stunTime"] = 1,
			},
		},

		["actTime"] = 70,
		["hideEffect"] = 1,
		["videoActTime"] = 60,
		["videoActCue"]= {
			["cueList"] = {140128001,140121005,},
		},
		["hideTime"] = 10,
		["hideEvent"] = 2,
		["prepareCamera"] = 1,
		["prepareCamDruation"] = 25,
	},
	[1401202] = {
		["bhEvent"] = "skill.1401210",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {140120004,140121001,},
				},
			},
			[1]= {
				["unitDelay"] = 0.1,
				["flyCueId"] = 140120002,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1401201,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {140120003,140121002,},
				},
			},
		},

	},
	[1401222] = {
		["bhEvent"] = "skill.1401230",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {140120005,140121003,},
				},
			},
			[1]= {
				["unitDelay"] = 0.15,
				["flyCueId"] = 140120006,
				["boxType"] = 1,
				["eventType"] = 1,
				["state"]= {
					["stateId"] = 1401201,
					["duration"] = -999,
				},
				["hitCue"]= {
					["cueList"] = {140120007,},
				},
			},
			[3]= {
				["targetArea"] = 3,
				["state"]= {
					["stateOperation"] = 1,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {1401211,},
				},
			},
			[2]= {
				["targetChoose"] = 7,
				["unitDelay"] = 0.15,
				["flyCueId"] = 140120006,
				["boxType"] = 1,
				["state"]= {
					["stateId"] = 1401212,
					["duration"] = -999,
				},
				["hitCue"]= {
					["cueList"] = {140120007,140121004,},
				},
				["randomTargetNumber"] = 1,
				["excludeTarget"] = 1,
				["eventCondition"] = "1,1,1401211",
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
