local PropConfig = require "Core/Common/FrameBattle/PropConfig"

-- 战斗相关的常量
local BattleConst = {}

BattleConst.GRID_SIZE = 2.35              -- grid的边长
BattleConst.ACTOR_SPEED = 4         -- 推图巡逻表现的速度

--behavior的事件：
BattleConst.BEHAVIOR_NOTICE_EVENT = 1
BattleConst.BEHAVIOR_IGNORE = 3
-----战斗中人物的状态常量------
BattleConst.COMBAT_STATE_NONE = -1      --None
BattleConst.COMBAT_STATE_IDLE = 0       --待机
BattleConst.COMBAT_STATE_ATK = 1        --攻击
BattleConst.COMBAT_STATE_HITED = 2        --受击
BattleConst.COMBAT_STATE_DEATH   = 3     --死亡
BattleConst.COMBAT_STATE_WAIT = 4       -- 等待的特殊的表现

----各个状态的默认动作入口-------
BattleConst.DEFAULT_BH_STATE ={
    [BattleConst.COMBAT_STATE_IDLE] = "idle",
    [BattleConst.COMBAT_STATE_DEATH] = "Die",
    [BattleConst.COMBAT_STATE_WAIT] = "wait",
}

-- 输入事件类型常量  1.使用技能  2.关闭/开启自动
BattleConst.INPUT_EVENT_USE_SKILL = 1
BattleConst.INPUT_EVENT_SET_AUTO = 2 -- 0自动   1手动
BattleConst.INPUT_EVENT_SET_SHORT = 3
BattleConst.INPUT_EVENT_LEAVE = 4


BattleConst.MATRIX_ENTITY_START_FRAME = 1
BattleConst.MATRIX_ENTITY_PREPARE_FRAME = 5
BattleConst.MATRIX_DEFAULT_MAX_TIME = 90

-- 黑盒事件发生会在客户端注册到EventCenter中 此类型应唯一 区分EventConst中的定义
BattleConst.MATRIX_EVENT_BATTLE_START = 100
BattleConst.MATRIX_EVENT_BATTLE_OVER = 101
BattleConst.MATRIX_EVENT_BATTLE_TIME = 102
BattleConst.MATRIX_EVENT_MONSTER_WAVE = 103
--BattleConst.MATRIX_EVENT_MONSTER_WAVE_DEAD = 104
BattleConst.MATRIX_EVENT_ADD_TRAP = 105
BattleConst.MATRIX_EVENT_DEL_TRAP = 106
BattleConst.MATRIX_EVENT_ADD_WEATHER = 107
BattleConst.MATRIX_EVENT_DEL_WEATHER = 108
BattleConst.MATRIX_EVENT_ACTION_END = 109

BattleConst.MATRIX_EVENT_ENTITY_DAMAGE = 200
BattleConst.MATRIX_EVENT_ENTITY_HPCHANGE = 201
BattleConst.MATRIX_EVENT_ENTITY_ADDSTATE = 202
BattleConst.MATRIX_EVENT_ENTITY_DELSTATE = 203
BattleConst.MATRIX_EVENT_ENTITY_PAUSEBH = 204
BattleConst.MATRIX_EVENT_ENTITY_CANCELPAUSEBH = 205
BattleConst.MATRIX_EVENT_ENTITY_PLAYCUE = 206
BattleConst.MATRIX_EVENT_ENTITY_SETMANA = 207
BattleConst.MATRIX_EVENT_ENTITY_LOCK_TARGET = 208
--BattleConst.MATRIX_EVENT_ENTITY_PLAY_EFFECT = 209
BattleConst.MATRIX_EVENT_ENTITY_PLAY_CAMERA = 210
BattleConst.MATRIX_EVENT_ENTITY_SHIELD_CHANGE = 211
BattleConst.MATRIX_EVENT_ENTITY_DEAD = 212
BattleConst.MATRIX_EVENT_ENTITY_SKILL_BEGIN = 214
BattleConst.MATRIX_EVENT_ENTITY_SKILL_END = 215
BattleConst.MATRIX_EVENT_ENTITY_SKILL_JUMP = 216
BattleConst.MATRIX_EVENT_ENTITY_SKILL_BACK = 217
BattleConst.MATRIX_EVENT_ENTITY_HITED_AIM = 218
BattleConst.MATRIX_EVENT_ENTITY_MOVE = 219
BattleConst.MATRIX_EVENT_ENTITY_BEHAVIOR_ANIM = 220
BattleConst.MATRIX_EVENT_ENTITY_CACHE_SKILL = 221
BattleConst.MATRIX_EVENT_ENTITY_HITED_OFFSET = 222
BattleConst.MATRIX_EVENT_ENTITY_MOVE_TO = 223
BattleConst.MATRIX_EVENT_ENTITY_STATE_ENTER = 224
BattleConst.MATRIX_EVENT_ENTITY_STATE_EXIT = 225
BattleConst.MATRIX_EVENT_ENTITY_STATESHOW = 226
BattleConst.MATRIX_EVENT_ENTITY_SOMETHING = 227
BattleConst.MATRIX_EVENT_ENTITY_MANA_CHANGED = 228
--BattleConst.MATRIX_EVENT_ENTITY_PLAYHITCUE = 229
BattleConst.MATRIX_EVENT_SUMMON_MONSTER = 230
BattleConst.MATRIX_EVENT_ENTITY_IDLE_ANIM = 231
BattleConst.MATRIX_EVENT_ENTITY_PLAY_ANIM = 232
BattleConst.MATRIX_EVENT_ENTITY_SKILL_HIDE = 233
BattleConst.MATRIX_EVENT_ENTITY_SKILL_HIDE_CANCEL = 234
BattleConst.MATRIX_EVENT_ADD_ENTITY = 235
BattleConst.MATRIX_EVENT_DEL_ENTITY = 236
BattleConst.MATRIX_EVENT_MONSTER_ENTER = 237
BattleConst.MATRIX_EVENT_ENTITY_SKILL_MOVIE = 238
BattleConst.MATRIX_EVENT_ENTITY_MOVE_OUT_POS = 239
BattleConst.MATRIX_EVENT_REBORN_ENTITY = 240
BattleConst.MATRIX_EVENT_REBORN_ENTITY_START = 241
BattleConst.MATRIX_EVENT_SPECIAL_DAMAGE_RECORD = 242
BattleConst.MATRIX_EVENT_CHANGE_CAMP = 243
BattleConst.MATRIX_EVENT_ENTITY_ADDPASSIVE = 244
BattleConst.MATRIX_EVENT_ENTITY_DELPASSIVE = 245
BattleConst.MATRIX_EVENT_ENTITY_TRIGGER_PASSIVE = 246
BattleConst.MATRIX_EVENT_ENTITY_PASSIVE_COUNT = 247
-- 闪现
BattleConst.MATRIX_EVENT_ENTITY_SKILL_FLASH = 250

BattleConst.MATRIX_EVENT_ENTITY_HP_INIT = 251
BattleConst.MATRIX_EVENT_ENTITY_MANA_INIT = 252

BattleConst.ENTITY_STATE_HITED = 1

-------------------------------

-- 动作上挂接事件类型常量 1.攻击事件 2.位移事件
--- 动画配置
BattleConst.BEHAVIOR_EVENT_ATTACK = "atk"
BattleConst.BEHAVIOR_EVENT_SUPER_CANCEL = "supercancel"
BattleConst.BEHAVIOR_EVENT_OFFSET = "offset"
BattleConst.BEHAVIOR_EVENT_FLASH = "flash"
BattleConst.BEHAVIOR_EVENT_CAMERA = "camera"
BattleConst.BEHAVIOR_EVENT_VIDEO = "VideoPause"
BattleConst.BEHAVIOR_EVENT_PLAY_ANIM = "PlayAnim"
--- 逻辑附加
BattleConst.BEHAVIOR_EVENT_TO_IDLE_ANIM = "toIdleAnim"
BattleConst.BEHAVIOR_EVENT_SKILL_END = "SkillEnd"
BattleConst.BEHAVIOR_END = "BehaviorEnd"

BattleConst.EVENT_MAP ={
    [BattleConst.BEHAVIOR_EVENT_ATTACK] = BattleConst.BEHAVIOR_NOTICE_EVENT,
    [BattleConst.BEHAVIOR_EVENT_SUPER_CANCEL] = BattleConst.BEHAVIOR_NOTICE_EVENT,
    [BattleConst.BEHAVIOR_EVENT_OFFSET] = BattleConst.BEHAVIOR_NOTICE_EVENT,
    [BattleConst.BEHAVIOR_EVENT_FLASH] = BattleConst.BEHAVIOR_NOTICE_EVENT,
    [BattleConst.BEHAVIOR_EVENT_CAMERA] = BattleConst.BEHAVIOR_NOTICE_EVENT,
    [BattleConst.BEHAVIOR_EVENT_VIDEO] = BattleConst.BEHAVIOR_NOTICE_EVENT,
    [BattleConst.BEHAVIOR_EVENT_PLAY_ANIM] = BattleConst.BEHAVIOR_NOTICE_EVENT,               -- 一些特殊逻辑下的表现层动作播放 比如变身后 为了保证动作的一致性  播放一个合适的能衔接的动作

    [BattleConst.BEHAVIOR_EVENT_TO_IDLE_ANIM] = BattleConst.BEHAVIOR_NOTICE_EVENT,             -- 技能结束因为结构问题不会立刻进入Idle状态  此处手动raise idle的behavior  黑盒此时还处于技能逻辑中
    [BattleConst.BEHAVIOR_EVENT_SKILL_END] = BattleConst.BEHAVIOR_NOTICE_EVENT,
    [BattleConst.BEHAVIOR_END] = BattleConst.BEHAVIOR_NOTICE_EVENT,

    --- 过时事件
    ["effect"] = BattleConst.BEHAVIOR_IGNORE,
    ["audio"] = BattleConst.BEHAVIOR_IGNORE,
    ["cue"] = BattleConst.BEHAVIOR_IGNORE,
    ["ToIdle"] = BattleConst.BEHAVIOR_IGNORE,
    ["LogicSkillEnd"] = BattleConst.BEHAVIOR_IGNORE,
    ["floattag"] = BattleConst.BEHAVIOR_IGNORE,
    ["overkill"] = BattleConst.BEHAVIOR_IGNORE,
    ["comeback"] = BattleConst.BEHAVIOR_IGNORE,
    ["chase"] = BattleConst.BEHAVIOR_IGNORE,
    ["AutoContinue"] = BattleConst.BEHAVIOR_IGNORE,
    ["UISelectCard"] = BattleConst.BEHAVIOR_IGNORE,
}

----------------------------------------------------------------------技能相关的宏定义-----------------------------------------------------------------------------------
-- 攻击盒子类型定义
BattleConst.BOX_TYPE_STATIC = 0
BattleConst.BOX_TYPE_THROW = 1

-- 攻击事件结果伤害类型 0.造成伤害 1.治疗 2.护盾 3.吸血  4.造成伤害(灵魂链接)
-- BattleConst.DAMAGE_TYPE_HURT = 'Hurt'
-- BattleConst.DAMAGE_TYPE_HEAL = 'Heal'
-- BattleConst.DAMAGE_TYPE_SHIELD = 'Shield'
-- BattleConst.DAMAGE_TYPE_VAMPIRE = 'Vampire'
-- BattleConst.DAMAGE_TYPE_LINK = 'Link'
-- BattleConst.DAMAGE_TYPE_MISS = 'Miss'            -- 闪避了此次攻击
-- BattleConst.DAMAGE_TYPE_REBOUND = 'Rebound'         -- 反弹
-- --BattleConst.DAMAGE_TYPE_DISPEL_SHIELD = 'HurtShield'   -- 驱散护盾
-- BattleConst.DAMAGE_TYPE_HP_REMOVE = 'Hurt'      -- 血量移除 真实伤害
-- BattleConst.DAMAGE_TYPE_HP_SHIELD_REMOVE = 'Hurt'      -- 血量护盾 移除
-- BattleConst.DAMAGE_TYPE_SELF_HEAL = 'Heal'
-- --BattleConst.DAMAGE_TYPE_HURT_ICE = 11       -- 火伤
-- --BattleConst.DAMAGE_TYPE_HURT_FIRE = 12      -- 冰伤
-- BattleConst.DAMAGE_TYPE_HURT_IMMUE = 'Immune'            -- 免疫了此次攻击  两个地方  闪避之前判定和攻击事件内部判定
-- BattleConst.DAMAGE_TYPE_HURT_SHIELD = 'HurtShield'            -- 护盾减少

-- BattleConst.HURT_DICT = {
--     [BattleConst.DAMAGE_TYPE_HURT] = true,
-- --    [BattleConst.DAMAGE_TYPE_HURT_ICE] = true,
-- --    [BattleConst.DAMAGE_TYPE_HURT_FIRE] = true,
-- }

BattleConst.CAMP_BLUE = "kBattleFormationCampTypeBlue"     -- 蓝色阵营
BattleConst.CAMP_RED = "kBattleFormationCampTypeRed"       -- 红色阵营
BattleConst.CAMP_ENEMY = BattleConst.CAMP_RED        -- 怪物的阵营
BattleConst.CAMP_PLAYER = BattleConst.CAMP_BLUE   -- 单机时玩家自身的阵营
BattleConst.CAMP_PLAYER_IDX = 1
BattleConst.CAMP_ENEMY_IDX = 2

BattleConst.MAX_COMMON_MONSTER_NUMBER = 100                 -- 客户端最多的普通怪物数量  为其分配ID  召唤怪物不在此列

local PropConfigMap = {}

for _, propConfig in ipairs(PropConfig) do
    PropConfigMap[propConfig.propName] = propConfig
end
BattleConst.PropConfig=PropConfig
BattleConst.PropConfigMap=PropConfigMap

-- 客户端和服务器的属性同步规则  如符文等需要服务器和客户端进行属性同步的物品 会会使用int型传输
-- 如果修改了此key  需要通知客户端去修改BattleConst.PROP_TYPE_CONFIG
local PROP_TYPE_CONFIG = {}
for i, propConfig in ipairs(PropConfig) do
    PROP_TYPE_CONFIG[i] = propConfig.propName
end
BattleConst.PROP_TYPE_CONFIG = PROP_TYPE_CONFIG

-- 表现层跳字的显示定义
BattleConst.STATE_PROP_SHOW = {
    ['life_reply'] = {14,114},
    ['atk'] = {9,109},
    ['atk_percent'] = {9,109},
    ['p_def'] = {16,116},
    ['m_def'] = {13,113},
    ['p_def_percent'] = {16,116},
    ['m_def_percent'] = {13,113},
    ['mhp'] = {17,117},
    ['mhp_percent'] = {17,117},
    ['hit_rate'] = {nil, 2},  --下降才有提示，致盲
    ['cri_rate'] = {10,110},
    ['cri_dmg'] = {25,125},
    ['damage_percent'] = {12,112},
    --['damage_reduce_percent'] = {19,119},
    ['attack_speed_up'] = {11,111},
    ['silence'] = {nil,4},
    ['vampirePercent'] = {18,118},
    ['soulLink'] = {6},
	['heal_enhance_percent'] = {22, 122},
    ['mana_gen'] = {15, 115},
    ['fire_damage_reduce'] = {24, 124},
    ['ice_damage_reduce'] = {23, 123},
}
BattleConst.STATE_SHOW_STUN = 105   -- 眩晕
BattleConst.STATE_SHOW_IMMUNE = 111   -- 触发免疫
BattleConst.STATE_SHOW_KILL = 104   -- 击杀回能
BattleConst.STATE_SHOW_SHIELD = 102   -- 增加护盾
BattleConst.STATE_SHOW_MISS = 100   -- 闪避
BattleConst.STATE_SHOW_IMMUE_PHYSICS = 110   -- 物理免疫
BattleConst.STATE_SHOW_IMMUE_MAGIC = 110   -- 魔法免疫
BattleConst.STATE_SHOW_HURT_SHIELD = 103   -- 减少护盾

BattleConst.STATE_SHOW_FREEZE = 106         -- 被冰冻
BattleConst.STATE_SHOW_IMMUNE_DISARM = 112  
BattleConst.STATE_SHOW_IMMUNE_SILENCE = 113
BattleConst.STATE_SHOW_IMMUNE_CONTROL = 114
BattleConst.STATE_SHOW_IMMUNE_REDUCE_MANA = 115
BattleConst.STATE_SHOW_FLOAT = 109
BattleConst.STATE_SHOW_BLOCK = 101
BattleConst.STATE_SHOW_SLEEP = 108
BattleConst.STATE_SHOW_TIME_LOCK = 107

BattleConst.ENTITY_SOMETHING_DEL_STATE = "delState"                     -- 被驱散了的type
BattleConst.ENTITY_SOMETHING_IMMUE_PHYSICS = "immuPhysics"              
BattleConst.ENTITY_SOMETHING_IMMUE_MAGIC = "immuMagic"                 
BattleConst.ENTITY_SOMETHING_KILL_SOMEONE = "killOne"              -- 击杀了别人

-- 状态中应当合并的属性列表  后面的值用来快速判断  对于一些无敌等状态用这种方式来进行  在导表时候立即生成该状态的这个值
-- 其他需要合并的值  可以用属性初始化的方法去做  比如多个状态隐藏模型 只要检测出 隐藏模型 key的值大于0  就知道要隐身
BattleConst.STATE_DAMAGE_REBOUND = "reboundInjury"                      -- 伤害反弹
BattleConst.STATE_DAMAGE_IMMUNE = "damageImmune"                        -- 免疫伤害
BattleConst.STATE_PHYSICS_IMMUNE = "physicsImmune"                      -- 免疫物理伤害
BattleConst.STATE_MAGIC_IMMUNE = "magicImmune"                          -- 免疫魔法伤害
BattleConst.STATE_HEAL_IMMUNE = "healImmune"                            -- 免疫治疗
BattleConst.STATE_SILENCE = "silence"                                   -- 沉默
BattleConst.STATE_VAMPIRE_PERCENT = "vampirePercent"                    -- 百分比吸血
BattleConst.STATE_IMMUNE_SILENCE = "immuneSilence"                      -- 免疫沉默  一般只有BOSS才会有
BattleConst.STATE_IMMUNE_TAUNT = "immuneTaunt"                          -- 免疫嘲讽  一般只有BOSS才会有
BattleConst.STATE_IMMUNE_REDUCE_MANA = "immuneReduceMana"               -- 免疫消能  一般只有BOSS才会有
BattleConst.STATE_IMMUNE_DEBUFF = "immuneDebuff"                        -- 免疫debuff
BattleConst.STATE_UNDEAD = "unDead"                                     -- 不会死亡
BattleConst.STATE_RANGE_CHANGE = "rangeChange"                           -- 射程改变
BattleConst.STATE_LINK = "soulLink"                                     -- 链接
BattleConst.STATE_DISARM = "disarm"                                     -- 缴械
BattleConst.STATE_IMMUNE_DISARM = "immuneDisarm"                        -- 免疫缴械
BattleConst.STATE_IMMUNE_CONTROLLED = "immuneControlled"                -- 免疫控制技能
BattleConst.STATE_SHIELD_ENHANCE = "shieldEnhance"                      -- 护盾效果
BattleConst.STATE_BE_SHIELD_ENHANCE = "beShieldEnhance"                 -- 被护盾加强
BattleConst.STATE_BLOCK_RATE = "blockRate"                              -- 格挡率
--BattleConst.STATE_OVERCOME_ADD = "campOvercomeAdd"                      -- 阵营克制
--BattleConst.STATE_BE_OVERCOME_ADD = "beCampOvercomeAdd"                 -- 被阵营克制
--BattleConst.STATE_ONCE_HURT_PERCENT = "onceMaxHurtPercent"              -- 被打一次最大受伤阈值
BattleConst.STATE_CONTROLLED_RESIST = "controlledResist"                -- 控制抗性
BattleConst.STATE_CHANGE_CAMP = "changeCamp"                            -- 魅惑
BattleConst.STATE_IMMUNE_CHANGE_CAMP = "immuneChangeCamp"                   -- 免疫魅惑  一般只有BOSS才会有
BattleConst.STATE_FORBID_PASSIVE = "forbidPassive"                            -- 禁用被动
BattleConst.STATE_IMMUNE_FORBID_PASSIVE = "immuneForbidPassive"                            -- 免疫禁用被动







-- Event的目标选择   基点, 基点加背后一格, 基点加左右扇形, 基点加六宫, 基点当前行, 基点当前及相邻行, 基点当前列, 所有, 所有血量最低, 当前行最远, 所有英雄, 血量最低英雄
BattleConst.TARGET_CHOOSE_ONE = 0
BattleConst.TARGET_CHOOSE_ONE_AND_BACK = 1
BattleConst.TARGET_CHOOSE_ONE_AND_LR = 2
BattleConst.TARGET_CHOOSE_ONE_AND_NEAR = 3
BattleConst.TARGET_CHOOSE_ONE_LINE = 4
BattleConst.TARGET_CHOOSE_ONE_LINE_AND_NEAR = 5
BattleConst.TARGET_CHOOSE_ONE_ROW = 6
BattleConst.TARGET_CHOOSE_ALL = 7
BattleConst.TARGET_CHOOSE_MIN_HP = 8
BattleConst.TARGET_CHOOSE_LINE_FAREST = 9
BattleConst.TARGET_CHOOSE_ALL_HERO = 10
BattleConst.TARGET_CHOOSE_MIN_HP_HERO = 11
BattleConst.TARGET_CHOOSE_USE_SKILL_RECORDER = 12
BattleConst.TARGET_CHOOSE_MIN_HP_PERCENT = 13
BattleConst.TARGET_CHOOSE_MIN_HP_PERCENT_HERO = 14
BattleConst.TARGET_CHOOSE_BASE_MASTER = 15
BattleConst.TARGET_CHOOSE_ALL_SERVANT = 16
BattleConst.TARGET_CHOOSE_MY_SERVANT = 17
BattleConst.TARGET_CHOOSE_LINE_FRONT = 18
BattleConst.TARGET_CHOOSE_ALL_FRONT = 19
BattleConst.TARGET_CHOOSE_ALL_BACK = 20
BattleConst.TARGET_CHOOSE_ONE_AND_NEAR_TWO = 21
BattleConst.TARGET_CHOOSE_ONE_AND_LINE_BACK = 22
BattleConst.TARGET_CHOOSE_NEW_TARGET = 23
BattleConst.TARGET_CHOOSE_DEAD_HERO = 24
BattleConst.TARGET_CHOOSE_ALL_LINE_FAREST = 25
BattleConst.TARGET_CHOOSE_LINE_MIDDLE = 26
BattleConst.TARGET_CHOOSE_ALL_MIDDLE = 27
BattleConst.TARGET_CHOOSE_MIRROR_NEAREST = 28

-- 特效播放模式
BattleConst.EFFECT_MODE = {
    ["Normal"] = 0,     -- 普通静态特效
    ["Parabola"] = 1,   -- 抛物线飞行特效
    ["Link"] = 2,       -- 连接特效
    ["Screen"] = 3,     -- UI特效
}

BattleConst.CUE_PLAY_MODE = {
    ["PlayLength"] = 0,
    ["LoopTimes"] = 1,
    ["LogicControl"] = 2,
    ["Always"] = 3,
}

-- 触发类型
BattleConst.PASSIVE_TRIGGER_TYPE_HP_CHANGE = 1      -- 血量改变触发
BattleConst.PASSIVE_TRIGGER_TYPE_USE_CARD = 2       -- 使用技能触发
BattleConst.PASSIVE_TRIGGER_TYPE_ATTACK_RESULT = 3  -- 攻击结果触发
BattleConst.PASSIVE_TRIGGER_TYPE_IMMEDIATELY = 4    -- 立即触发
BattleConst.PASSIVE_TRIGGER_TYPE_BEING_ATTACKED_RESULT = 5  -- 被攻击结果触发
BattleConst.PASSIVE_TRIGGER_TYPE_SHIELD = 6         -- 护盾监控
BattleConst.PASSIVE_TRIGGER_TYPE_DEAD = 7           -- 死亡监控
BattleConst.PASSIVE_TRIGGER_TYPE_GAME_WIN = 8       -- 战斗完全结束并胜利  迷宫这种用来做自动回血
BattleConst.PASSIVE_TRIGGER_TYPE_SIMPLE_EVENT = 9   -- 简单的一次性事件触发规则  比如免疫一次伤害等等
BattleConst.PASSIVE_TRIGGER_TYPE_USE_CARD_END = 10  -- 使用技能结束触发

BattleConst.PASSIVE_TRIGGER_ATTACK_HIT_RESULT = 1           -- 被动攻击结果：命中结果子类型
BattleConst.PASSIVE_TRIGGER_ATTACK_DISPEL = 2               -- 被动攻击结果：驱散
BattleConst.PASSIVE_TRIGGER_ATTACK_STATE = 3                -- 被动攻击结果：加状态
BattleConst.PASSIVE_TRIGGER_ATTACK_KILL = 4                 -- 被动攻击结果：被击杀或者击杀了人
BattleConst.PASSIVE_TRIGGER_ATTACK_MANA = 5                 -- 被动攻击结果：触发了降低别人能量的事情
BattleConst.PASSIVE_TRIGGER_ATTACK_CONTROLLED = 6           -- 被动攻击结果：触发了眩晕、冰冻等控制别人的行为
BattleConst.PASSIVE_TRIGGER_SPECIAL_DAMAGE = 7              -- 被动攻击结果：火焰、冰霜等伤害

BattleConst.PASSIVE_TRIGGER_SIMPLE_EVENT_SKILL = 1          -- 简单事件 释放技能
BattleConst.PASSIVE_TRIGGER_SIMPLE_EVENT_SUMMON = 2         -- 简单事件 召唤怪物
BattleConst.PASSIVE_TRIGGER_SIMPLE_MANA_ZERO = 3            -- 简单事件 能量变0
BattleConst.PASSIVE_TRIGGER_SIMPLE_PLAYER_NUM = 4           -- 简单事件 战斗内数量改变
BattleConst.PASSIVE_TRIGGER_SIMPLE_EVENT_REBORN = 5         -- 简单事件 复活

BattleConst.MAX_MANA = 10000
BattleConst.MAX_HP = 10000




BattleConst.DEFAULT_ATTACK_CD = 2.0         -- 策划在怪物表里填写定义的普攻间隔默认是2秒

-- 状态类型
BattleConst.STATE_TYPE_BUFF = 1
BattleConst.STATE_TYPE_DEBUFF = 2
BattleConst.STATE_TYPE_ALL = 0

BattleConst.STATE_DURATION_UNLIMIT = -999





---------------见下
BattleConst.BATTLE_TYPE_NONE = "kBattleTypeNone"
BattleConst.BATTLE_TYPE_STAGE = "kBattleTypeStage"              -- 推图
BattleConst.BATTLE_TYPE_MULTI_STAGE = "kBattleTypeMultipleStage"              -- 推图（多对主线）
BattleConst.BATTLE_TYPE_BOSSTOWER = "kBattleTypeBossTower"      -- BOSS塔 (囚魔至于)
BattleConst.BATTLE_TYPE_EQUIPTOWER = "kBattleTypeEquipTower"    -- 装备塔 (阵营圣塔)（现在叫迷宫）
BattleConst.BATTLE_TYPE_ASYNC_PVP = "kBattleTypeAsyncPVP"       -- （1V1竞技场）
BattleConst.FORMATION_TYPE_ASYNC_PVP = 'async_pvp'              -- （1V1竞技场） 防守
BattleConst.BATTLE_TYPE_MULTI_PVP = "kBattleTypeMultiPVP"                   -- （3V3竞技场）
BattleConst.BATTLE_TYPE_DEFEND_THREE_TEAM = "kBattleTypeDefendThreeTeam"    -- （3V3竞技场）防守
BattleConst.BATTLE_TYPE_WORLD_BOSS = "kBattleTypeWorldBoss"     -- 世界boss   天启狙击战
BattleConst.FORMATION_TYPE_UP_WORLD_BOSS = 'kBattleTypeUpWorldBoss' -- Up世界boss
BattleConst.FORMATION_TYPE_CAREER_EQUIP_STAGE = 'kBattleTypeCareerEquipStage' -- 职业本 (军团训练场)


BattleConst.BATTLE_TYPE_ELEMENT_EQUIPSTAGE = "kBattleTypeElementEquipStage"    -- 装备副本 (元素本)
BattleConst.BATTLE_TYPE_GUILD_BOSS = "kBattleTypeGuildBoss"              -- 公会boss








------------------------------------------ 废了  ------------------------------------------

------------------------------------------ 废了  ------------------------------------------









BattleConst.BATTLE_RESULT_WIN = "kPVEResultResultTypeWin"
BattleConst.BATTLE_RESULT_LOSE = "kPVEResultResultTypeLose"
BattleConst.BATTLE_RESULT_TIME_OUT = "kPVEResultResultTypeTimeOut"
BattleConst.BATTLE_RESULT_LEAVE = "kPVEResultResultTypeLeave"

BattleConst.BATTLE_SHOW_TIME_SCALE = 0.3
BattleConst.BATTLE_FINISH_TIME = 1.2 --unit:second







BattleConst.MAX_COMMON_MONSTER_NUMBER = 1000                -- 客户端最多的普通怪物数量  为其分配ID  召唤怪物不在此列
BattleConst.BATTLE_OVER_HEROS_ENTITY_ID=500000              -- 将战斗结算创建展示英雄的entityId定义为
BattleConst.ANIM_ACTOR_START_ID=501000              -- 将战斗结算创建展示英雄的entityId定义为
BattleConst.SHOW_ACTOR_ID_START = 600000                    -- 植物大战僵尸的表演怪
BattleConst.PERFORM_ACTOR_START = 700000                    -- 战场外面的表演角色ID
BattleConst.DRAG_OBJECT_START = 900000                      -- 布阵obj的起始

--local ResClientMacro = require("Core/ClientData/ResClientMacro")
local ResAttackMacro = DataTable.ResAttackMacro
BattleConst.BATTLE_ARMOR_ARG1 = ResAttackMacro['BATTLE_ARMOR_ARG1']     --100   --免伤率常量
BattleConst.BATTLE_ARMOR_ARG2 = ResAttackMacro['BATTLE_ARMOR_ARG2']     --0.2   --防御常量
BattleConst.KILL_MANA = ResAttackMacro['KILL_MANA']                     --20    --击杀常量
--BattleConst.BLOCK_REDUCE = ResAttackMacro['BLOCK_REDUCE']               --0.5   --减伤常量
BattleConst.ATK_CAPACITY = ResAttackMacro['ATK_CAPACITY']               --27    --攻击换算战力
BattleConst.DEF_CAPACITY = ResAttackMacro['DEF_CAPACITY']               --1     --防御换算战力

BattleConst.NEAR_CLIP_PLANE = 1
BattleConst.FAR_CLIP_PLANE = 2000

BattleConst.FORMATION_DEFAULT_NUM = 5
BattleConst.BATTLE_MAX_POS = 12
BattleConst.BATTLE_MAX_TRAP_INIT_NUM = 9




-- CLASS = 1,                         --猩潮
-- POPULAR = 2,                       --天马
-- LEGEND = 3,                        --伽拉
-- 攻击者前面  被克制的是后面阵营 
BattleConst.HERO_CAMP_OVERCOME = {
    [1] = 2,
    [2] = 3,
    [3] = 1,
    [4] = 5,
    [5] = 4,
}



-- 特殊逻辑怪物 可以考虑合成一体

BattleConst.HIDE_FORMATION_MONSTER_ID = 4100100 --隐藏阵容时用这个id创建怪物表现






--布阵阶段，编队操作的操作类型
BattleConst.DragTypeNone = 0 -- 无效操作
BattleConst.DragTypeAdd = 1 -- 新上阵一个单位到空白处
BattleConst.DragTypeRemove = 2 -- 移除一个单位
BattleConst.DragTypeChange = 3 -- 已上阵的两个单位互换位置
BattleConst.DragTypeReplace = 4 -- 新上阵一个单位把原有的单位替换
BattleConst.DragTypeMove = 5 -- 已上阵的一个单位移动到一个新的空白处


--BattleConst.DebugUseOldFightingUI = false


return BattleConst
