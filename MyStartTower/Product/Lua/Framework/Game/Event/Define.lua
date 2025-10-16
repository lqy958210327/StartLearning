


---@class SubBusKey
SubBusKey = {
    Battle = 1,
}


---@class EventType
EventType = {
    --skillTimeMgr
    RegisterSkillTimeEvent = 1,
    UnRegisterAll = 2,
    UnRegisterSkillTimeEvent = 20,
    PauseAllSkillTimeEvent = 3,
    ContinueAllSkillTimeEvent = 4,
    --sceneManager
    SceneMgrChangeScene = 21,
    SceneMgrChangeSceneFinish = 22,
    SceneMgrChangeObjectSkybox = 23,
    SceneMgrChangeObjectEffect = 24,
    SceneMgrChangeObjectEnvironment = 25,
    SceneMgrChangeObjectLight = 26,
    SceneMgrSetAllObject = 27,
    SceneMgrSetCameraFormation = 39,
    SceneMgrSetCameraBattleStart = 40,
    SceneMgrChangeObjectUltimateColor = 41,

    --cameraManager
    CameraMgrChangeCamera = 51,
    CameraMgrSetCamera = 60,

    --entityManager
    EntityMgrAddEntity = 61,
    EntityMgrRemoveEntity = 80,

    ---ScenicManager
    ScenicLoad = 90,
    ScenicUnLoad = 91,
    ScenicEnableModel = 92, --激活模型
    ScenicDisableModel = 93, --禁用模型

    --timerManager
    TimerMgrAddTimer = 101,
    TimerMgrBreakTimer = 110,

    --gameProgressManager
    GameProgressChange = 111,
    GameProgressNone = 120,

    --plot  剧情
    PlotShow = 121,
    PlotEndBename = 122,
    PlotPause = 123,
    PlotEnd = 130,

    --Dialog 回忆
    Dialog = 131,

    --Recruit 召唤
    Recruit = 135,
    RecruitShowNewHeroEnd = 136,
    RecruitNewHeroShow = 137,
    RecruitNewHeroHide = 138,
    RecruitDrawRefresh = 145,

    --AutoFight
    AutoFightStart = 151,
    AutoFightContinueFormation = 152,
    AutoFightContinueFight = 153,
    AutoFightResult = 154,
    AutoFightBreak = 160,

    ------ 任务系统 ------
    UpdateTaskAdd = 161, --任务添加或修改
    UpdateTaskDel = 162, --任务删除

    
    --时钟系统
    ChronosRefresh = 163,  --刷新时钟
    ChronosOpen = 164,  --开启时钟
    ChronosClose = 165, --关闭时钟

	----- 引导系统 ------
    GuideSystemTrigger = 170,
    GuideSystemUpdateContext = 171,
    GuideSystemBreak = 172,
    GuideSystemEnable = 173,
    GuideSystemGuideEnd = 174,
    GuideSystemBreakWeakGuide = 175,

    ----- 角色展示系统 ------
    ScenicSwitch = 180, --切换角色展示
    ScenicRelease = 181, --释放角色展示
    ScenicStageBackEnable = 182, --角色展示背景激活
    ScenicStageBackChanged = 183, --角色展示背景切换
    ScenicActorEnable = 184, --角色展示激活
    ScenicActorRootPosChanged = 185, --角色展示根节点位置改变
    ScenicActorPlayLvUpEffect = 186, --角色展示播放升级特效

    ----- 通用奖励提示相关 ------
    CommonRewardAddItemData = 190, --添加道具数据类型
    CommonRewardAddHeroData = 191, --添加英雄数据类型
    CommonRewardAddShowType = 192, --添加其他数据类型
    CommonRewardHeroSign = 193, --添加签到送全英雄延迟播放动画
    CommonRewardDiceAni = 194, --添加骰子延迟播放动画
    CommonRewardShowNext = 199, --通用奖励显示下一个数据

	----- 技能CutIn相关 ------
	SkillCutInStandby = 200, --技能切入动画待命
    SkillCutInPlay = 201, --播放技能切入动画


    --AudioSystem
    AudioSystemPlayMusic = 210,
    AudioSystemStopMusic = 211,

    ----------活动相关------------
    ActivityNoviceGift = 220,
    ActivitySevenSign = 221,
    ActivityHeroSign = 222,
    ActivityChampionships = 223,
    ActivityTopChampionships = 224,
    ActivityDailyLogin = 225,
    ActivityForestBlessing = 226,
    ActivityForestGift = 227,
    ActivityForestTreasury = 228,

    CloseUIUpHeroJigsawTips=229,--关闭 拼图选择界面
    ShowUIUpHeroJigsawBigReward=230,--拼图大奖界面
    RefreshUIUpHeroJigsawData=231,--拼图大奖后数据刷新
    RefreshUIUpHeroJigsawPanel=232,--拼图大奖后界面刷新

    ActivityDataEnd = 319,

    


    UpdateInventory = 320, --更新背包数据

    RechargeReqOrder = 330, --充值系统，请求订单
    RechargeSdkResult = 331, --充值系统，SDK支付结果
    RechargeReceiveServerMsg = 332, --充值系统，接收服务器订单消息
    RechargeResultUpdate = 333, --充值系统，得到结果后发送通知

    ---
    ActivityToShopMsg = 340, --活动系统消息，扣出数据告诉客户端

    PushGiftAddMsg = 350, -- 添加一个推送礼包ID
    PushGiftRefreshLimit = 351, -- 客户度自主推送上限
    PushNextShow = 352, -- 主界面推送下一个礼包

    PushGiftEnd = 369, --推送礼包相关 结束
   
    ---从370开始
    

}
