local Data = {
["cueFile"] = "11010",
	[1101001] = {
		["bhEvent"] = "skill.1101001",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {110100001,110100003,110101001,},
				},
			},
			[1]= {
				["eventType"] = 1,
				["boxId"] = 1101001,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {110100005,},
				},
			},
			[1001]= {
				["eventType"] = 1,
				["boxId"] = 1101002,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000042,},
				},
				["disablePassive"] = 1,
			},
		},

	},
	[1101002] = {
		["bhEvent"] = "skill.1101002",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {110100002,110100004,110101002,},
				},
			},
			[1]= {
				["eventType"] = 1,
				["boxId"] = 1101001,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {110100005,},
				},
			},
		},

	},
	[1101021] = {
		["bhEvent"] = "skill.1101021",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
			},
			[1001]= {
				["targetArea"] = 3,
				["targetChoose"] = 10,
				["state"]= {
					["stateId"] = 1101001,
					["duration"] = -999,
				},
			},
			[1002]= {
				["targetArea"] = 1,
				["boxId"] = 1101021,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {110101003,110100006,},
				},
			},
			[1003]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {10000035,},
				},
				["addManaNumber"] = 10,
			},
			[1004]= {
				["targetArea"] = 3,
				["boxId"] = 1101022,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {110101003,110100006,},
				},
			},
			[1005]= {
				["targetArea"] = 3,
				["targetChoose"] = 8,
				["boxId"] = 1101022,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {110101003,110100006,},
				},
				["excludeTarget"] = 1,
			},
			[1]= {
				["state"]= {
				},
			},
			[1006]= {
				["targetArea"] = 3,
				["boxId"] = 1101023,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {110100006,},
				},
			},
		},

	},
	[1101051] = {
		["bhEvent"] = "skill.1101051",
		["atkEvents"]= {
			[100]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1101006,
					["duration"] = 5,
				},
				["atkCue"]= {
					["cueList"] = {110100007,110100008,110100009,110100022,},
				},
			},
			[1]= {
				["targetArea"] = 2,
				["targetChoose"] = 3,
				["unitDelay"] = 0.25,
				["flyCueId"] = 110100012,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1101051,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {110100020,110101006,},
				},
				["hitCue"]= {
					["cueList"] = {110100016,},
				},
				["randomTargetNumber"] = 1,
				["excludeTarget"] = 1,
			},
			[1001]= {
				["state"]= {
				},
				["controlTime"] = 0.9,
				["controlAniName"] = "freeze",
			},
			[1002]= {
				["state"]= {
				},
				["controlTime"] = 1.5,
				["controlAniName"] = "freeze",
			},
			[1003]= {
				["targetArea"] = 3,
				["boxId"] = 1101052,
				["state"]= {
					["stateId"] = 1101007,
					["duration"] = 5,
				},
				["hitCue"]= {
					["cueList"] = {10000025,},
				},
			},
			[4]= {
				["targetArea"] = 2,
				["targetChoose"] = 3,
				["unitDelay"] = 0.25,
				["flyCueId"] = 110100015,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1101051,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {110100020,110101006,},
				},
				["hitCue"]= {
					["cueList"] = {110100019,},
				},
				["randomTargetNumber"] = 1,
				["excludeTarget"] = 1,
			},
			[2]= {
				["targetArea"] = 2,
				["targetChoose"] = 3,
				["unitDelay"] = 0.25,
				["flyCueId"] = 110100013,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1101051,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {110100020,110101006,},
				},
				["hitCue"]= {
					["cueList"] = {110100017,},
				},
				["randomTargetNumber"] = 1,
				["excludeTarget"] = 1,
			},
			[3]= {
				["targetArea"] = 2,
				["targetChoose"] = 3,
				["unitDelay"] = 0.25,
				["flyCueId"] = 110100014,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1101051,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {110100020,110101006,},
				},
				["hitCue"]= {
					["cueList"] = {110100018,},
				},
				["randomTargetNumber"] = 1,
				["excludeTarget"] = 1,
			},
			[10]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {110100010,110100011,},
				},
			},
			[13]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {110105001,110100021,110101005,},
				},
			},
			[99]= {
				["targetArea"] = 2,
				["targetChoose"] = 3,
				["state"]= {
				},
			},
		},

		["actTime"] = 84,
		["hideEffect"] = 1,
		["videoActTime"] = 70,
		["videoActCue"]= {
			["cueList"] = {110108001,110101004,},
		},
		["hideTime"] = 10,
		["hideEvent"] = 99,
		["prepareCamera"] = 1,
		["prepareCamDruation"] = 40,
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
