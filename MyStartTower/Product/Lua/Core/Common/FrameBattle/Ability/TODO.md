### 不支持的旧字段

1. ResPassiveEffect
    1. effPrior
    1. reborn_disable
    1. triggerType==1 and triggerSubType==4
    1. triggerType==2 and triggerSubType==2
    1. triggerType==3 and triggerSubType==4
    1. triggerType==3 and triggerSubType==5
    1. triggerType==3 and triggerSubType==7
    1. triggerType==5 and triggerSubType==1 and triggerArgs[1] == 3
    1. triggerType==5 and triggerSubType==1 and triggerArgs[6] == 1 ！！！
    1. triggerType==5 and triggerSubType==6
    1. triggerType==6
    1. triggerType==9 

1. ResStateData
    1. state_lv必须从1开始连续递增
    1. addLayer
    1. addLayerByID
    1. isLayerStacks
    1. maxNum
    1. enhanceSkillId
    1. enhanceSkillRate
    1. conditionEnhanceId
    1. resistSkillId
    1. resistSkillRate
    state_invalid_type	state_invalid_number	attackerDeadClear	cantBePure
    rangeChanged

1. ResStateTrigger
1. ResStateSkillChange
1. ResStateSkillEnhance

1. 技能表Skill
    1. skillTarget == 2,5

1. 技能表Event
    1. targetChoose == 1 克罗斯比
    1. targetChoose == 2
    1. targetChoose == 22 罗克赛娜
    1. randomRule == 1,2,3,4,5,6,8,9
    1. subEventType == 0
    1. subEventCondition == 0
    1. subRandomEvents 露娜
    1. subRandomNum 露娜
    1. addManaProbId 艾赫勒娜
    1. summonMax
    1. isChuyin
    1. eventType == 0
    1. summonLineChoose ==  5,6

1. 技能表State
    1. stateProbId
    1. stateCondition
    1. stateOperation == 2,3,4,5

1. ResAttackEffect
    1. extra_last_damage
    1. extra_last_heal
    1. add_last_hurt
    1. extra_armor
    1. extra_passive_record
    1. final_dmg_type
    

1. ResHeroData
    1. attack_random

1. ResMonsterData
    1. pause_in_skill

1. ResMonsterSummonAttr 泰蕾莎

### 不支持的旧功能
1. 输出事件
    1. MATRIX_EVENT_ENTITY_TRIGGER_PASSIVE
1. BattleMiscConfig.BATTLE_MISS_CD_FRAME
1. 有无敌状态, 敌方不进行结算, 己方只结算治疗和有益状态
    改为己方结算
1. 复活逻辑
1. 眩晕受击时根据方向决定受击
    ? 改为永远在目标位置，不退回出发位置

### 需要支持旧功能

1. ConditionCheck.onCheckCondition
1. AttackCalc.onRandomControl
1. DamageCalc.calcDamageResult
1. 天气
1. 刷怪

### 想改
1. immuneSilence，damageImmune命名统一
1. speed属性
1. shield属性
1. 装备、玩法、战场Buff
1. 去掉CombatUtils
1. 增加射程属性 rangeChange
1. 属性campOvercomeAdd


### 加技能
1. ResHeroData.attackId
1. ResHeroData.skillId
1. ResHeroData.enterPassive
1. ResHeroData.heroPassive
1. ResHeroData.captainPassive
1. ResEquipSuit.passiveId
1. ResEquipSuit.stateId
1. ResEmblemSuit.passiveId
1. ResEmblemSuit.stateId
1. ResHeroSoulStoneSkill.skillId
1. ResHeroSoulStoneHeroSkill.skillId



# 战斗属性修改

### SkillConfig技能分组表增加（已完成）
- mana_gen 使用时获得的mana基础值
- mana_cost 使用时需扣除的mana值
- skill_cd 已有，代表冷却时间
- init_cd 首次施放前的冷却时间
- use_speedup 是否受攻速影响
- timer_shoot 是否按时间自动施放（普攻、主动技）
- input_shoot 是否受玩家输入施放/设置自动施放（大招）
- trigger_shoot 是否可被触发施放（被动）

### 去掉英雄和怪物属性
- attack_mana_gen 改用技能的mana_gen
- attack_cd 改用技能的skill_cd和init_cd

### ResAttr属性配置表增加属性
- skill_dmgup_per_1 普攻伤害提升（与ca_percent相乘）
- skill_dmgup_per_2 大招伤害提升（与sp_percent相乘）
- skill_dmgup_per_3 主动技伤害提升
- skill_dmgup_per_4 被动技能伤害提升
- skill_dmgreduce_per_1 普攻伤害降低
- skill_dmgreduce_per_2 大招伤害降低
- skill_dmgreduce_per_3 主动技伤害降低
- skill_dmgreduce_per_4 被动技能伤害降低
- skill_cdr_1 普攻cd降低
- skill_cdr_2 大招cd降低
- skill_cdr_3 主动技cd降低
- skill_cdr_4 被动技能cd降低
- skill_haste_1 普攻急速系数
- skill_haste_2 大招急速系数
- skill_haste_3 主动技急速系数（需要配置默认值100）
- skill_haste_4 被动技能急速系数
- final_skill_cdr_1 最终普攻cd降低
- final_skill_cdr_2 最终大招cd降低
- final_skill_cdr_3 最终主动技cd降低
- final_skill_cdr_4 最终被动技能cd降低
- final_attack_speed_up 最终攻速提升
- final_mana_genrate 最终回能效率
- final_mana_gen 最终回能
- damage_reflection 伤害反弹
- life_steal 吸血
- damage_protection 伤害保护（保护多大比例的HP不受伤害）
- heal_effect 治疗效果
- heal_enhance_percent 被治疗加成
- shield_effect 护盾效果
- shield_enhance_percent 受护盾加成
- final_atk 最终攻击力
- final_mhp 最终最大生命
- final_p_def 最终物理攻击
- final_m_def 最终魔法攻击
- hp 当前生命值
- mana 当前能量值
- shield_1 当前护盾值
- max_shield_1 最大护盾值
- shield_2 当前高级护盾值
- max_shield_2 最大高级护盾值
- attack_range 攻击距离（单位是万分之一格，一格是10000单位，需要配置默认值10000）
- speed 移动速度（单位是万分之一格每秒，需要配置默认值12500）

### ResState状态表
- reboundInjury改叫damage_reflection
- vampirePercent改叫life_steal
- shieldEnhance改叫shield_effect
- beShieldEnhance改叫shield_enhance_percent
- rangeChange改叫attack_range，单位改为万分之一格
- 去掉enhanceSkillId,enhanceSkillRate,resistSkillId,resistSkillRate。按技能类型修正改用属性，按技能ID修正用技能逻辑判断buff层数。
- 去掉onceMaxHurtPercent。改用damage_protection属性（注意：含义是相反的，damage_protection指保护多少HP不受伤害，原onceMaxHurtPercent指受到的单次最大伤害值）

### 英雄表和怪物表
- speed单位改为万分之一格每秒，原值3改为12500

### 去掉属性
- campOvercomeAdd
- beCampOvercomeAdd

### 攻击类型
- 物理攻击 物防、暴击、格挡、技能系数、伤害系数、元素系数、护盾、连接、反弹、吸血
- 生命移除 技能系数、护盾
- 治疗 技能系数、治疗系数  
- 加盾 技能系数、护盾系数

### 加成系数
- 技能系数： ca_percent, sp_percent
- 治疗系数： heal_effect, heal_enhance_percent
- 护盾系数： shield_effect, shield_enhance_percent
- 伤害系数： damage_percent, damage_reduce_percent, pvp_dmgup_per, pvp_dmgreduce_per, battlerate_dmgup_per, battlerate_dmgreduce_per, skill_dmgup_per_X, skill_dmgreduce_per_X
- 元素系数： elem_enhance_X, elem_resist_X