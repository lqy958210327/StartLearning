local Data = {
["cueFile"] = "14007",
	[1400701] = {
		["bhEvent"] = "skill.1400701",
		["atkEvents"]= {
			[1]= {
				["unitDelay"] = 0.08,
				["flyCueId"] = 140070019,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1400701,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {140070020,140071006,},
				},
			},
			[100]= {
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {140070018,140071005,},
				},
			},
		},

	},
	[1400710] = {
		["bhEvent"] = "skill.1400701",
		["atkEvents"]= {
			[0]= {
				["unitDelay"] = 0.08,
				["flyCueId"] = 90010003,
				["boxType"] = 1,
				["eventType"] = 1,
				["boxId"] = 1400709,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {90010008,},
				},
			},
		},

	},
	[1400751] = {
		["bhEvent"] = "skill.1400751",
		["atkEvents"]= {
			[0]= {
				["targetArea"] = 3,
				["state"]= {
				},
				["atkCue"]= {
					["cueList"] = {140070021,140070022,140070023,140071007,},
				},
				["levelAtkEvents"]= {
					[2]= {
					},
					[3]= {
						["state"]= {
							["stateId"] = 1400702,
							["duration"] = 2,
						},
					},
					[4]= {
						["state"]= {
							["stateId"] = 1400702,
							["duration"] = 2,
						},
					},
					[5]= {
					},
					[6]= {
					},
				},

			},
			[1]= {
				["targetChoose"] = 4,
				["eventType"] = 1,
				["boxId"] = 1400751,
				["state"]= {
				},
			},
			[2]= {
				["targetArea"] = 3,
				["targetChoose"] = 4,
				["boxId"] = 1400752,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {140070015,},
				},
			},
			[1001]= {
				["targetArea"] = 3,
				["targetChoose"] = 4,
				["boxId"] = 1400753,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {140070024,},
				},
			},
		},

		["actTime"] = 50,
	},
	[1400721] = {
		["bhEvent"] = "skill.1400721",
		["atkEvents"]= {
			[0]= {
				["targetChoose"] = 7,
				["state"]= {
				},
			},
			[1002]= {
				["targetArea"] = 3,
				["targetChoose"] = 7,
				["boxId"] = 1400721,
				["state"]= {
				},
				["hitCue"]= {
					["cueList"] = {140070017,},
				},
				["levelAtkEvents"]= {
					[2]= {
					},
					[3]= {
						["addManaNumber"] = 20,
					},
					[4]= {
						["addManaNumber"] = 20,
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
