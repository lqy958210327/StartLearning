local Data = {
    ["skill.1590101"]={
        ["motion"]={
            ["events"]={
                ["effect1"]={
                    ["data"] = "Effects/Heros/15002/efx_15002_battle_attack_basic_01_1.prefab",
                    ["stringParameter"] = "Effects/Heros/15002/efx_15002_battle_attack_basic_01_1.prefab",
                    ["intParameter"] = 1,
                    ["functionName"] = "effect",
                    ["time"] = 0.0006033618,
                },
                ["audio2"]={
                    ["data"] = "Audios/SFX/Hero/hero_vocal_battle_15002_11_1.ogg",
                    ["stringParameter"] = "Audios/SFX/Hero/hero_vocal_battle_15002_11_1.ogg",
                    ["functionName"] = "audio",
                    ["time"] = 0.04315353,
                },
                ["atk3"]={
                    ["functionName"] = "atk",
                    ["time"] = 0.9266621,
                },
                ["supercancel4"]={
                    ["functionName"] = "supercancel",
                    ["time"] = 1.359097,
                },
            },
        },
        ["skillLength"] = 1.6,
        ["stateName"] = "skill1590101",
    },
    ["skill.1590151"]={
        ["motion"]={
            ["events"]={
                ["atk1"]={
                    ["intParameter"] = 100,
                    ["functionName"] = "atk",
                    ["time"] = 0.0556962,
                },
                ["VideoPause2"]={
                    ["functionName"] = "VideoPause",
                    ["time"] = 0.5113924,
                },
                ["atk3"]={
                    ["intParameter"] = 1,
                    ["functionName"] = "atk",
                    ["time"] = 1.225316,
                },
            },
        },
        ["skillLength"] = 2,
        ["stateName"] = "skill1590151",
    },
    ["skill.1590121"]={
        ["motion"]={
            ["events"]={
                ["atk1"]={
                    ["intParameter"] = 100,
                    ["functionName"] = "atk",
                    ["time"] = 0.04388186,
                },
                ["atk2"]={
                    ["intParameter"] = 1,
                    ["functionName"] = "atk",
                    ["time"] = 1.625049,
                },
            },
        },
        ["skillLength"] = 2.166667,
        ["stateName"] = "skill1590121",
    },

}
return Data
