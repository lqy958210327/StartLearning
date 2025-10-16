local Data = {
["cueFile"] = "14011",
	[1401109] = {
		["bhEvent"] = "skill.1401109",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {140110001,140111001,},
				},
			},
			[1]= {
				["unitDelay"] = 0.12,
				["flyCueId"] = 140110003,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1401109,
				["state"]= {
					["stateId"] = 1401105,
					["duration"] = 3,
				},
				["hitCue"]= {
					["cueList"] = {140110006,140111002,140110023,},
				},
			},
		},

	},
	[1401110] = {
		["bhEvent"] = "skill.1401110",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {140110002,140111003,},
				},
			},
			[1]= {
				["unitDelay"] = 0.12,
				["flyCueId"] = 140110003,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1401109,
				["state"]= {
					["stateId"] = 1401105,
					["duration"] = 3,
				},
				["hitCue"]= {
					["cueList"] = {140110006,140111004,140110023,},
				},
			},
		},

	},
	[1401111] = {
		["bhEvent"] = "skill.1401111",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {140110004,140111005,},
				},
			},
			[1]= {
				["unitDelay"] = 0.12,
				["flyCueId"] = 140110005,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1401109,
				["state"]= {
					["stateId"] = 1401105,
					["duration"] = 3,
				},
				["hitCue"]= {
					["cueList"] = {140110006,140111006,140110023,},
				},
			},
		},

	},
	[1401129] = {
		["bhEvent"] = "skill.1401129",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {140110007,140110018,140111007,},
				},
			},
			[1]= {
				["targetArea"] = 2,
				["targetChoose"] = 7,
				["unitDelay"] = 0.12,
				["flyCueId"] = 140110008,
				["boxType"] = 1,
				["state"]= {
					["stateId"] = 1401101,
					["duration"] = -999,
				},
				["hitCue"]= {
					["cueList"] = {140110009,140111008,},
				},
			},
			[1002]= {
				["targetChoose"] = 7,
				["delay"] = 0.1,
				["baseToTarget"] = 1,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1401130,
				["state"]= {
					["stateOperation"] = 2,
					["duration"] = 1.5,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {1401103,},
				},
				["hitCue"]= {
					["cueList"] = {140110024,},
				},
				["excludeTarget"] = 1,
				["eventCondition"] = "1,2,1401105",
			},
			[1004]= {
				["eventType"] = 1,
				["boxId"] = 1401131,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {140110021,},
				},
			},
			[1005]= {
				["targetChoose"] = 7,
				["unitDelay"] = 0.25,
				["flyCueId"] = 140110021,
				["baseToTarget"] = 1,
				["eventType"] = 1,
				["boxId"] = 1401131,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {140110021,},
				},
				["eventCondition"] = "1,2,1401105",
			},
			[1006]= {
				["targetChoose"] = 3,
				["delay"] = 0.3,
				["baseToTarget"] = 1,
				["boxType"] = 1,
				["state"]= {
					["stateId"] = 1401101,
					["duration"] = 3,
				},
			},
			[1007]= {
				["boxId"] = 1401129,
				["state"]= {
				},
				["disablePassive"] = 1,
			},
		},

		["skillTarget"] = 1,
	},
	[1401159] = {
		["bhEvent"] = "skill.1401159",
		["atkEvents"]= {
			[100]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {140110012,140110016,},
				},
			},
			[13]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {140110017,140115001,140111010,},
				},
			},
			[15]= {
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {140110013,},
				},
			},
			[1]= {
				["state"]= {
					["stateId"] = 1401103,
					["duration"] = 8,
				},
				["atkCue"]= {
					["cueList"] = {140113001,},
				},
				["hitCue"]= {
					["cueList"] = {140110014,10006003,},
				},
				["hitedAnim"] = "Hit",
			},
			[1001]= {
				["eventType"] = 1,
				["boxId"] = 1401159,
				["state"]= {
					["stateId"] = 1401104,
					["duration"] = -999,
				},
			},
			[1002]= {
				["state"]= {
					["stateOperation"] = 1,
					["chooseStateMode"] = 2,
					["chooseStateIds"] = {1401104,},
				},
			},
			[2]= {
				["targetArea"] = 3,
				["state"]= {
				},
			},
			[1004]= {
				["targetChoose"] = 23,
				["state"]= {
					["stateOperation"] = 3,
					["stateId"] = 1401103,
				},
			},
			[1005]= {
				["targetChoose"] = 23,
				["state"]= {
					["stateOperation"] = 3,
					["stateId"] = 1401104,
				},
			},
			[99]= {
				["state"]= {
				},
				["hitedAnim"] = "end",
			},
		},

		["actTime"] = 84,
		["hideEffect"] = 1,
		["videoActTime"] = 70,
		["videoActCue"]= {
			["cueList"] = {140118001,140111009,},
		},
		["hideEvent"] = 13,
		["prepareCamera"] = 1,
		["prepareCamDruation"] = 25,
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
