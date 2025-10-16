
SkillTimeEnumDefine = {}

local TargetTypeEnum = 
{
    Self = 0, --自身
    Targets = 1, --目标
    Others = 2, --其他（除自身和目标之外的其他角色）
    All = 3, --所有角色
}

local ObjectTypeEnum =
{
    Light = 0, --灯光
    Object = 1, --物体
    SkyBox = 2, --天空盒
    Effect = 3, --特效
}

local UITypeEnum =
{
    UIRoot = 0, --控制UI界面的显示隐藏。
    BattleNum = 1, --战斗数字
    BossHp = 2, --boss血条
    BattleDamgeEffect = 3, --战斗累计伤害数字
    BattleHealEffect = 4, --战斗累计治疗显示
}

local ParentTypeEnum =
{
    Self = 0, --自身
    Target = 1, --目标
    Scene = 2, --场景
}

local AssetTypeEnum =
{
    Timeline = 0,
    Prefab = 1,
}

SkillTimeEnumDefine.TargetTypeEnum = TargetTypeEnum ---@enum SkillTimeEnumDefine.TargetTypeEnum 场景目标类型
SkillTimeEnumDefine.ObjectTypeEnum = ObjectTypeEnum ---@enum SkillTimeEnumDefine.ObjectTypeEnum 场景切换类型
SkillTimeEnumDefine.UITypeEnum = UITypeEnum ---@enum SkillTimeEnumDefine.UITypeEnum UI类型
SkillTimeEnumDefine.ParentTypeEnum = ParentTypeEnum ---@enum SkillTimeEnumDefine.ParentTypeEnum 父节点类型
SkillTimeEnumDefine.AssetTypeEnum = AssetTypeEnum ---@enum SkillTimeEnumDefine.AssetTypeEnum 资源类型