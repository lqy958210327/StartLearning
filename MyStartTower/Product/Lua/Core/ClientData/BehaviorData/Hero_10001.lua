local Data = {
    ["skill.10001"]={
        ["motion"]={
            ["events"]={
                ["effect1"]={
                    ["data"] = "Effects/Heros/10001/H001_battle_attack_basic_01.prefab",
                    ["stringParameter"] = "Effects/Heros/10001/H001_battle_attack_basic_01.prefab",
                    ["functionName"] = "effect",
                },
                ["atk2"]={
                    ["functionName"] = "atk",
                    ["time"] = 0.5696428,
                },
                ["supercancel3"]={
                    ["functionName"] = "supercancel",
                    ["time"] = 0.8413691,
                },
            },
        },
        ["skillLength"] = 1.466667,
        ["stateName"] = "skill10001",
    },
    ["skill.10002"]={
        ["motion"]={
            ["events"]={
                ["effect1"]={
                    ["data"] = "Effects/Heros/10001/H001_battle_attack_basic_02.prefab",
                    ["stringParameter"] = "Effects/Heros/10001/H001_battle_attack_basic_02.prefab",
                    ["functionName"] = "effect",
                },
                ["atk2"]={
                    ["functionName"] = "atk",
                    ["time"] = 0.4205357,
                },
                ["supercancel3"]={
                    ["functionName"] = "supercancel",
                    ["time"] = 0.9736608,
                },
            },
        },
        ["skillLength"] = 1.2,
        ["stateName"] = "skill10002",
    },
    ["skill.10101"]={
        ["motion"]={
            ["events"]={
                ["offset1"]={
                    ["data"] = "start",
                    ["stringParameter"] = "start",
                    ["floatParameter"] = 1,
                    ["functionName"] = "offset",
                },
                ["atk2"]={
                    ["intParameter"] = 1,
                    ["functionName"] = "atk",
                },
                ["camera3"]={
                    ["data"] = "Camera/CameraCurvy/Heroes/10001/AnimationOffset.anim",
                    ["stringParameter"] = "Camera/CameraCurvy/Heroes/10001/AnimationOffset.anim",
                    ["floatParameter"] = 25,
                    ["functionName"] = "camera",
                },
                ["effect4"]={
                    ["data"] = "Effects/Heros/10001/H001_battle_attack_ultra_01_1.prefab",
                    ["stringParameter"] = "Effects/Heros/10001/H001_battle_attack_ultra_01_1.prefab",
                    ["functionName"] = "effect",
                    ["time"] = 1.287554,
                },
                ["atk5"]={
                    ["functionName"] = "atk",
                    ["time"] = 1.431605,
                },
                ["atk6"]={
                    ["functionName"] = "atk",
                    ["time"] = 1.813975,
                },
                ["atk7"]={
                    ["intParameter"] = 10,
                    ["functionName"] = "atk",
                    ["time"] = 3.662375,
                },
                ["atk8"]={
                    ["intParameter"] = 99,
                    ["functionName"] = "atk",
                    ["time"] = 3.908555,
                },
                ["atk9"]={
                    ["intParameter"] = 11,
                    ["functionName"] = "atk",
                    ["time"] = 5.541462,
                },
                ["offset10"]={
                    ["data"] = "stop",
                    ["stringParameter"] = "stop",
                    ["floatParameter"] = 1,
                    ["functionName"] = "offset",
                    ["time"] = 6.380543,
                },
                ["atk11"]={
                    ["intParameter"] = 100,
                    ["functionName"] = "atk",
                    ["time"] = 6.666667,
                },
            },
        },
        ["skillLength"] = 6.666667,
        ["stateName"] = "skill10101",
    },

}
return Data
