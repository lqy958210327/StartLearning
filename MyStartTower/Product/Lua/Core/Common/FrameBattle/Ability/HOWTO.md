# 如何编写能力脚本

## 系统简介

能力系统设计目的是为复杂技能效果提供标准化实现框架，从简单普攻到多阶段组合技均可通过配置化方式实现，提升战斗系统的扩展性和可维护性。

本系统采用声明式回调架构实现技能逻辑，具有以下核心特性：

1. **生命周期回调** - 提供onAttach/onDettach等状态管理钩子，onPrepareXXX系列预处理器
1. **事件响应机制** - 支持命中/受击/状态变化等战斗事件订阅
1. **模块化组合** - 通过ability:addAbility()实现复合技能效果堆叠

典型应用场景：
- 普攻连击：通过onPrepareSkillAtk控制多段攻击目标
- 治疗技能：在onSelfSkillHit中调用ability:healHp()
- 状态附加：利用onOwnerAttackDamage触发异常状态
- 全局事件：通过onGlobalKill实现击杀连锁反应

能力脚本开发者需要为每个能力实现一个lua脚本，在脚本中声明需要定制化处理的回调函数。回调函数的文档可查阅`AbilityConfig`。系统内置了传统风格的基于表格数据的默认脚本实现，可用于简化能力脚本的编写。

## 能力分类

能力脚本的运行逻辑取决于回调函数的实现。选择一个默认的分类可以引入该分类的默认设置，只需实现专注于定制化的特殊逻辑。

- **卡牌** - 主动使用技能的入口，管理技能的类型、优先级、冷却时间。一个卡牌可以包含多个技能，使用卡牌时可随机选择。默认实现是`AbilityConfigCard.lua`。核心回调函数是`AbilityConfig.onCheckCardUse`和`AbilityConfig.onSelfCardUse`。
- **技能** - 主动技能的核心逻辑，负责目标选择、技能表现控制、伤害计算等。默认实现是`AbilityConfigSkill.lua`。核心回调函数包括`AbilityConfig.onPrepareSkillParams`（参数准备）、`AbilityConfig.onPrepareSkillAtk`（攻击阶段处理）、`AbilityConfig.onPrepareSkillHit`（发射子弹）、`AbilityConfig.onSelfSkillHit`(命中处理)等。
- **状态** - 临时附加的状态效果，管理持续时间和状态叠加规则。默认实现是`AbilityConfigState.lua`。核心回调包含`AbilityConfig.onCheckAttach`、`AbilityConfig.onCheckIncStackLayer`、`AbilityConfig.onSelfStackLayerChanged`等叠层事件回调。
- **被动** - 被动触发的特殊效果，通过全局/角色事件监听实现与状态和技能的联动。默认实现是`AbilityConfigPassive.lua`。核心回调使用`AbilityConfig.onGlobalKill`（全局击杀）、`AbilityConfig.onOwnerHpChange`（角色血量变化）等事件订阅机制。

脚本类型不是硬性限制，任何脚本都可以注册全部回调函数。例如：可以在主动技能的脚本里增加事件响应回调，实现特殊的攻击加成逻辑；在状态脚本里增加事件响应回调，简便实现“生效X次”的效果。

## 命名规范

- 文件名格式为：编号_类别.lua
- 类别：卡牌card/主动skill/被动passive/状态state/其它script
- 示例：2100410_skill.lua

## 基本结构

- 能力脚本需要遵循以下模板：

```lua

local params = {
    skillId = 2100720
    cardId = 2100720
}

local AbilityConfig = {}

-- 能力挂载检查
function AbilityConfig:onCheckAttach()
    return false -- 返回true表示免疫挂载
end

-- 技能参数准备（主动技能的核心回调示例）
function AbilityConfig:onPrepareSkillParams()
    return params.skillId, params.cardId, self.Enum.SkillType.DaZhao
end

-- 其他回调函数...

-- 必须返回配置函数
return function(ability)
    ability:registerTriggerTable(AbilityConfig)
    -- 可在此处初始化技能自定义变量
    ability.damageFactor = 1.2 -- 自定义伤害系数
end
```

## 回调函数说明


### 生命周期回调

```lua
-- 能力挂载检查（返回true阻止挂载）
function AbilityConfig:onCheckAttach() end

-- 能力成功挂载时触发（初始化自定义数据的最佳时机）
function AbilityConfig:onSelfAttach() end

-- 能力卸载时触发（清理定时器/临时状态）
function AbilityConfig:onSelfDettach() end
```

### 技能流程回调

```lua
-- 技能参数准备（返回技能ID、卡牌ID、技能类型）
function AbilityConfig:onPrepareSkillParams()
    return 210001, 210001, self.Enum.SkillType.PuGong
end

-- 攻击阶段目标选择（返回目标单位列表）
function AbilityConfig:onPrepareSkillAtk(eventId, aimUnit)
    return {aimUnit} -- 示例：仅攻击选定目标
end

-- 命中处理（执行伤害/治疗等核心逻辑）
function AbilityConfig:onSelfSkillHit(eventId, aimUnit, hitUnit)
    local damage = self:getSkillLevel() * 100
    self:attackDamage(hitUnit, damage) -- 造成物理伤害
end
```

### 复合技能实现

```lua
-- 三段攻击技能示例
function AbilityConfig:onPrepareSkillAtk(eventId)
    local targets = {}
    if eventId == 1 then
        targets = self:selectFrontTargets() -- 第一段选择前排
    elseif eventId == 2 then
        targets = self:selectRandomTarget(2) -- 第二段随机2目标
    end
    return targets
end

function AbilityConfig:onSelfSkillHit(eventId, _, hitUnit)
    local multipliers = {1.0, 0.8, 1.2} -- 三段伤害系数
    local baseDamage = 500 * multipliers[eventId]
    self:attackDamage(hitUnit, baseDamage)
end
```

详细说明文档请参考`AbilityConfig`

## 主动技能流程图

如果下面没有显示流程图，可以访问 [网址](http://192.168.68.210:3000/slm/client/src/branch/master/slm_client/Product/Lua/Core/Common/FrameBattle/Ability/HOWTO.md) 查看。

`mermaid
flowchart TD
    A(卡牌使用) --> CCU{onCheckCardUse}
    CCU -->|允许使用| CSA{onCheckSkillAim}
    CSA -->|目标有效| PS[onPrepareSkillParams]
    CSA -->|目标无效| Z(流程终止)
    
    PS --> PSB[onPrepareSkillBehavior]
    PSB --> PSD[onPrepareSkillDisplay]
    PSD --> XPSP{需要有暂停表现}
    XPSP --> |有| PSP[onPrepareSkillPredict]
    XPSP --> |无| SCU[onSelfCardUse]
    PSP --> SCU
    SCU --> OUS[onOwnerUseSkill]

    OUS --> XSA{运行状态机}

    XSA --> |攻击段| PSA[onPrepareSkillAtk]
    PSA --> XSH{遍历攻击目标}
    XSH --> PSH[onPrepareSkillHit]
    PSH --> |设置定时器| TSH{运行计时器}
    TSH --> |子弹飞到目标| SSH[onSelfSkillHit]
    PSH --> XSH
    XSH --> |遍历完成| SSK[onSelfSkillAtk]
    SSK --> XSA
    XSA --> |技能结束| SSE[onSelfSkillEnd]
    SSE --> OSE[onOwnerSkillEnd]
    OSE --> Z
`

## 伤害计算公式说明

游戏中包含4种“攻击”类型：物理伤害、生命流失、治疗、增加护盾。

详细计算规则参考：

- 造成物理伤害：`Ability.attackDamage`，公式：`Unit.factorSkillDamage`
- 造成生命流失：`Ability.attackLoss`，公式：`Unit.factorSkillLoss`
- 造成治疗：`Ability.attackHeal`，公式：`Unit.factorSkillHeal`
- 造成护盾提升：`Ability.attackShield`，公式：`Unit.factorSkillShield`

## 调试

### 打印自定义日志

- 使用内置日志系统：

```lua
function AbilityConfig:onPrepareSkillParams()
    self:log("正在准备技能参数", self.skillId) -- 输出到战斗日志
    return self.skillId
end
```

### 排查脚本不生效问题

- 筛选日志关键字 `AbilityConfigLoader`
- 如果脚本加载失败，但有默认表格配置，会有一条warn日志，现象是技能存在但脚本中的逻辑不执行。
- 如果脚本加载失败，且没有表格配置，会有一条error日志，现象是完全没有这个技能。
- 如果脚本文件名不对，但有默认表格配置，会有一条普通日志，内容是“load default”，表示正常加载了没有脚本的技能，现象是技能存在但脚本中的逻辑不执行。
