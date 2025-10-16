local Data = {
["cueFile"] = "13101",
	[1310109] = {
		["bhEvent"] = "skill.1310109",
		["atkEvents"]= {
			[0]= {
				["unitDelay"] = 0.12,
				["flyCueId"] = 131010002,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1310109,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {131010003,131011002,},
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {131010001,131011001,},
				},
			},
		},

	},
	[1310159] = {
		["bhEvent"] = "skill.1310159",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {131010005,},
				},
			},
			[1]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1310101,
					["duration"] = 3,
				},
				["addManaNumber"] = -100,
				["manaNotShow"] = 1,
			},
			[0]= {
				["unitDelay"] = 0.05,
				["eventType"] = 1,
				["boxId"] = 1310159,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {131013001,},
				},
				["hitCue"]= {
					["cueList"] = {131010006,131011006,},
				},
				["hitedAnim"] = "Hit",
			},
			[11]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {131010007,131015001,131011004,131011005,},
				},
			},
			[90]= {
				["state"]= {
				},
				["hitedAnim"] = "end",
			},
		},

		["actTime"] = 71,
		["hideEffect"] = 1,
		["videoActTime"] = 65,
		["videoActCue"]= {
			["cueList"] = {131018001,131011003,},
		},
		["hideTime"] = 10,
		["hideEvent"] = 100,
		["prepareCamera"] = 1,
		["prepareCamDruation"] = 25,
		["skillTarget"] = 4,
	},
	[1310129] = {
		["bhEvent"] = "skill.1310129",
		["atkEvents"]= {
			[0]= {
				["targetChoose"] = 7,
				["eventType"] = 1,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {131010011,},
				},
				["randomTargetNumber"] = 1,
				["recordSkillTargets"] = 1,
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {131010008,131010009,131011007,},
				},
			},
			[1]= {
				["targetChoose"] = 7,
				["delay"] = 0.4,
				["eventType"] = 1,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {131010011,},
				},
				["randomTargetNumber"] = 1,
				["recordSkillTargets"] = 1,
			},
			[2]= {
				["targetChoose"] = 7,
				["delay"] = 0.4,
				["eventType"] = 1,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {131010011,},
				},
				["randomTargetNumber"] = 1,
				["recordSkillTargets"] = 1,
			},
			[10]= {
				["targetChoose"] = 12,
				["eventType"] = 1,
				["boxId"] = 1310129,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {131010010,131011002,},
				},
			},
			[11]= {
				["targetChoose"] = 12,
				["eventType"] = 1,
				["boxId"] = 1310129,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {131011002,131010010,},
				},
			},
			[12]= {
				["targetChoose"] = 12,
				["eventType"] = 1,
				["boxId"] = 1310129,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {131010010,131011002,},
				},
			},
		},

	},
	[1310171] = {
		["bhEvent"] = "skill.1310171",
		["atkEvents"]= {
			[1]= {
				["targetArea"] = 3,
				["state"]= {
					["stateId"] = 1310101,
					["duration"] = 3,
				},
				["addManaNumber"] = -100,
				["manaNotShow"] = 1,
			},
			[0]= {
				["unitDelay"] = 0.15,
				["flyCueId"] = 130030002,
				["eventType"] = 1,
				["boxId"] = 1310159,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {131013001,},
				},
				["hitCue"]= {
					["cueList"] = {131010006,131011006,},
				},
				["hitedAnim"] = "Hit",
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {131010005,},
				},
			},
			[11]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {131010007,131015001,131011004,131011005,},
				},
			},
			[90]= {
				["state"]= {
				},
				["hitedAnim"] = "end",
			},
		},

		["actTime"] = 71,
		["hideEffect"] = 1,
		["hideEvent"] = 100,
		["skillTarget"] = 4,
	},
	[1310130] = {
		["bhEvent"] = "skill.1310130",
		["atkEvents"]= {
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {131010008,131010012,131011008,},
				},
			},
			[0]= {
				["targetChoose"] = 7,
				["delay"] = 0.7,
				["eventType"] = 1,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {131010011,},
				},
				["randomTargetNumber"] = 1,
				["recordSkillTargets"] = 1,
			},
			[1]= {
				["targetChoose"] = 7,
				["delay"] = 0.4,
				["eventType"] = 1,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {131010011,},
				},
				["randomTargetNumber"] = 1,
				["recordSkillTargets"] = 1,
			},
			[2]= {
				["targetChoose"] = 7,
				["delay"] = 0.4,
				["eventType"] = 1,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {131010011,},
				},
				["randomTargetNumber"] = 1,
				["recordSkillTargets"] = 1,
			},
			[3]= {
				["targetChoose"] = 7,
				["delay"] = 0.5,
				["eventType"] = 1,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {131010011,},
				},
				["randomTargetNumber"] = 1,
				["recordSkillTargets"] = 1,
			},
			[10]= {
				["targetChoose"] = 12,
				["eventType"] = 1,
				["boxId"] = 1310129,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {131010010,131011002,},
				},
			},
			[11]= {
				["targetChoose"] = 12,
				["eventType"] = 1,
				["boxId"] = 1310129,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {131010010,131011002,},
				},
			},
			[12]= {
				["targetChoose"] = 12,
				["eventType"] = 1,
				["boxId"] = 1310129,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {131010010,131011002,},
				},
			},
			[13]= {
				["targetChoose"] = 12,
				["eventType"] = 1,
				["boxId"] = 1310129,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {131011002,},
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
