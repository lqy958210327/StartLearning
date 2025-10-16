

-- 设计目的：要用这套结构替换原有的 BattleActor, Entity, BattleActorMgr，原有的 BattleActor 太冗余，功能耦合性高，需要按模块拆分
-- 设计思路：数据结构采用 Entity(实体) + Component(组件), 逻辑抽象成静态方法, 对外的接口只有两种，一种是EntityCmd, 一种是EntityManager里注册事件
-- 注意：这不是ECS系统，战斗盒子里有战斗单位，客户端的战斗单位只做表现，所以也就没有必要上ecs系统
-- 重点注意：Component里不要加逻辑算法，只允许加一些简单的 get 和 set 方法，逻辑算法统一做成静态方法

--
require("Framework/Game/System/EC/Define")
require("Framework/Game/System/EC/EntityDict")
require("Framework/Game/System/EC/EntityManager")

--Entity
require("Framework/Game/System/EC/Entity/BaseEntity")
require("Framework/Game/System/EC/Entity/BattleEntity")

--component
require("Framework/Game/System/EC/Component/BaseEntityComp")
require("Framework/Game/System/EC/Component/EntityCompBattleActor")
require("Framework/Game/System/EC/Component/EntityCompBattleListener")
require("Framework/Game/System/EC/Component/EntityCompFx")
require("Framework/Game/System/EC/Component/EntityCompInfo")
require("Framework/Game/System/EC/Component/EntityCompProp")
require("Framework/Game/System/EC/Component/EntityCompSkillCache")
require("Framework/Game/System/EC/Component/EntityCompBuff")


--Command
require("Framework/Game/System/EC/EntityCmd/EntityCmd")
require("Framework/Game/System/EC/EntityCmd/EntityCmdBaseInfo")
require("Framework/Game/System/EC/EntityCmd/EntityCmdBattleActor")
require("Framework/Game/System/EC/EntityCmd/EntityCmdDummy")
require("Framework/Game/System/EC/EntityCmd/EntityCmdFx")
require("Framework/Game/System/EC/EntityCmd/EntityCmdHud")
require("Framework/Game/System/EC/EntityCmd/EntityCmdMesh")
require("Framework/Game/System/EC/EntityCmd/EntityCmdTransform")
require("Framework/Game/System/EC/EntityCmd/EntityCmdBuff")
