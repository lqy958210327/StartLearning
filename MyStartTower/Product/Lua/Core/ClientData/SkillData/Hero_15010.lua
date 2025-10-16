local Data = {
["cueFile"] = "14007",
	[1501009] = {
		["bhEvent"] = "skill.1501009",
		["atkEvents"]= {
			[0]= {
				["unitDelay"] = 0.08,
				["flyCueId"] = 140070001,
				["boxType"] = 1,
				["boxId"] = 1501009,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {140070002,140071001,},
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
					["cueList"] = {140070003,},
				},
			},
		},

	},
	[1501010] = {
		["bhEvent"] = "skill.1501009",
		["atkEvents"]= {
			[0]= {
				["unitDelay"] = 0.08,
				["flyCueId"] = 90010003,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1501009,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {90010008,},
				},
			},
		},

	},
	[1501021] = {
		["bhEvent"] = "skill.1501021",
		["atkEvents"]= {
			[1]= {
				["targetArea"] = 3,
				["targetChoose"] = 7,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {140070004,140070005,},
				},
			},
			[10]= {
				["state"]= {
				},
			},
			[2]= {
				["targetArea"] = 3,
				["targetChoose"] = 4,
				["state"]= {
					["stateId"] = 1501002,
					["duration"] = -999,
				},
				["hitCue"]= {
					["cueList"] = {140070008,},
				},
				["excludeTarget"] = 1,
			},
		},

		["actTime"] = 40,
	},
	[1501059] = {
		["bhEvent"] = "skill.1501059",
		["atkEvents"]= {
			[10]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {140070011,140070014,},
				},
			},
			[2]= {
				["targetArea"] = 3,
				["targetChoose"] = 4,
				["boxId"] = 1501059,
				["state"]= {
					["stateId"] = 1501001,
					["duration"] = 10,
				},
				["hitCue"]= {
					["cueList"] = {140070008,140070017,},
				},
				["randomTargetNumber"] = 1,
				["randomRule"] = 1,
			},
		},

		["actTime"] = 60,
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
