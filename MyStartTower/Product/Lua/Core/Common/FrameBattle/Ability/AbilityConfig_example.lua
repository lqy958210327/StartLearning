

--- @class AbilityConfig
--- @classmod AbilityConfig
--- @comment
--- 事件回调说明文档。
--- - 这里列出的是可以在技能配置脚本中使用的回调函数。
--- - 函数中self指Ability实例 （注意不是AbilityConfig本身）。
--- - 在实现回调函数中，可以设置Ability或Unit的变量，但变量名不要使用下划线开头。
--- - 为便于记忆，回调函数命名规律：
--- - onCheck指执行某些流程的前置检查，需要返回约定的值来启动相关功能。
--- - onPrepare指开始执行某个流程，需要返回约定的参数以在主流程中使用。
--- - onSelf指仅与本能力有关的触发器回调。
--- - onOwner指仅与本单位有关的触发器回调。
--- - onGlobal指全局广播的触发器回调。

local AbilityConfig = {}

--- 能力挂载检查（能力创建时调用）
--- @return boolean true=免疫挂载，false/nil=允许挂载
function AbilityConfig:onCheckAttach() end

--- Ability实例挂载
function AbilityConfig:onSelfAttach() end


--- 能力卸载检查（单位死亡时调用）
--- @return boolean true=需要卸载，false/nil=不卸载
function AbilityConfig:onCheckDettachDead() end

--- Ability实例卸载
--- @param fromUnit Unit 驱散行为的发起者
function AbilityConfig:onSelfDettach(fromUnit) end

--- 卡牌使用条件检查（施放前调用）
--- @return boolean use true表示可以使用
--- @comment 在此回调中应：
--- 1. 检查施法条件（如沉默状态、法力值等）
--- 2. 返回nil表示不满足使用条件
function AbilityConfig:onCheckCardUse() end

--- 卡牌使用选择技能
--- @return Ability skill 返回要使用的技能实例
--- @return integer priority 使用优先级（数值越大越优先）
--- @comment 在此回调中应：
--- 1. 通过返回技能实例和优先级参与卡牌选择
function AbilityConfig:onCheckCardUseSkill() end

--- 卡牌生效回调（施放成功后触发）
--- @comment 在此回调中处理：
--- 1. 设置技能冷却时间（调用setCooldown）
--- 2. 消耗卡牌资源（法力值等）
--- 3. 触发卡牌使用后的状态变化
function AbilityConfig:onSelfCardUse() end

--- 技能施法目标检查（释放前调用）
--- @return Unit|nil 返回技能施法目标单位，nil表示没有可用目标
function AbilityConfig:onCheckSkillAim() end

--- 技能参数准备（释放前调用）
--- @return skillId integer 技能ID
--- @return cardId integer 卡牌ID
--- @return skillType integer 技能类型
--- @see Enum.SkillType
function AbilityConfig:onPrepareSkillParams() end

--- 技能行为准备（释放前调用）
--- @return bhEvent table 技能动作数据
--- @return attackTime number|nil 攻击动作时长（普攻专用）
function AbilityConfig:onPrepareSkillBehavior() end

--- 技能表现准备（释放前调用）
--- @return pauseTime number 动作前暂停时间（单位：秒）
--- @return videoTime number 技能表现时长（单位：秒）
--- @return videoCue table 表现特效配置
function AbilityConfig:onPrepareSkillDisplay() end

--- 技能预测目标准备（释放前调用）
--- @param aimUnit Unit 技能施法目标单位
--- @return table 需要显示预测范围/效果的目标单位列表
function AbilityConfig:onPrepareSkillPredict(aimUnit) end

--- 技能攻击目标准备（攻击事件触发时调用）
--- @param eventId integer 攻击阶段ID（用于区分多段攻击）
--- @param aimUnit Unit 技能施法目标单位
--- @return table 本次攻击实际生效的目标单位列表
function AbilityConfig:onPrepareSkillAtk(eventId, aimUnit) end

--- 技能攻击开始回调（命中判定前触发）
--- @param eventId integer 攻击阶段ID
--- @param aimUnit Unit 技能施法目标单位
--- @comment 在此回调中可触发攻击音效、技能前摇表现等
function AbilityConfig:onSelfSkillAtk(eventId, aimUnit) end

--- 技能命中参数准备（实际命中前调用）
--- @param eventId integer 攻击阶段ID
--- @param aimUnit Unit 技能施法目标单位
--- @param hitUnit Unit 即将被命中的目标单位
--- @return number 飞行时间（单位：秒，用于伤害延迟计算）
--- @comment 在此计算弹道飞行时间。不包括攻击前摇时间，调用```onPrepareSkillAtk```和```onPrepareSkillHit```时前摇已经结束了。
function AbilityConfig:onPrepareSkillHit(eventId, aimUnit, hitUnit) end

--- 技能实际命中回调（最终伤害计算）
--- @param eventId integer 攻击阶段ID
--- @param aimUnit Unit 技能施法目标单位
--- @param hitUnit Unit 被命中的目标单位
--- 
--- - 在此回调中：
--- 1. 通过checkHitChance执行命中判定
--- 2. 应用伤害/治疗等战斗效果
--- 3. 触发受击表现（见checkHitChance参数）
function AbilityConfig:onSelfSkillHit(eventId, aimUnit, hitUnit) end

--- 技能结束
--- @param finish boolean 是否正常结束，true=完成，false=打断
function AbilityConfig:onSelfSkillEnd(finish) end

--- 卡牌释放通知
--- @param useAbility Ability 使用的能力对象
--- @param useCardId integer 使用的卡牌ID
--- @param skillType integer 技能类型
--- @see Enum.SkillType
--- @param targetUnit Unit 施法目标单位
function AbilityConfig:onOwnerUseSkill(useAbility, useCardId, skillType, targetUnit) end

--- 卡牌释放结束通知
--- @param useAbility Ability 使用的能力对象
--- @param useCardId integer 使用的卡牌ID
--- @param skillType integer 技能类型
--- @see Enum.SkillType
--- @param targetUnit Unit 施法目标单位
function AbilityConfig:onOwnerSkillEnd(useAbility, useCardId, skillType, targetUnit) end

--- 状态叠层条件检查
--- @param addLayer integer 请求叠加层数
--- @return integer|nil 实际允许叠加层数
--- 
--- - 返回nil表示没任何效果（被免疫）
--- - onCheckIncStackLayer返回值小于参数addLayer时，替换最老的若干层临时层数
--- - 因此，当有临时层数时，返回0和返回nil含义是不同的
function AbilityConfig:onCheckIncStackLayer(addLayer) end

--- 状态层数变化回调
--- @param layer integer 新层数
--- @param oldLayer integer 旧层数
function AbilityConfig:onSelfStackLayerChange(layer, oldLayer) end

--- 当本单位进入战斗。
function AbilityConfig:onOwnerEnterBattle() end

--- 当本单位造成了伤害
--- @param targetUnit Unit 被攻击的目标单位
--- @param damage integer 造成的实际伤害值
--- @param damageType string 伤害类型 ('hurtHp','healHp','hurtShield','healShield')
--- @param isCrit boolean 是否产生暴击
--- @param skillType integer 技能类型
--- @see Enum.SkillType
function AbilityConfig:onOwnerAttackDamage(targetUnit, damage, damageType, isCrit, skillType) end

--- 当本单位受到了伤害
--- @param attackerUnit Unit 发起攻击的来源单位
--- @param damage integer 承受的实际伤害值
--- @param damageType string 伤害类型 ('hurtHp','healHp','hurtShield','healShield')
--- @param isCrit boolean 是否被暴击
--- @param skillType integer 技能类型
--- @see Enum.SkillType
function AbilityConfig:onOwnerBeHitDamage(attackerUnit, damage, damageType, isCrit, skillType) end

--- 当本单位造成了属性诅咒
--- @param targetUnit Unit 被攻击的目标单位
--- @param attrName string 属性名
--- @param damage integer 造成的实际伤害值
--- @param skillType integer 技能类型
--- @see Enum.SkillType
function AbilityConfig:onOwnerAttackCurse(targetUnit, attrName, damage, skillType) end

--- 当本单位受到了属性诅咒
--- @param attackerUnit Unit 发起攻击的来源单位
--- @param attrName string 属性名
--- @param damage integer 造成的实际伤害值
--- @param skillType integer 技能类型
--- @see Enum.SkillType
function AbilityConfig:onOwnerBeHitCurse(attackerUnit, attrName, damage, skillType) end

--- 当本单位血量变化
--- @param hp integer 当前HP值
--- @param hppct integer 当前HP比例，万分比
function AbilityConfig:onOwnerHpChange(hp, hppct) end

--- 当本单位护盾变化
--- @param shield integer 当前护盾值
--- @param max_shield integer 最大护盾值
---
---shield=0时，max_shield=0是护盾事件结束或被驱散，max_shield>0是护盾被打破
function AbilityConfig:onOwnerShieldChange(shield, max_shield) end

--- 当本单位状态层数变化。
--- @param state Ability 发生变化的状态对象
function AbilityConfig:onOwnerStateLayerChange(state) end


--- 当本单位的攻击被闪避
--- @param targetUnit Unit 闪避了本次攻击的目标单位
function AbilityConfig:onOwnerAttackMiss(targetUnit)
end

--- 当本单位闪避了攻击
--- @param attackerUnit Unit 发起攻击的来源单位
function AbilityConfig:onOwnerBeHitMiss(attackerUnit)
end
--- 当本单位攻击造成了控制
--- @param targetUnit Unit 被控制了的目标单位
--- @param controlType string 控制类型
function AbilityConfig:onOwnerAttackControl(targetUnit, controlType)
end
--- 当本单位被击受到了控制
--- @param attackerUnit Unit 发起攻击的来源单位
--- @param controlType string 控制类型
function AbilityConfig:onOwnerBeHitControl(attackerUnit, controlType)
end
--- 当本单位被控制结束
--- @param controlType string 控制类型
function AbilityConfig:onOwnerBeHitControlEnd(controlType) end

--- 当本单位攻击造成了击杀
--- @param targetUnit Unit 被击杀了的目标单位
--- @param skillType integer 技能类型
--- @see Enum.SkillType
function AbilityConfig:onOwnerAttackKill(targetUnit, skillType)
end
--- 当本单位被击杀
--- @param attackerUnit Unit 发起攻击的来源单位
--- @param skillType integer 技能类型
--- @see Enum.SkillType
function AbilityConfig:onOwnerBeHitDie(attackerUnit, skillType)
end
--- 战场有单位死亡
--- @param attackerUnit Unit 发起攻击的来源单位
--- @param targetUnit Unit 被击杀了的目标单位
function AbilityConfig:onGlobalKill(attackerUnit, targetUnit)
end

--- 战斗波次结束（玩家团灭或清掉一波怪物）
--- @param deadUnit Unit 最后一个死掉的单位（败者方）
function AbilityConfig:onGlobalAced(deadUnit) end

--- 配置脚本返回一个函数，负责数据初始化、注册事件回调。
--- @param ability Ability 正在创建的Ability对象
local function ConfigFunction (ability)
    ability.mySpecialVariable = 1
    ability:registerTriggerTable(AbilityConfig)
end

return ConfigFunction