-- UI相关常量
UIConst = {}
--界面数据
--UIConst.UIMap = require("Core/UI/UIMap")
--UIConst.UIMap 转移到 DataTable.ResUIMap

--初始化状态对应UI
--UIConst.STATE_MAP = require("Core/UI/UIStateVisible")
--UIConst.STATE_MAP 意义不大 直接删除相关逻辑


--跑马灯每帧移动速度
UIConst.MoveSpeedPerFrame = 2

--文字停靠
UIConst.TXTALIGN_UL = UnityEngine.TextAnchor.UpperLeft
UIConst.TXTALIGN_UC = UnityEngine.TextAnchor.UpperCenter
UIConst.TXTALIGN_UR = UnityEngine.TextAnchor.UpperRight
UIConst.TXTALIGN_ML = UnityEngine.TextAnchor.MiddleLeft
UIConst.TXTALIGN_MC = UnityEngine.TextAnchor.MiddleCenter
UIConst.TXTALIGN_MR = UnityEngine.TextAnchor.MiddleRight
UIConst.TXTALIGN_LL = UnityEngine.TextAnchor.LowerLeft
UIConst.TXTALIGN_LC = UnityEngine.TextAnchor.LowerCenter
UIConst.TXTALIGN_LR = UnityEngine.TextAnchor.LowerRight

-- UI控件类型定义  在C#层的UITypeDef有转换定义
UIConst.ControlTypeText = 1
UIConst.ControlTypeButton = 2
UIConst.ControlTypeDropdown = 3
UIConst.ControlTypeImage = 4
UIConst.ControlTypeInputField = 5
UIConst.ControlTypeRawImage = 6
UIConst.ControlTypeScrollRect = 8
UIConst.ControlTypeSlider = 10
UIConst.ControlTypeToggle = 11
UIConst.ControlTypeLoopScrollRectHorizontal = 12
UIConst.ControlTypeLoopScrollRectVertical = 13

UIConst.ControlTypeUIAni = 18
UIConst.ControlTypeMsgMovePool = 19
UIConst.ControlTypeTextNumberJumper = 20
UIConst.ControlTypeGameObject = 23
UIConst.ControlTypeLazyEffectPlayer = 25
UIConst.ControlTypeToggleGroup = 40
UIConst.TextDotweenAgent = 43
UIConst.SliderDoTweenAgent = 44
UIConst.UICustomPolygon = 45
UIConst.JMoreRowScrollView = 46
UIConst.UIToggleGroup = 47
UIConst.JButton = 48
UIConst.JSwitchButton = 49
UIConst.UIGroupScrollView = 50


--无视界面不显示时不响应callback的逻辑的controltype
UIConst.EXECUTABLE_CONTROL_TYPE = {
    [UIConst.ControlTypeLoopScrollRectHorizontal] = true,
    [UIConst.ControlTypeLoopScrollRectVertical] = true,
    [UIConst.ControlTypeUIAni] = true,
    [UIConst.ControlTypeScrollRect] = true,
}

-- Emoji表情类型
UIConst.EMOJI_ICON = 1
UIConst.EMOJI_ANI = 2
UIConst.EMOJI_BTN = 3
UIConst.EMOJI_LINK = 4

-- EmojiID


UIConst.EMOJI_TYPE_LARGE = 2







local ResHeroCampCareerConfig = DataTable.ResHeroCampCareerConfig



-- Fly Icon Type
UIConst.FLY_ITEM_TYPE_EFFECT = 0
UIConst.FLY_ITEM_TYPE_ICON = 1

-- fly data mode
UIConst.FLY_MODE_UI_OBJ = 1 -- 使用uiobj
UIConst.FLY_MODE_ITEM = 2   -- 使用itemid和world pos
UIConst.FLY_MODE_3D = 3     -- 使用itemid和3D world pos

-- 道具图标初始路径
UIConst.ITEM_ICON_PATH = "" --"Atlas/CommonAtlas/IconAtlas/ItemBagAtlas/"

-- Grid图标初始路径
UIConst.ITEM_GRID_PATH = "Atlas/CommonAtlas/GridAtlas/"

-- 装备图标初始路径
UIConst.EQUIP_ICON_PATH = "Atlas/CommonAtlas/IconAtlas/"
UIConst.EQUIP_PART_MAX_NUM = 6
UIConst.EQUIP_PART_CONFIG = {
    [1] = { "头部配件", },
    [2] = { "上身配件", },
    [3] = { "下身配件", },
    [4] = { "其他配件", },
    [5] = { "手部配件", },
    [6] = { "足部配件", },
    [7] = { "随机部位配件", },
}

--装备套装表情
UIConst.EQUIP_SUIT_EMOJI = {
    [1] = "<0906>",
    [2] = "<0911>",
    [3] = "<0912>",
    [4] = "<0909>",
    [5] = "<0904>",
    [6] = "<1001>",
    [7] = "<0910>",
    [8] = "<0914>",
    [9] = "<0905>",
    [10] = "<0908>",
    [11] = "<0913>",
    [12] = "<0907>",
    [13] = "<0915>",
    [14] = "<1002>",
}

UIConst.HERO_EQUIP_ICON_PATH = "Atlas/HeroAtlas/HeroEquipAtlas"
UIConst.EQUIP_WEAR_UPGRADE_BG = {
    [Const.ITEM_QUALITY_WHITE] = { UIConst.HERO_EQUIP_ICON_PATH, "BgIconWhite" },
    [Const.ITEM_QUALITY_GREEN] = { UIConst.HERO_EQUIP_ICON_PATH, "BgIconGreen" },
    [Const.ITEM_QUALITY_BLUE] = { UIConst.HERO_EQUIP_ICON_PATH, "BgIconBlue" },
    [Const.ITEM_QUALITY_PURPLE] = { UIConst.HERO_EQUIP_ICON_PATH, "BgIconPurple" },
    [Const.ITEM_QUALITY_GOLD] = { UIConst.HERO_EQUIP_ICON_PATH, "BgIconGold" }
}

-- 通用图标初始路径
UIConst.COMMON_ICON_PATH = "Atlas/CommonAtlas/"

-- 品质图片的路径
UIConst.COMMON_QUALITY_CONFIG = {
    [Const.ITEM_QUALITY_WHITE] = { "Atlas/CommonAtlas/GridAtlas/GridAtlas", "BgIconWhite" },
    [Const.ITEM_QUALITY_GREEN] = { "Atlas/CommonAtlas/GridAtlas/GridAtlas", "BgIconGreen" },
    [Const.ITEM_QUALITY_BLUE] = { "Atlas/CommonAtlas/GridAtlas/GridAtlas", "BgIconBlue" },
    [Const.ITEM_QUALITY_PURPLE] = { "Atlas/CommonAtlas/GridAtlas/GridAtlas", "BgIconPurple" },
    [Const.ITEM_QUALITY_GOLD] = { "Atlas/CommonAtlas/GridAtlas/GridAtlas", "BgIconGold" },
    [Const.ITEM_QUALITY_PINK] = { "Atlas/CommonAtlas/GridAtlas/GridAtlas", "BgIconPink" },
    [Const.ITEM_QUALITY_RED] = { "Atlas/CommonAtlas/GridAtlas/GridAtlas", "BgIconRed" },
}

-- 英雄品质图片
UIConst.HERO_QUALITY_CONFIG = {
    [Const.ITEM_QUALITY_WHITE] = { "Atlas/HeroAtlas/HeroCardCommonAtlas", "TxtQuality01" },
    [Const.ITEM_QUALITY_GREEN] = { "Atlas/HeroAtlas/HeroCardCommonAtlas", "TxtQuality02" },
    [Const.ITEM_QUALITY_BLUE] = { "Atlas/HeroAtlas/HeroCardCommonAtlas", "TxtQuality03" },
    [Const.ITEM_QUALITY_PURPLE] = { "Atlas/HeroAtlas/HeroCardCommonAtlas", "TxtQuality04" },
    [Const.ITEM_QUALITY_GOLD] = { "Atlas/HeroAtlas/HeroCardCommonAtlas", "TxtQuality05" },
}

-- 英雄Logo用品质
UIConst.HERO_QUALITY_LOGO_CONFIG = {
    [Const.ITEM_QUALITY_WHITE] = { "Atlas/TeamSetAtlas/TeamSetAtlas", "BgWhite" },
    [Const.ITEM_QUALITY_GREEN] = { "Atlas/TeamSetAtlas/TeamSetAtlas", "BgGreen" },
    [Const.ITEM_QUALITY_BLUE] = { "Atlas/TeamSetAtlas/TeamSetAtlas", "BgBlue" },
    [Const.ITEM_QUALITY_PURPLE] = { "Atlas/TeamSetAtlas/TeamSetAtlas", "BgPurple" },
    [Const.ITEM_QUALITY_GOLD] = { "Atlas/TeamSetAtlas/TeamSetAtlas", "BgGold" },
}

--兼容新系统——图集
-- 英雄头像用品质
--UIConst.HERO_QUALITY_HEAD_CONFIG = {
--    [Const.ITEM_QUALITY_WHITE] = {"Atlas/CommonAtlas/GridAtlas/GridAtlas","BgIconGreen"},
--    [Const.ITEM_QUALITY_GREEN] = {"Atlas/CommonAtlas/GridAtlas/GridAtlas","BgIconBlue"},
--    [Const.ITEM_QUALITY_BLUE] = {"Atlas/CommonAtlas/GridAtlas/GridAtlas","BgIconPurple"},
--    [Const.ITEM_QUALITY_PURPLE] = {"Atlas/CommonAtlas/GridAtlas/GridAtlas","BgIconFuchsia"},
--    [Const.ITEM_QUALITY_GOLD] = {"Atlas/CommonAtlas/GridAtlas/GridAtlas","BgIconGold"},
--    [Const.ITEM_QUALITY_PINK] = {"Atlas/CommonAtlas/GridAtlas/GridAtlas","BgIconPink"},
--    [Const.ITEM_QUALITY_RED] = {"Atlas/CommonAtlas/GridAtlas/GridAtlas","BgIconRed"},
--    -- [8] = {"Atlas/CommonAtlas/GridAtlas/GridAtlas","BgIconGold04"},
--    -- [9] = {"Atlas/CommonAtlas/GridAtlas/GridAtlas","BgIconGold05"},
--    -- [10] = {"Atlas/CommonAtlas/GridAtlas/GridAtlas","BgIconGold06"},
--}
UIConst.HERO_QUALITY_HEAD_CONFIG = {
    [Const.ITEM_QUALITY_WHITE] = { "atlas_heroinfo", "herodetails_herohead_green" },
    [Const.ITEM_QUALITY_GREEN] = { "atlas_heroinfo", "herodetails_herohead_blue" },
    [Const.ITEM_QUALITY_BLUE] = { "atlas_heroinfo", "herodetails_herohead_purple" },
    [Const.ITEM_QUALITY_PURPLE] = { "atlas_heroinfo", "herodetails_herohead_purplegold" },
    [Const.ITEM_QUALITY_GOLD] = { "atlas_heroinfo", "herodetails_herohead_gold" },
    [Const.ITEM_QUALITY_PINK] = { "atlas_heroinfo", "herodetails_herohead_powder" },
    [Const.ITEM_QUALITY_RED] = { "atlas_heroinfo", "herodetails_herohead_orange" },
    -- [8] = {"Atlas/CommonAtlas/GridAtlas/GridAtlas","BgIconGold04"},
    -- [9] = {"Atlas/CommonAtlas/GridAtlas/GridAtlas","BgIconGold05"},
    -- [10] = {"Atlas/CommonAtlas/GridAtlas/GridAtlas","BgIconGold06"},
}

-- 商品品质路径
UIConst.SHOP_QUALITY_CONFIG = {
    [Const.ITEM_QUALITY_WHITE] = { "Atlas/StoreAtlas/StoreAtlas", "BgGoodsWhite" },
    [Const.ITEM_QUALITY_GREEN] = { "Atlas/StoreAtlas/StoreAtlas", "BgGoodsGreen" },
    [Const.ITEM_QUALITY_BLUE] = { "Atlas/StoreAtlas/StoreAtlas", "BgGoodsBlue" },
    [Const.ITEM_QUALITY_PURPLE] = { "Atlas/StoreAtlas/StoreAtlas", "BgGoodsPurple" },
    [Const.ITEM_QUALITY_GOLD] = { "Atlas/StoreAtlas/StoreAtlas", "BgGoodsGold" },
    [Const.ITEM_QUALITY_PINK] = { "Atlas/StoreAtlas/StoreAtlas", "BgGoodsPink" },
    [Const.ITEM_QUALITY_RED] = { "Atlas/StoreAtlas/StoreAtlas02", "BgGoodsRed" },
    [Const.ITEM_QUALITY_UNKNOWN] = { "Atlas/StoreAtlas/StoreAtlas", "BgGoodsDis" },
}

-- 后宅商品品质路径
UIConst.REARHOUSE_SHOP_QUALITY_CONFIG = {
    [Const.ITEM_QUALITY_WHITE] = { "Atlas/BackyardAtlas/BackyardStoreAtlas", "BgGoodsWhite" },
    [Const.ITEM_QUALITY_GREEN] = { "Atlas/BackyardAtlas/BackyardStoreAtlas", "BgGoodsGreen" },
    [Const.ITEM_QUALITY_BLUE] = { "Atlas/BackyardAtlas/BackyardStoreAtlas", "BgGoodsBlue" },
    [Const.ITEM_QUALITY_PURPLE] = { "Atlas/BackyardAtlas/BackyardStoreAtlas", "BgGoodsPurple" },
    [Const.ITEM_QUALITY_GOLD] = { "Atlas/BackyardAtlas/BackyardStoreAtlas", "BgGoodsGold" },
    [Const.ITEM_QUALITY_PINK] = { "Atlas/BackyardAtlas/BackyardStoreAtlas", "BgGoodsPink" },
    [Const.ITEM_QUALITY_RED] = { "Atlas/BackyardAtlas/BackyardStoreAtlas", "BgGoodsRed" },
    [Const.ITEM_QUALITY_UNKNOWN] = { "Atlas/BackyardAtlas/BackyardStoreAtlas", "BgGoodsDis" },
}

-- 圣物用品质路径
UIConst.RELIC_QUALITY_CONFIG = {
    [Const.ITEM_QUALITY_WHITE] = { "Atlas/CommonAtlas/GridAtlas/GridRelicAtlas", "BgRelicPurple" },
    [Const.ITEM_QUALITY_GREEN] = { "Atlas/CommonAtlas/GridAtlas/GridRelicAtlas", "BgRelicPurple" },
    [Const.ITEM_QUALITY_BLUE] = { "Atlas/CommonAtlas/GridAtlas/GridRelicAtlas", "BgRelicBlue" },
    [Const.ITEM_QUALITY_PURPLE] = { "Atlas/CommonAtlas/GridAtlas/GridRelicAtlas", "BgRelicPurple" },
    [Const.ITEM_QUALITY_GOLD] = { "Atlas/CommonAtlas/GridAtlas/GridRelicAtlas", "BgRelicYellow" },
    [Const.ITEM_QUALITY_PINK] = { "Atlas/CommonAtlas/GridAtlas/GridRelicAtlas", "BgRelicPurple" },
    [Const.ITEM_QUALITY_RED] = { "Atlas/CommonAtlas/GridAtlas/GridRelicAtlas", "BgRelicPurple" },
}

UIConst.RELIC_PANEL_QUALITY_CONFIG = {
    [Const.ITEM_QUALITY_WHITE] = { "Atlas/HeroAtlas/HeroEquipAtlas", "BgSacred02" },
    [Const.ITEM_QUALITY_GREEN] = { "Atlas/HeroAtlas/HeroEquipAtlas", "BgSacred02" },
    [Const.ITEM_QUALITY_BLUE] = { "Atlas/HeroAtlas/HeroEquipAtlas", "BgSacred03" },
    [Const.ITEM_QUALITY_PURPLE] = { "Atlas/HeroAtlas/HeroEquipAtlas", "BgSacred02" },
    [Const.ITEM_QUALITY_GOLD] = { "Atlas/HeroAtlas/HeroEquipAtlas", "BgSacred01" },
    [Const.ITEM_QUALITY_PINK] = { "Atlas/HeroAtlas/HeroEquipAtlas", "BgSacred02" },
    [Const.ITEM_QUALITY_RED] = { "Atlas/HeroAtlas/HeroEquipAtlas", "BgSacred02" },
}

UIConst.RELIC_BG_QUALITY_CONFIG = {
    [Const.ITEM_QUALITY_WHITE] = { "Atlas/HeroAtlas/HeroEquipAtlas", "BgSacredViolet" },
    [Const.ITEM_QUALITY_GREEN] = { "Atlas/HeroAtlas/HeroEquipAtlas", "BgSacredViolet" },
    [Const.ITEM_QUALITY_BLUE] = { "Atlas/HeroAtlas/HeroEquipAtlas", "BgSacredBlue" },
    [Const.ITEM_QUALITY_PURPLE] = { "Atlas/HeroAtlas/HeroEquipAtlas", "BgSacredViolet" },
    [Const.ITEM_QUALITY_GOLD] = { "Atlas/HeroAtlas/HeroEquipAtlas", "BgSacredGolden" },
    [Const.ITEM_QUALITY_PINK] = { "Atlas/HeroAtlas/HeroEquipAtlas", "BgSacredViolet" },
    [Const.ITEM_QUALITY_RED] = { "Atlas/HeroAtlas/HeroEquipAtlas", "BgSacredViolet" },
}

UIConst.RELIC_SPEICAL_SIGN_PATH = {
    [Const.RELIC_SPEICAL_SIGN_FULI] = { "Atlas/StoreAtlas/StoreRelicAtlas", "TxtBgFuli" },
    [Const.RELIC_SPEICAL_SIGN_SPRING] = { "Atlas/StoreAtlas/StoreRelicAtlas", "TxtBgSeasonSpring" },
    [Const.RELIC_SPEICAL_SIGN_SUMMER] = { "Atlas/StoreAtlas/StoreRelicAtlas", "TxtBgSeasonSummer" },
    [Const.RELIC_SPEICAL_SIGN_AUTUMN] = { "Atlas/StoreAtlas/StoreRelicAtlas", "TxtBgSeasonAutumn" },
    [Const.RELIC_SPEICAL_SIGN_WINTER] = { "Atlas/StoreAtlas/StoreRelicAtlas", "TxtBgSeasonWinter" },
}

--皮肤品质路径
UIConst.SKIN_QUALITY_ICON_PATH = "Atlas/HeroAtlas/HeroSkinCardAtlas"
UIConst.SKIN_QUALITY_BG_PATH = "Atlas/ActivityAtlas/ActivityNewSkinPreviewAtlas/ActivityNewSkinPreviewAtlas"
UIConst.SKIN_QUALITY_ICON = {
    [1] = { "TxtAdvanced", "BgCell5" },   --高级
    [2] = { "TxtTreasure", "BgCell3" },   --珍品
    [3] = { "TxtLimited", "BgCell1" },    --限定
    [4] = { "TxtCollector", "BgCell2" },  --大收藏家
    [5] = { "TxtHalloween", "BgCell4" },  --万圣节
    [6] = { "TxtSouvenir", "BgCell4" },   --纪念
    [7] = { "TxtSummerSwim", "BgCell1" }, --夏日限定
}

-- 货币相关的额配置
local ResItem = DataTable.ResItem
local moneyAtlasPath = UIConst.ITEM_ICON_PATH .. "CurrencyAtlas"
local moneyAtlasPath2 = UIConst.ITEM_ICON_PATH .. "CurrencyAtlas2"
local moneyAtlasPath3 = UIConst.ITEM_ICON_PATH .. "CurrencyAtlas3"

UIConst.RD_HINT_FUNCENTRY_DIAMOND = 201 --货币栏钻石红点
--[[
UIConst.MONEY_ID2INFO = {
    [Const.MONEY_ID_GOLD] = {moneyAtlasPath, "IconGold", ResItem[Const.MONEY_ID_GOLD].name or "", 172},
    [Const.MONEY_ID_DIAMOND] = {moneyAtlasPath, "IconDiamond", ResItem[Const.MONEY_ID_DIAMOND].name or "", },
    [Const.MONEY_ID_POWER] = {moneyAtlasPath, "IconCapacity", ResItem[Const.MONEY_ID_POWER].name or ""},
    [Const.MONEY_ID_PVP] = {moneyAtlasPath, "IconPVP", ResItem[Const.MONEY_ID_PVP].name or "", 173},
    --[Const.MONEY_ID_MAZE] = {moneyAtlasPath, "IconMaze", ResItem[Const.MONEY_ID_MAZE].name or "", 175},
    [Const.MONEY_ID_PVP_TICKET] = {moneyAtlasPath, "IconPVPTicket", ResItem[Const.MONEY_ID_PVP_TICKET].name or ""},
    [Const.MONEY_ID_FRIEND_GIFT] = {moneyAtlasPath, "IconFriend", ResItem[Const.MONEY_ID_FRIEND_GIFT].name or "", 174},
    [Const.MONEY_ID_FURNITURE] = {moneyAtlasPath2, "IconFurniture", ResItem[Const.MONEY_ID_FURNITURE].name or "", 176},
    [Const.MONEY_ID_REAR_HOUSE_COIN] = {moneyAtlasPath, "IconBackyard", ResItem[Const.MONEY_ID_REAR_HOUSE_COIN].name or ""},

    --[Const.MONEY_ID_DRAW_BY_GOLD] = {moneyAtlasPath, "IconDrawHero1", ResItem[Const.MONEY_ID_DRAW_BY_GOLD].name or ""},
    [Const.MONEY_ID_DRAW_BY_DIAMOND] = {moneyAtlasPath, "IconDrawHero2", ResItem[Const.MONEY_ID_DRAW_BY_DIAMOND].name or ""},
    [Const.MONEY_ID_HERO_EXP] = {moneyAtlasPath, "IconHeroExp", ResItem[Const.MONEY_ID_HERO_EXP].name or ""},
    [Const.MONEY_ID_VIP_POINT] = {moneyAtlasPath2, "IconVIPPoint", ResItem[Const.MONEY_ID_VIP_POINT].name or ""},
    [Const.MONEY_ID_BP] = {moneyAtlasPath2, "IconBPPoint", ResItem[Const.MONEY_ID_BP].name or ""},
    [Const.MONEY_ID_STAGE_ENERGY] = {moneyAtlasPath2, "IconMainBattle", ResItem[Const.MONEY_ID_STAGE_ENERGY].name or ""},
    [Const.MONEY_ID_CIRCLE_COIN] = {moneyAtlasPath2, "IconCircleCoin", ResItem[Const.MONEY_ID_CIRCLE_COIN].name or ""},
    [Const.MONEY_ID_GOLD_LEAF] = {moneyAtlasPath2, "IconGoldenLeaf", ResItem[Const.MONEY_ID_GOLD_LEAF].name or ""},
    [Const.MONEY_ID_ARTIFACT_COIN] = {moneyAtlasPath2, "IconMaze2", ResItem[Const.MONEY_ID_ARTIFACT_COIN].name or ""},
    [Const.MONEY_ID_HIGH_FURNITURE] = {moneyAtlasPath2, "IconFurniture2", ResItem[Const.MONEY_ID_HIGH_FURNITURE].name or ""},
    [Const.MONEY_ID_REFUND_COIN] = {moneyAtlasPath3, "IconRebate", ResItem[Const.MONEY_ID_REFUND_COIN].name or ""},
    [Const.MONEY_ID_SKIN_COIN] = {moneyAtlasPath3, "IconSkin", ResItem[Const.MONEY_ID_SKIN_COIN].name or "", 287},
}
]]

local HERO_COMMON_ATLAS_PATH = "Atlas/HeroAtlas/HeroCardCommonAtlas"
local HERO_COMMON_ATLAS_PATH2 = "atlas_heroinfo"
--英雄卡牌阶数对应图片资源
UIConst.HERO_CARD_SPRITE_BY_STEP = {
    [1] = {
        IMG_BAR1 = { "atlas_herocard", "green_card" },
        IMG_BG1 = { HERO_COMMON_ATLAS_PATH, "ImgCardBgNml" },
        BG_STAR = { HERO_COMMON_ATLAS_PATH, "ImgCardGreenLv" },
        BG_HEAD = { HERO_COMMON_ATLAS_PATH .. "01", "BgHeadGreen" },
        IMG_STAR = { "Atlas/HeroStarUpAtlas/HeroStarUpAtlas7", "ImgGreenStar" },
        IMG_STAR_L = { "Atlas/HeroStarUpAtlas/HeroStarUpAtlas7", "ImgGreenL" },
        IMG_STAR_R = { "Atlas/HeroStarUpAtlas/HeroStarUpAtlas7", "ImgGreenR" },
        IMG_TRIANGLE = { "Atlas/HeroStarUpAtlas/HeroStarUpAtlas7", "ImgGreenR" },
        TEXT_STAR = { "Atlas/HeroStarUpAtlas/HeroStarUpAtlas7", "TextStarGreen" },
    },
    [2] = {
        IMG_BAR1 = { "atlas_herocard", "blue_card" },
        IMG_BG1 = { HERO_COMMON_ATLAS_PATH, "ImgCardBgNml" },
        BG_STAR = { HERO_COMMON_ATLAS_PATH, "ImgCardBlueLv" },
        BG_HEAD = { HERO_COMMON_ATLAS_PATH .. "01", "BgHeadBlue" },
        IMG_STAR = { "Atlas/HeroStarUpAtlas/HeroStarUpAtlas7", "ImgBlueStar" },
        IMG_STAR_L = { "Atlas/HeroStarUpAtlas/HeroStarUpAtlas7", "ImgBlueL" },
        IMG_STAR_R = { "Atlas/HeroStarUpAtlas/HeroStarUpAtlas7", "ImgBlueR" },
        IMG_TRIANGLE = { "Atlas/HeroStarUpAtlas/HeroStarUpAtlas7", "ImgBlueR" },
        TEXT_STAR = { "Atlas/HeroStarUpAtlas/HeroStarUpAtlas7", "TextStarBlue" },
    },
    [3] = {
        IMG_BAR1 = { "atlas_herocard", "purple_card" },
        IMG_BG1 = { HERO_COMMON_ATLAS_PATH, "ImgCardBgNml" },
        BG_STAR = { HERO_COMMON_ATLAS_PATH, "ImgCardPurpleLv" },
        BG_HEAD = { HERO_COMMON_ATLAS_PATH .. "01", "BgHeadPurple" },
        IMG_STAR = { "Atlas/HeroStarUpAtlas/HeroStarUpAtlas3", "ImgPurpleStar" },
        IMG_STAR_L = { "Atlas/HeroStarUpAtlas/HeroStarUpAtlas3", "ImgPurpleL" },
        IMG_STAR_R = { "Atlas/HeroStarUpAtlas/HeroStarUpAtlas3", "ImgPurpleR" },
        IMG_TRIANGLE = { "Atlas/HeroStarUpAtlas/HeroStarUpAtlas3", "ImgTrianglePurple" },
        TEXT_STAR = { "Atlas/HeroStarUpAtlas/HeroStarUpAtlas3", "TextStarPurple" },
    },
    [4] = {
        IMG_BAR1 = { "atlas_herocard", "purplegold_card" },
        IMG_BG1 = { HERO_COMMON_ATLAS_PATH, "ImgCardBgNml" },
        BG_STAR = { HERO_COMMON_ATLAS_PATH, "ImgCardFuchsiaLv" },
        BG_HEAD = { HERO_COMMON_ATLAS_PATH .. "01", "BgHeadFuchsia" },
        IMG_STAR = { "Atlas/HeroStarUpAtlas/HeroStarUpAtlas3", "ImgFuchsiaStar" },
        IMG_STAR_L = { "Atlas/HeroStarUpAtlas/HeroStarUpAtlas3", "ImgFuchsiaL" },
        IMG_STAR_R = { "Atlas/HeroStarUpAtlas/HeroStarUpAtlas3", "ImgFuchsiaR" },
        IMG_TRIANGLE = { "Atlas/HeroStarUpAtlas/HeroStarUpAtlas3", "ImgTriangleFuchsia" },
        TEXT_STAR = { "Atlas/HeroStarUpAtlas/HeroStarUpAtlas3", "TextStarFuchsia" },
    },
    [5] = {
        IMG_BAR1 = { "atlas_herocard", "gold_card" },
        IMG_BG1 = { HERO_COMMON_ATLAS_PATH, "ImgCardBgNml" },
        BG_STAR = { HERO_COMMON_ATLAS_PATH, "ImgCardGoldLv" },
        BG_HEAD = { HERO_COMMON_ATLAS_PATH .. "01", "BgHeadGold" },
        IMG_STAR = { "Atlas/HeroStarUpAtlas/HeroStarUpAtlas5", "ImgYellowStar" },
        IMG_STAR_L = { "Atlas/HeroStarUpAtlas/HeroStarUpAtlas5", "ImgYellowL" },
        IMG_STAR_R = { "Atlas/HeroStarUpAtlas/HeroStarUpAtlas5", "ImgYellowR" },
        IMG_TRIANGLE = { "Atlas/HeroStarUpAtlas/HeroStarUpAtlas5", "ImgTriangleYellow" },
        TEXT_STAR = { "Atlas/HeroStarUpAtlas/HeroStarUpAtlas5", "TextStarYellow" },
    },
    [6] = {
        IMG_BAR1 = { "atlas_herocard", "powder_card" },
        IMG_BG1 = { HERO_COMMON_ATLAS_PATH, "ImgCardBgNml" },
        BG_STAR = { HERO_COMMON_ATLAS_PATH, "ImgCardPinkLv" },
        BG_HEAD = { HERO_COMMON_ATLAS_PATH .. "01", "BgHeadPink" },
        IMG_STAR = { "Atlas/HeroStarUpAtlas/HeroStarUpAtlas4", "ImgPinkStar" },
        IMG_STAR_L = { "Atlas/HeroStarUpAtlas/HeroStarUpAtlas4", "ImgPinkL" },
        IMG_STAR_R = { "Atlas/HeroStarUpAtlas/HeroStarUpAtlas4", "ImgPinkR" },
        IMG_TRIANGLE = { "Atlas/HeroStarUpAtlas/HeroStarUpAtlas4", "ImgTrianglePink" },
        TEXT_STAR = { "Atlas/HeroStarUpAtlas/HeroStarUpAtlas4", "TextStarPink" },
    },
    [7] = {
        IMG_BAR1 = { "atlas_herocard", "orange_card" },
        IMG_BG1 = { HERO_COMMON_ATLAS_PATH, "ImgCardBgNml" },
        BG_STAR = { HERO_COMMON_ATLAS_PATH, "ImgCardRedLv" },
        BG_HEAD = { HERO_COMMON_ATLAS_PATH .. "01", "BgHeadRed" },
        IMG_STAR = { "Atlas/HeroStarUpAtlas/HeroStarUpAtlas4", "ImgRedStar" },
        IMG_STAR_L = { "Atlas/HeroStarUpAtlas/HeroStarUpAtlas4", "ImgRedL" },
        IMG_STAR_R = { "Atlas/HeroStarUpAtlas/HeroStarUpAtlas4", "ImgRedR" },
        IMG_TRIANGLE = { "Atlas/HeroStarUpAtlas/HeroStarUpAtlas4", "ImgTriangleRed" },
        TEXT_STAR = { "Atlas/HeroStarUpAtlas/HeroStarUpAtlas4", "TextStarRed" },
    },
    [8] = {
        IMG_BAR1 = { HERO_COMMON_ATLAS_PATH, "ImgCardGold03" },
        IMG_BG1 = { HERO_COMMON_ATLAS_PATH, "ImgCardBgNml" },
        BG_STAR = { HERO_COMMON_ATLAS_PATH, "ImgCardGoldLv03" },
        BG_HEAD = { HERO_COMMON_ATLAS_PATH .. "01", "BgHeadGold03" },
    },
    [9] = {
        IMG_BAR1 = { HERO_COMMON_ATLAS_PATH, "ImgCardGold04" },
        IMG_BG1 = { HERO_COMMON_ATLAS_PATH, "ImgCardBgNml" },
        BG_STAR = { HERO_COMMON_ATLAS_PATH, "ImgCardGoldLv04" },
        BG_HEAD = { HERO_COMMON_ATLAS_PATH .. "01", "BgHeadGold04" },
    },
    [10] = {
        IMG_BAR1 = { HERO_COMMON_ATLAS_PATH, "ImgCardGold05" },
        IMG_BG1 = { HERO_COMMON_ATLAS_PATH, "ImgCardBgNml" },
        BG_STAR = { HERO_COMMON_ATLAS_PATH, "ImgCardGoldLv05" },
        BG_HEAD = { HERO_COMMON_ATLAS_PATH .. "01", "BgHeadGold05" },
    },
}

UIConst.HERO_PROP_RANK_ICON = {
    [1] = { HERO_COMMON_ATLAS_PATH2, "evaluate_d" },
    [2] = { HERO_COMMON_ATLAS_PATH2, "evaluate_c" },
    [3] = { HERO_COMMON_ATLAS_PATH2, "evaluate_b" },
    [4] = { HERO_COMMON_ATLAS_PATH2, "evaluate_a" },
    [5] = { HERO_COMMON_ATLAS_PATH2, "evaluate_s" }
}

UIConst.HERO_STEPUP_DES_SHOW_TPYE = {}
UIConst.HERO_STEPUP_DES_SHOW_TPYE.SKILL = 1
UIConst.HERO_STEPUP_DES_SHOW_TPYE.TIMETEXT = 2
UIConst.HERO_STEPUP_DES_SHOW_TPYE.DESTEXT = 3
UIConst.HERO_STEPUP_DES_SHOW_TPYE.CHARACTERTEXT = 4
UIConst.HERO_STEPUP_DES_SHOW_TPYE.IMAGE = 5



-- 兼容新系统——图集
---- 阵营加强的图标配置
--UIConst.CAMP_ENHANCE_BTN_IMG = {
--    [0] = {"Atlas/BattleAtlas/BattleBrandAtlas", "IconBrandS0"},
--    [3] = {"Atlas/BattleAtlas/BattleBrandAtlas", "IconBrandS1"},
--    [4] = {"Atlas/BattleAtlas/BattleBrandAtlas", "IconBrandS2"},
--    [5] = {"Atlas/BattleAtlas/BattleBrandAtlas", "IconBrandS3"},
--}
UIConst.CAMP_ENHANCE_BTN_IMG = {
    [0] = { "atlas_battle", "prepare_camp0" },
    [3] = { "atlas_battle", "prepare_camp1" },
    [4] = { "atlas_battle", "prepare_camp2" },
    [5] = { "atlas_battle", "prepare_camp3" },
}


-- 兼容新系统——图集
--UIConst.CAMP_ENHANCE_BTN_IMG_BIG = {
--    [0] = {"Atlas/BattleAtlas/BattleBrandAtlas", "IconBrand0"},
--    [3] = {"Atlas/BattleAtlas/BattleBrandAtlas", "IconBrand1"},
--    [4] = {"Atlas/BattleAtlas/BattleBrandAtlas", "IconBrand2"},
--    [5] = {"Atlas/BattleAtlas/BattleBrandAtlas", "IconBrand3"},
--}
UIConst.CAMP_ENHANCE_BTN_IMG_BIG = {
    [0] = { "atlas_battle", "prepare_camp0" },
    [3] = { "atlas_battle", "prepare_camp1" },
    [4] = { "atlas_battle", "prepare_camp2" },
    [5] = { "atlas_battle", "prepare_camp3" },
}

UIConst.BATTLE_HEAD_BG = {
    [1] = "battlecard_background01",
    [2] = "battlecard_background02",
    [3] = "battlecard_background03",
    [4] = "battlecard_background03",
    [5] = "battlecard_background05",
    [6] = "battlecard_background05",
    [7] = "battlecard_background07",
    [8] = "battlecard_background07",
    [9] = "battlecard_background09",
    [10] = "battlecard_background09",
    [11] = "battlecard_background11",
    [12] = "battlecard_background11",
    [13] = "battlecard_background11",
    [14] = "battlecard_background11",
    [15] = "battlecard_background11",
    [16] = "battlecard_background11",
}


UIConst.BATTLE_HEAD_BACKGROUND = {
    [1] = "battlecard_n_iconstartl01",
    [2] = "battlecard_n_iconstartl02",
    [3] = "battlecard_n_iconstartl03",
    [4] = "battlecard_n_iconstartl04",
    [5] = "battlecard_n_iconstartl05",
    [6] = "battlecard_n_iconstartl06",
    [7] = "battlecard_n_iconstartl07",
    [8] = "battlecard_n_iconstartl08",
    [9] = "battlecard_n_iconstartl09",
    [10] = "battlecard_n_iconstartl10",
    [11] = "battlecard_n_iconstartl11",
    [12] = "battlecard_n_iconstartl11",
    [13] = "battlecard_n_iconstartl11",
    [14] = "battlecard_n_iconstartl11",
    [15] = "battlecard_n_iconstartl11",
    [16] = "battlecard_n_iconstartl11",
}


--星级对应的emojitext
UIConst.HERO_STAR_EMOJI_DIC = {
    [1] = "<0301>",
    [2] = "<0302>",
    [3] = "<0303>",
    [4] = "<0304>",
    [5] = "<0305>",
    [6] = "<0306>",
    [7] = "<0306><0306>",
    [8] = "<0306><0306><0306>",
    [9] = "<0306><0306><0306><0306>",
    [10] = "<0306><0306><0306><0306><0306>",
    [11] = "<0307>",
    [12] = "<0307><0307>",
    [13] = "<0307><0307><0307>",
    [14] = "<0307><0307><0307><0307>",
    [15] = "<0307><0307><0307><0307><0307>",
}

--神器职业对应背景图
UIConst.ARTIFACT_CAREER_BG = {
    [HeroConst.CAREER_TYPE.ALL] = {
        [1] = { "Atlas/CommonAtlas/GridAtlas/BgBadgeAtlas", "BgBadge01" },
        [2] = { "Atlas/CommonAtlas/GridAtlas/BgBadgeAtlas", "BgBadge02" },
        [3] = { "Atlas/CommonAtlas/GridAtlas/BgBadgeAtlas", "BgBadge03" },
        [4] = { "Atlas/CommonAtlas/GridAtlas/BgBadgeAtlas", "BgBadge04" },
        [5] = { "Atlas/CommonAtlas/GridAtlas/BgBadgeAtlas", "BgBadge05" },
        [6] = { "Atlas/CommonAtlas/GridAtlas/BgBadgeAtlas", "BgBadge06" },
    },
    [HeroConst.CAREER_TYPE.TANK] = {
        [3] = { "Atlas/CommonAtlas/GridAtlas/BgBadgeAtlas1", "BgBadge13" },
        [4] = { "Atlas/CommonAtlas/GridAtlas/BgBadgeAtlas1", "BgBadge14" },
        [5] = { "Atlas/CommonAtlas/GridAtlas/BgBadgeAtlas1", "BgBadge15" },
        [6] = { "Atlas/CommonAtlas/GridAtlas/BgBadgeAtlas", "BgBadge16" },
    },
    [HeroConst.CAREER_TYPE.WORRIOR] = {
        [3] = { "Atlas/CommonAtlas/GridAtlas/BgBadgeAtlas1", "BgBadge23" },
        [4] = { "Atlas/CommonAtlas/GridAtlas/BgBadgeAtlas1", "BgBadge24" },
        [5] = { "Atlas/CommonAtlas/GridAtlas/BgBadgeAtlas1", "BgBadge25" },
        [6] = { "Atlas/CommonAtlas/GridAtlas/BgBadgeAtlas", "BgBadge26" },
    },
    [HeroConst.CAREER_TYPE.HUNTER] = {
        [3] = { "Atlas/CommonAtlas/GridAtlas/BgBadgeAtlas1", "BgBadge33" },
        [4] = { "Atlas/CommonAtlas/GridAtlas/BgBadgeAtlas1", "BgBadge34" },
        [5] = { "Atlas/CommonAtlas/GridAtlas/BgBadgeAtlas1", "BgBadge35" },
        [6] = { "Atlas/CommonAtlas/GridAtlas/BgBadgeAtlas", "BgBadge36" },
    },
    [HeroConst.CAREER_TYPE.POET] = {
        [3] = { "Atlas/CommonAtlas/GridAtlas/BgBadgeAtlas2", "BgBadge43" },
        [4] = { "Atlas/CommonAtlas/GridAtlas/BgBadgeAtlas2", "BgBadge44" },
        [5] = { "Atlas/CommonAtlas/GridAtlas/BgBadgeAtlas2", "BgBadge45" },
        [6] = { "Atlas/CommonAtlas/GridAtlas/BgBadgeAtlas2", "BgBadge46" },
    },
    [HeroConst.CAREER_TYPE.SUPPORT] = {
        [3] = { "Atlas/CommonAtlas/GridAtlas/BgBadgeAtlas2", "BgBadge53" },
        [4] = { "Atlas/CommonAtlas/GridAtlas/BgBadgeAtlas2", "BgBadge54" },
        [5] = { "Atlas/CommonAtlas/GridAtlas/BgBadgeAtlas2", "BgBadge55" },
        [6] = { "Atlas/CommonAtlas/GridAtlas/BgBadgeAtlas2", "BgBadge56" },
    },
}

UIConst.ARTIFACT_QUALITY_PATH = {
    [1] = { "atlas_public", "propbox_1" },
    [2] = { "atlas_public", "propbox_2" },
    [3] = { "atlas_public", "propbox_3" },
    [4] = { "atlas_public", "propbox_4" },
    [5] = { "atlas_public", "propbox_5" },
    [6] = { "atlas_public", "propbox_6" },
    [7] = { "atlas_public", "propbox_7" },
}






UIConst.ARTIFACT_STAR_BG_PATH = {
    [2] = { "Atlas/CommonAtlas/GridAtlas/GridBadgeAtlas", "BadgeStarBg2" },
    [3] = { "Atlas/CommonAtlas/GridAtlas/GridBadgeAtlas", "BadgeStarBg3" },
    [4] = { "Atlas/CommonAtlas/GridAtlas/GridBadgeAtlas3", "BadgeStarBg4" },
    [6] = { "Atlas/CommonAtlas/GridAtlas/GridBadgeAtlas3", "BadgeStarBg6" }
}

-- 品质图片的路径
UIConst.EQUIP_QUALITY_CONFIG = {
    [1] = { "atlas_public", "propbox_1" },
    [2] = { "atlas_public", "propbox_2" },
    [3] = { "atlas_public", "propbox_3" },
    [4] = { "atlas_public", "propbox_4" },
    [5] = { "atlas_public", "propbox_5" },
    [6] = { "atlas_public", "propbox_6" },
    [7] = { "atlas_public", "propbox_7" },
    [8] = { "atlas_public", "propbox_8" },
    [9] = { "atlas_public", "propbox_9" },
    [10] = { "atlas_public", "propbox_10" },
    [11] = { "atlas_public", "propbox_11" },
    [12] = { "atlas_public", "propbox_12" },
    [13] = { "atlas_public", "propbox_13" },
}
UIConst.DRAGON_QUALITY_CONFIG = {
    [1] = { "atlas_star", "promote_iconstart16" },
    [2] = { "atlas_star", "promote_iconstart17" },
    [3] = { "atlas_star", "promote_iconstart18" },
    [4] = { "atlas_star", "promote_iconstart19" },
    [5] = { "atlas_star", "promote_iconstart20" },
    [6] = { "atlas_star", "promote_iconstart21" },
    [7] = { "atlas_star", "promote_iconstart22" },
    [8] = { "atlas_star", "promote_iconstart23" },
    [9] = { "atlas_star", "promote_iconstart23" },
    [10] = { "atlas_star", "promote_iconstart23" },
    [11] = { "atlas_star", "promote_iconstart23" },
    [12] = { "atlas_star", "promote_iconstart23" },
    [13] = { "atlas_star", "promote_iconstart23" },
}
UIConst.DRAGON_STAR_COLOR = {
    [1] = { "atlas_hero_head_new", "herodetails_herohead_1" },
    [2] = { "atlas_hero_head_new", "herodetails_herohead_2" },
    [3] = { "atlas_hero_head_new", "herodetails_herohead_3" },
    [4] = { "atlas_hero_head_new", "herodetails_herohead_4" },
    [5] = { "atlas_hero_head_new", "herodetails_herohead_5" },
    [6] = { "atlas_hero_head_new", "herodetails_herohead_6" },
    [7] = { "atlas_hero_head_new", "herodetails_herohead_7" },
    [8] = { "atlas_hero_head_new", "herodetails_herohead_8" },
    [9] = { "atlas_hero_head_new", "herodetails_herohead_9" },
    [10] = { "atlas_hero_head_new", "herodetails_herohead_10" },
    [11] = { "atlas_hero_head_new", "herodetails_herohead_11" },
    [12] = { "atlas_hero_head_new", "herodetails_herohead_11" },
    [13] = { "atlas_hero_head_new", "herodetails_herohead_11" },
    [14] = { "atlas_hero_head_new", "herodetails_herohead_11" },
    [15] = { "atlas_hero_head_new", "herodetails_herohead_11" },
    [16] = { "atlas_hero_head_new", "herodetails_herohead_11" },
}
UIConst.STARCOLOR = {
    [1] = { "atlas_hero_head_new", "herodetails_herohead_1" },
    [2] = { "atlas_hero_head_new", "herodetails_herohead_2" },
    [3] = { "atlas_hero_head_new", "herodetails_herohead_3" },
    [4] = { "atlas_hero_head_new", "herodetails_herohead_4" },
    [5] = { "atlas_hero_head_new", "herodetails_herohead_5" },
    [6] = { "atlas_hero_head_new", "herodetails_herohead_6" },
    [7] = { "atlas_hero_head_new", "herodetails_herohead_7" },
    [8] = { "atlas_hero_head_new", "herodetails_herohead_8" },
    [9] = { "atlas_hero_head_new", "herodetails_herohead_9" },
    [10] = { "atlas_hero_head_new", "herodetails_herohead_10" },
    [11] = { "atlas_hero_head_new", "herodetails_herohead_11" },
    [12] = { "atlas_hero_head_new", "herodetails_herohead_11" },
    [13] = { "atlas_hero_head_new", "herodetails_herohead_11" },
    [14] = { "atlas_hero_head_new", "herodetails_herohead_11" },
    [15] = { "atlas_hero_head_new", "herodetails_herohead_11" },
    [16] = { "atlas_hero_head_new", "herodetails_herohead_11" },
}



UIConst.HEROICONSTAR = {
    [1] = { "atlas_herocard_star", "card_big_iconstartl01" },
    [2] = { "atlas_herocard_star", "card_big_iconstartl02" },
    [3] = { "atlas_herocard_star", "card_big_iconstartl03" },
    [4] = { "atlas_herocard_star", "card_big_iconstartl04" },
    [5] = { "atlas_herocard_star", "card_big_iconstartl05" },
    [6] = { "atlas_herocard_star", "card_big_iconstartl06" },
    [7] = { "atlas_herocard_star", "card_big_iconstartl07" },
    [8] = { "atlas_herocard_star", "card_big_iconstartl08" },
    [9] = { "atlas_herocard_star", "card_big_iconstartl09" },
    [10] = { "atlas_herocard_star", "card_big_iconstartl10" },
    [11] = { "atlas_herocard_star", "card_big_iconstartl11" },
    [12] = { "atlas_herocard_star", "card_big_iconstartl12" },
    [13] = { "atlas_herocard_star", "card_big_iconstartl13" },
    [14] = { "atlas_herocard_star", "card_big_iconstartl14" },
    [15] = { "atlas_herocard_star", "card_big_iconstartl15" },
    [16] = { "atlas_herocard_star", "card_big_iconstartl15" },
}
UIConst.HEROSTARFRAME = {
    [1] = { "atlas_herocard", "card_n_iconstartl01" },
    [2] = { "atlas_herocard", "card_n_iconstartl02" },
    [3] = { "atlas_herocard", "card_n_iconstartl03" },
    [4] = { "atlas_herocard", "card_n_iconstartl04" },
    [5] = { "atlas_herocard", "card_n_iconstartl05" },
    [6] = { "atlas_herocard_1", "card_n_iconstartl06" },
    [7] = { "atlas_herocard_1", "card_n_iconstartl07" },
    [8] = { "atlas_herocard_1", "card_n_iconstartl08" },
    [9] = { "atlas_herocard_1", "card_n_iconstartl09" },
    [10] = { "atlas_herocard_1", "card_n_iconstartl10" },
    [11] = { "atlas_herocard_1", "card_n_iconstartl11" },
    [12] = { "atlas_herocard_2", "card_n_iconstartl12" },
    [13] = { "atlas_herocard_2", "card_n_iconstartl13" },
    [14] = { "atlas_herocard_2", "card_n_iconstartl14" },
    [15] = { "atlas_herocard_2", "card_n_iconstartl15" },
    [16] = { "atlas_herocard_2", "card_n_iconstartl15" },
}

UIConst.HeroStarIcon = {
    [1] = { "atlas_star", "card_big_iconstartl1" },
    [2] = { "atlas_star", "card_big_iconstartl2" },
    [3] = { "atlas_star", "card_big_iconstartl3" },
    [4] = { "atlas_star", "card_big_iconstartl4" },
    [5] = { "atlas_star", "card_big_iconstartl5" },
    [6] = { "atlas_star", "card_big_iconstartl6" },
    [7] = { "atlas_star", "card_big_iconstartl7" },
    [8] = { "atlas_star", "card_big_iconstartl8" },
    [9] = { "atlas_star", "card_big_iconstartl9" },
    [10] = { "atlas_star", "card_big_iconstartl10" },
    [11] = { "atlas_star", "card_big_iconstartl11" },
    [12] = { "atlas_star", "card_big_iconstartl12" },
    [13] = { "atlas_star", "card_big_iconstartl13" },
    [14] = { "atlas_star", "card_big_iconstartl14" },
    [15] = { "atlas_star", "card_big_iconstartl15" },
}
UIConst.icon_color = {
    [1] = "WHITE",
    [2] = "QUALITYGREEN",
    [3] = "QUALITYBLUE",
    [4] = "QUALITYFUCHSIA",
    [5] = "QUALITYORANGE",
    [6] = "QUALITYYELLOW",
    [7] = "QUALITYRED",
    [8] = "QualityDiamNew",
}
UIConst.SS_icon = {
    [3] = "QUALITYBLUE",
    [4] = "QUALITYFUCHSIA",
    [5] = "QUALITYORANGE",
    [6] = "QUALITYYELLOW",
    [7] = "QUALITYRED",
    [8] = "QualityDiamNew",
}

UIConst.icon_start = {
    [1] = { key = 1, img = "sx_1", imgBg = "promote_quality13", color = "QUALITYGREEN", albumImg = "promote_quality1", bigQuality = "2" },
    [2] = { key = 1, img = "sx_2", imgBg = "promote_quality14", color = "QUALITYBLUE", albumImg = "promote_quality2", bigQuality = "3" },
    [3] = { key = 1, img = "sx_3", imgBg = "promote_quality8", color = "QUALITYFUCHSIA", albumImg = "promote_quality3", bigQuality = "4" },
    [4] = { key = 1, img = "sx_4", imgBg = "promote_quality8", color = "QUALITYFUCHSIA", albumImg = "promote_quality4", bigQuality = "4" },
    [5] = { key = 1, img = "sx_5", imgBg = "promote_quality12", color = "QUALITYORANGE", albumImg = "promote_quality5", bigQuality = "5" },
    [6] = { key = 1, img = "sx_6", imgBg = "promote_quality12", color = "QUALITYYELLOW", albumImg = "promote_quality6", bigQuality = "6" },
    [7] = { key = 2, img = "sx_7", imgBg = "promote_quality10", color = "QUALITYYELLOW", albumImg = "promote_quality6", bigQuality = "6" },
    [8] = { key = 3, img = "sx_8", imgBg = "promote_quality10", color = "QUALITYYELLOW", albumImg = "promote_quality6", bigQuality = "6" },
    [9] = { key = 4, img = "sx_9", imgBg = "promote_quality12", color = "QUALITYYELLOW", albumImg = "promote_quality6", bigQuality = "6" },
    [10] = { key = 5, img = "sx_10", imgBg = "promote_quality12", color = "QUALITYYELLOW", albumImg = "promote_quality6", bigQuality = "6" },
    [11] = { key = 1, img = "sx_11", imgBg = "promote_quality9", color = "QUALITYRED", albumImg = "promote_quality7", bigQuality = "7" },
    [12] = { key = 2, img = "sx_12", imgBg = "promote_quality9", color = "QUALITYRED", albumImg = "promote_quality7", bigQuality = "7" },
    [13] = { key = 3, img = "sx_13", imgBg = "promote_quality9", color = "QUALITYRED", albumImg = "promote_quality7", bigQuality = "7" },
    [14] = { key = 4, img = "sx_14", imgBg = "promote_quality9", color = "QUALITYRED", albumImg = "promote_quality7", bigQuality = "7" },
    [15] = { key = 5, img = "sx_15", imgBg = "promote_quality9", color = "QUALITYRED", albumImg = "promote_quality7", bigQuality = "7" },
    [16] = { key = 6, img = "sx_16", imgBg = "promote_quality9", color = "QUALITYRED", albumImg = "promote_quality7", bigQuality = "7" },
}
UIConst.sameSoundColor = {
    [0] = UIColor.WHITE,      --没在共鸣水晶里的英雄
    [1] = UIColor.sameSound2, --传奇英雄
    [2] = UIColor.sameSound1, --共鸣英雄

}
UIConst.sameSoundData = {
    [0] = "level",       --没在共鸣水晶里的英雄
    [1] = "level",       --传奇英雄
    [2] = "sameSoundLv", --共鸣英雄
}
--
UIConst.dogFoodHeroLv = {
    [1] = 100, --绿色
    [2] = 100, --蓝色
    [3] = 160, --紫色
}
-----------------------聊天频道对应背景图----------
UIConst.CHANNEL_ICON_MAP = {
    [Const.CHANNEL_WORLD] = { icon = "BgHornGreen", bg = "BgHornGreenBack", txt = "世界" },
    [Const.CHANNEL_GUILD] = { icon = "BgHornGreen", bg = "BgHornGreenBack", txt = "圈子" },
    [Const.CHANNEL_SERVER] = { icon = "BgHornGreen", bg = "BgHornGreenBack", txt = "当前" },
    [Const.MAIN_CHANNEL_SYSTEM] = { icon = "BgHornOrange", bg = "BgHornOrangeBack", txt = "公告" },
    [Const.WORLD_CHANNEL_SYSTEM] = { icon = "BgHornOrange", bg = "BgHornOrangeBack", txt = "公告" },
    [Const.GUILD_CHANNEL_SYSTEM] = { icon = "BgHornBlue", bg = "BgHornBlueBack", txt = "圈子" },
}





-----------------------红点-----------------------
--红点key
UIConst.RD_HINT_A = 1
UIConst.RD_HINT_B = 2
UIConst.RD_HINT_ALL_NEWBIE_TASK = 3         -- 新手任务入口
UIConst.RD_HINT_TASK_MAIN = 4               -- 成就主入口
UIConst.RD_HINT_DAILY_TASK = 5              -- 每日任务
UIConst.RD_HINT_WEEKLY_TASK = 6             -- 每周任务
UIConst.RD_HINT_ACHIEVE_TASK = 7            -- 成就
UIConst.RD_HINT_TRUNK_ACHIEVE = 8           -- 主线成就
UIConst.RD_HINT_BRANCH_ACHIEVE = 9          -- 支线成就
UIConst.RD_HINT_HERO = 10                   --英雄
UIConst.RD_HINT_HERO_STEP_UP = 11           --英雄升阶
UIConst.RD_HINT_HERO_EQUIP = 12             --英雄装备
UIConst.RD_HINT_HERO_STAR_UP = 13           --英雄升星
UIConst.RD_HINT_HERO_SELL = 14              --英雄回收
UIConst.RD_HINT_HERO_STEP_CAN_SWEEP = 15    --英雄升阶材料该扫荡了
UIConst.RD_HINT_HERO_NEW_FIVE = 16          --新手期新到5星英雄new标签
UIConst.RD_HINT_HERO_BASE = 17              --英雄可获取底座
UIConst.RD_HINT_HERO_STEP_QUICK_SWEEP = 18  --可以一键扫荡
UIConst.RD_HINT_HERO_SKIN = 19              -- 英雄新获得皮肤红点
UIConst.RD_HINT_DRAWCARD = 20               -- 抽卡
UIConst.RD_HINT_DRAWCARD_FREE = 21          -- 免费抽卡
UIConst.RD_HINT_DRAWCARD_STANDARD = 22      -- 英雄召唤心愿单
UIConst.RD_HINT_DRAWCARD_NEWBIE = 23        -- 新手抽卡
UIConst.RD_HINT_OTHER_BATTLE = 24           -- 主界面入口：战斗按钮
UIConst.RD_HINT_DRAWCARD_STANDARD_ITEM = 25 -- 有抽卡道具:标准
UIConst.RD_HINT_DRAWCARD_FREE_ITEM = 26     -- 有抽卡道具:免费
UIConst.RD_HINT_DRAWCARD_GROUP = 27         -- 阵营抽卡
UIConst.RD_HINT_LOGIN_ACHIEVE = 28          -- 登录成就（新手任务入口）
UIConst.RD_HINT_NEWBIE_TASK = 29            -- 新手任务（新手任务入口）

UIConst.RD_HINT_FRIEND = 30                 -- 好友
UIConst.RD_HINT_FRIEND_REQUEST = 31         -- 好友请求
UIConst.RD_HINT_FRIEND_GIFT = 32            -- 好友友情点领取
UIConst.RD_HINT_ADVANCE_TASK = 33           -- 进阶之路（新手任务入口）

UIConst.RD_HINT_CHALLENGE_BOSS = 40         -- 挑战BOSS

UIConst.RD_HINT_HANDBOOK = 50               -- 图鉴红点
UIConst.RD_HINT_HANDBOOK_AWARD = 51         -- 有图鉴任务奖励
UIConst.RD_HINT_HANDBOOK_MONUMENT = 52      -- 有图鉴丰碑奖励

UIConst.RD_HINT_MAZE = 60                   --迷宫玩法

UIConst.RD_HINT_CHAT = 70                   --聊天
UIConst.RD_HINT_CHAT_PRIVATE = 71           --私聊

UIConst.RD_HINT_PVP = 80                    --竞技场入口
UIConst.RD_HINT_PVP_FORMATION = 81          --竞技场布阵入口
UIConst.RD_HINT_PVP_RECORD = 82             --竞技场挑战记录
UIConst.RD_HINT_PVP_ENTER = 83              --竞技场玩法总入口

UIConst.RD_HINT_STEPTOWER = 90              --升阶塔

UIConst.RD_HINT_MAIL = 100                  --邮件
UIConst.RD_HINT_MAIL_UNREAD = 101           --邮件未读

UIConst.RD_HINT_MALL = 110                  --商城入口红点
-- UIConst.RD_HINT_GIFT = 111                  --一级页签新手限定红点
-- UIConst.RD_HINT_NORMAL = 114                  --一级页签普通礼包红点
-- UIConst.RD_HINT_BATTLE_PASS = 120           --一级页签battlePass红点
-- UIConst.RD_HINT_VIP = 125                   --一级页签VIP红点

UIConst.RD_HINT_FUND = 112                   --基金红点
UIConst.RD_HINT_NEWBEE = 113                 --新手礼包礼包红点
UIConst.RD_HINT_FUND_NO_BUY = 114            --基金没买的红点
UIConst.RD_HINT_DAYBEE = 115                 --日礼包礼包红点
UIConst.RD_HINT_WEEKBEE = 116                --周礼包礼包红点
UIConst.RD_HINT_MONTNBEE = 117               --月礼包礼包红点
UIConst.RD_HINT_MONTHCARD = 118              --月卡红点
UIConst.RD_HINT_BPAWARD = 119                --battlePass奖励页红点
UIConst.RD_HINT_BP_STARUP = 121              --battlePass任务页升星红点
UIConst.RD_HINT_BP_PVP = 122                 --battlePass任务页JJC红点
UIConst.RD_HINT_BP_DAILY = 123               --battlePass任务页日常红点
UIConst.RD_HINT_BP_MAZE = 124                --battlePass任务页迷宫红点
UIConst.RD_HINT_VIP_BENEFIT = 126            --vip特权红点
UIConst.RD_HINT_RECHARGE_GIFT = 127          --充值礼包红点

UIConst.RD_HINT_FIRST_RECHARGE = 128         --首充礼包红点
UIConst.RD_HINT_SECOND_RECHARGE = 129        -- 二次首充红点

UIConst.RD_HINT_SUN = 240                    --太阳礼包红点
UIConst.RD_HINT_CROWN = 241                  --王冠礼包红点
UIConst.RD_HINT_SUM = 242                    --夏日礼包红点

UIConst.RD_HINT_BAG = 130                    --背包入口红点
UIConst.RD_HINT_BAG_MATERIAL = 131           --背包道具入口红点
UIConst.RD_HINT_BAG_SHATTER = 132            --背包碎片入口红点
UIConst.RD_HINT_BAG_RELIC = 133              --背包圣物入口红点
UIConst.RD_HINT_BAG_SHATTER_Hero = 134       --背包碎片入口红点
UIConst.RD_HINT_BAG_SHATTER_Artifact = 135   --背包碎片入口红点
UIConst.RD_HINT_BAG_SHATTER_DRAGONEGG = 136  --背包碎片入口龙蛋碎片红点
UIConst.RD_HINT_BAG_SHATTER_DOGFOOD = 137    --背包碎片入口狗粮碎片红点

UIConst.RD_HINT_SURVEY = 140                 --有新的问卷调查
UIConst.RD_HINT_OPACTIVITY = 141             --运营活动总入口红点

UIConst.RD_HINT_REAR_HOUSE = 150             --后宅入口红点
UIConst.RD_HINT_REAR_HOUSE_UPGREAD = 151     --后宅主界面升级按钮
UIConst.RD_HINT_REAR_HOUSE_UPGREAD_BTN = 152 --后宅升级界面按钮
UIConst.RD_HINT_REAR_HOUSE_EDIT = 153        --后宅可以放置手办啦
UIConst.RD_HINT_REAR_HOUSE_EDIT_BTN = 154    --后宅布置模式按钮
UIConst.RD_HINT_REAR_HOUSE_NEW_ITEM = 155    --后宅有新物件
UIConst.RD_HINT_REAR_HOUSE_CRYSTLE_UP = 156  --后宅共鸣水晶升级
UIConst.RD_HINT_COMFORTABLE_AWARD = 157      --后宅舒适度奖励
UIConst.RD_HINT_DISPATCH_AWARD = 158         --派遣奖励
UIConst.RD_HINT_REAR_HOUSE_CLEAN = 159       --扫灰

UIConst.RD_HINT_NEW_ROLE_DRESS = 160         --获得新头像或者新头像框
UIConst.RD_HINT_NEW_HEAD = 161               --新头像获得
UIConst.RD_HINT_NEW_HEAD_IFRAME = 162        --新头像框获得
UIConst.RD_HINT_NEW_HEAD_TITLE = 163         --新头像框获得
UIConst.RD_HINT_NEW_HEAD_MEDAL = 164         --新头像框获得
UIConst.RD_HINT_NEW_HEAD_BOARD = 165         --新头像框获得
UIConst.RD_HINT_NEW_HEAD_HFRAME = 166        --新头像框获得

UIConst.RD_HINT_CIRCLE = 170                 --圈子系统
UIConst.RD_HINT_CIRCLE_SIGN = 171            --圈子签到
UIConst.RD_HINT_CIRCLE_EDIT_HEAD = 172       --圈子编辑头像
UIConst.RD_HINT_CIRCLE_INVITED = 173         --圈子受邀请红点
UIConst.RD_HINT_CIRCLE_APPLY = 174           --圈子申请红点
UIConst.RD_HINT_CIRCLE_TASK = 175            --公会任务红点
UIConst.RD_HINT_CIRCLE_CHALLENGE = 176       --公会挑战红点
UIConst.RD_HINT_GUILD_SHOP = 177             --公会砍价

UIConst.RD_HINT_RENT_MAIN = 180
UIConst.RD_HINT_RENT_NEWTASK = 181
UIConst.RD_HINT_RENT_BORROW = 182
UIConst.RD_HINT_RENT_FORAMTIONLACK = 183
UIConst.RD_HINT_RENT_MESSAGE = 184                -- RD_HINT_RENT_NEWREQ 和 RD_HINT_RENT_NEWLETTER 父节点
UIConst.RD_HINT_RENT_NEWREQ = 185                 -- 悬赏请求消息
UIConst.RD_HINT_RENT_NEWLETTER = 186              -- 悬赏感谢信消息
UIConst.RD_HINT_RENT_UNSELECT = 187
UIConst.RD_HINT_RENT_NEWSENDLETTER = 188          -- 悬赏发送的感谢信消息
UIConst.RD_HOLYMOUNTAIN = 190                     --圣山启示录领取奖励消息

UIConst.RD_HINT_HOME = 200                        -- 返回主界面家里

UIConst.RD_HINT_EQUIPTOWER = 210                  --装备塔
UIConst.RD_HINT_EQUIPTOWER1 = 211                 --装备塔1
UIConst.RD_HINT_EQUIPTOWER2 = 212                 --装备塔2
UIConst.RD_HINT_EQUIPTOWER3 = 213                 --装备塔3

UIConst.RD_HINT_SENIORPVP = 220                   --三队竞技场入口
UIConst.RD_HINT_SENIORPVP_FORMATION = 221         --三队竞技场布阵入口
UIConst.RD_HINT_SENIORPVP_RECORD = 222            --三队竞技场战报入口
UIConst.RD_HINT_SENIORPVP_AWARD = 223             --三队竞技场奖励

UIConst.RD_HINT_WORLDBOSS = 230                   --世界boss入口
UIConst.RD_HINT_WORLDBOSS_CHALLENGE = 231         --世界boss挑战次数
UIConst.RD_HINT_WORLDBOSS_REWARD = 232            --世界boss阶段奖励

UIConst.RD_HINT_UP_WORLDBOSS_CHALLENGE = 233         --UP世界boss挑战次数
UIConst.RD_HINT_UP_WORLDBOSS_REWARD = 234            --UP世界boss阶段奖励



UIConst.RD_HINT_OPACTPVP = 250                    --跨服竞技场红点
UIConst.RD_HINT_OPACTPVP_FORMATION = 251          --跨服竞技场防守阵容红点
UIConst.RD_HINT_OPACTPVP_CHALLENGE = 252          --跨服竞技场挑战红点
UIConst.RD_HINT_OPACTPVP_REPORT = 253             --跨服竞技场战报
UIConst.RD_HINT_OPACTPVP_PART_CHANGE = 254        --跨服竞技场段位变化

UIConst.RD_HINT_SDK_BBS_MSG = 260                 --论坛新消息

UIConst.RD_HINT_PROFICIENT = 270                  --练度入口
UIConst.RD_HINT_PLOTREWIND = 271                  --剧情回看入口

UIConst.RD_HINT_REAR_HOUSE_EDIT1 = 280            --后宅墙面1放置按钮红点
UIConst.RD_HINT_REAR_HOUSE_EDIT2 = 281            --后宅墙面2放置按钮红点

UIConst.RD_HINT_QQ_PRIVILEGE = 290                --QQ特权的显示红点
UIConst.RD_HINT_QQ_PRIVILEGE_ONCE = 291           --QQ特权的一次领取任务红点
UIConst.RD_HINT_QQ_PRIVILEGE_ACHIEVE = 292        --QQ特权的永久任务红点
UIConst.RD_HINT_QQ_PRIVILEGE_DAY = 293            --QQ特权的每日任务红点

UIConst.RD_HINT_CIRCLE_BATTLE = 300               --公会战红点
UIConst.RD_HINT_CIRCLE_BATTLE_TALENT = 301        --公会战天赋入口红点
UIConst.RD_HINT_CIRCLE_BATTLE_POINT_ACHIEVE = 302 --公会战积分成就入口红点
UIConst.RD_HINT_CIRCLE_BATTLE_ACTION_POINT = 303  --公会战行动点

UIConst.RD_HINT_MAINSETTING = 310                 -- 设置入口
UIConst.RD_HINT_NOTICE = 311                      -- 公告
UIConst.RD_HINT_CUSTOMER = 312                    -- 客服

UIConst.RD_HINT_CHALLENGE_BOSS_ALL = 320          --终焉总
UIConst.RD_HINT_CHALLENGE_BOSS_EXPAND = 321       --终焉扩展

UIConst.RD_HINT_BATTLE_EQUIP_WEAR = 330           --战前穿戴按钮红点
UIConst.RD_HINT_RELATION = 331                    --羁绊红点
UIConst.RD_DARK_CRYSTAL = 340                     --黯晶红点
-- ===============活动小红点=================
UIConst.RD_HINT_WISHLIST_ACTIVITY = 350           -- 新人许愿活动
UIConst.RD_HINT_WISHLIST_ACTIVITY_REWARD = 351    -- 新人许愿活动 - 领取

UIConst.RD_HINT_ACTIVITY = 360                    -- 限时活动
UIConst.RD_HINT_ACTIVITY_TYPE1 = 361
UIConst.RD_HINT_ACTIVITY_TYPE2 = 362
UIConst.RD_HINT_ACTIVITY_TYPE3 = 363

UIConst.RD_HINT_ACTIVITY_SHOP = 364          --活动商店
UIConst.RD_HINT_ACTIVITY_SHOP_2 = 364 * 1000 --活动商店


-- 第一个页签
UIConst.RD_HINT_ACTIVITY_SEVEN_SIGN = 36101               -- 新人七日签到
UIConst.RD_HINT_ACTIVITY_SEVEN_SIGN_REWARD = 361011       -- 新人七日签到   - 领取
UIConst.RD_HINT_ACTIVITY_SEVEN_LOGIN = 36102              -- 新人七日登录
UIConst.RD_HINT_ACTIVITY_KING_SIGN = 36103                -- 皇冠签到
UIConst.RD_HINT_ACTIVITY_NEWHERO_SIGN = 36104             -- 新英雄签到
UIConst.RD_HINT_ACTIVITY_NEWHERO_SIGN_2 = 36104 * 1000    -- 新英雄签到
UIConst.RD_HINT_ACTIVITY_LIMIT_UP_REWARD = 36105          -- 限时抽卡成就奖励
UIConst.RD_HINT_ACTIVITY_LIMIT_UP_REWARD_2 = 36105 * 1000 --限时抽卡成就奖励 闪卡召唤

-- 第二个页签
UIConst.RD_HINT_ACTIVITY_MONOPOLY = 368                     -- 掷骰子
-- 第三个页签
UIConst.RD_HINT_ACTIVITY_COMPANY = 369                      -- 宅急送
UIConst.RD_HINT_ACTIVITY_KING_TASK = 370                    -- 皇冠任务
UIConst.RD_HINT_ACTIVITY_KING_EXCHANGE = 371                -- 皇冠兑换
UIConst.RD_HINT_ACTIVITY_KING_ONLINE = 372                  -- 皇冠掉落
UIConst.RD_HINT_ACTIVITY_NEWHERO_PUZZLE = 373               -- 新英雄拼图
UIConst.RD_HINT_ACTIVITY_NEWHERO_PUZZLE_2 = 373 * 1000      -- 新英雄拼图
UIConst.RD_HINT_ACTIVITY_NEWHERO_ALL = 374                  -- 新英雄活动总入口
UIConst.RD_HINT_ACTIVITY_NEWHERO_ALL_2 = 374 * 1000         -- 新英雄活动总入口
UIConst.RD_HINT_ACTIVITY_NEWHERO_DRAMA = 375                -- 新英雄活动剧情
UIConst.RD_HINT_ACTIVITY_NEWHERO_DRAMA_2 = 375 * 1000       -- 新英雄活动剧情
UIConst.RD_HINT_ACTIVITY_NEWHERO_COPY = 376                 -- 新英雄活动副本
UIConst.RD_HINT_ACTIVITY_NEWHERO_COPY_2 = 376 * 1000        -- 新英雄活动副本
UIConst.RD_HINT_ACTIVITY_NEWHERO_RECORD = 377               -- 新英雄活动成就（命运日志）
UIConst.RD_HINT_ACTIVITY_NEWHERO_RECORD_2 = 377 * 1000      -- 新英雄活动成就（命运日志）
UIConst.RD_HINT_ACTIVITY_NEWHERO_YANGCHENG = 378            -- 新英雄养成
UIConst.RD_HINT_ACTIVITY_NEWHERO_CARDCONSUME = 379          -- 新英雄闪卡抽卡消耗
UIConst.RD_HINT_ACTIVITY_NEWHERO_CARDCONSUME_2 = 379 * 1000 -- 新英雄闪卡抽卡消耗
UIConst.RD_HINT_ACTIVITY_NEWHERO_STARACHIEVE = 380          -- 新英雄星级成就
-----月卡用381
UIConst.RD_HINT_MONTH_CARD = 381                            --月卡
----继续活动数据
UIConst.RD_HINT_ACTIVITY_NEW_SEVENSIGN = 382                -- 新七日签到
UIConst.RD_HINT_ACTIVITY_NEW_HEROSIGN = 383                 -- 全英雄签到-42日签到
UIConst.RD_HINT_ACTIVITY_ONLINE_REWARD = 384

UIConst.RD_HINT_ACTIVITY_CHAMPIONSHIPS = 385   -- 锦标赛

UIConst.RD_HINT_ACTIVITY_CARNIVALSHOP = 390    -- 七日豪礼
--UIConst.RD_HINT_ACTIVITY_CARNIVAL = 391
UIConst.RD_HINT_ACTIVITY_CARNIVAL_REWARD = 392 -- 七日豪礼
UIConst.RD_HINT_ACTIVITY_CARNIVAL_COST = 393   -- 七日豪礼
UIConst.RD_HINT_ACTIVITY_CARNIVAL_TABLE = { UIConst.RD_HINT_ACTIVITY_CARNIVAL_REWARD, UIConst
    .RD_HINT_ACTIVITY_CARNIVAL_COST }

UIConst.RD_HINT_ACTIVITY_CARNIVALSHOP2 = 394    -- 七日豪礼
--UIConst.RD_HINT_ACTIVITY_CARNIVAL2 = 395
UIConst.RD_HINT_ACTIVITY_CARNIVAL2_REWARD = 396 -- 七日豪礼
UIConst.RD_HINT_ACTIVITY_CARNIVAL2_COST = 397   -- 七日豪礼
UIConst.RD_HINT_ACTIVITY_CARNIVAL2_TABLE = { UIConst.RD_HINT_ACTIVITY_CARNIVAL2_REWARD, UIConst
    .RD_HINT_ACTIVITY_CARNIVAL2_COST }

UIConst.RD_HINT_ACTIVITY_CARNIVALSHOP3 = 398    -- 七日豪礼
--UIConst.RD_HINT_ACTIVITY_CARNIVAL3 = 399
UIConst.RD_HINT_ACTIVITY_CARNIVAL3_REWARD = 400 -- 七日豪礼
UIConst.RD_HINT_ACTIVITY_CARNIVAL3_COST = 401   -- 七日豪礼
UIConst.RD_HINT_ACTIVITY_CARNIVAL3_TABLE = { UIConst.RD_HINT_ACTIVITY_CARNIVAL3_REWARD, UIConst
    .RD_HINT_ACTIVITY_CARNIVAL3_COST }

UIConst.RD_HINT_ACTIVITY_CARNIVALSHOP4 = 402    -- 七日豪礼
--UIConst.RD_HINT_ACTIVITY_CARNIVAL4 = 403
UIConst.RD_HINT_ACTIVITY_CARNIVAL4_REWARD = 404 -- 七日豪礼
UIConst.RD_HINT_ACTIVITY_CARNIVAL4_COST = 405   -- 七日豪礼
UIConst.RD_HINT_ACTIVITY_CARNIVAL4_TABLE = { UIConst.RD_HINT_ACTIVITY_CARNIVAL4_REWARD, UIConst
    .RD_HINT_ACTIVITY_CARNIVAL4_COST }

UIConst.RD_HINT_ACTIVITY_CARNIVALSHOP5 = 406    -- 七日豪礼
--UIConst.RD_HINT_ACTIVITY_CARNIVAL5 = 407
UIConst.RD_HINT_ACTIVITY_CARNIVAL5_REWARD = 408 -- 七日豪礼
UIConst.RD_HINT_ACTIVITY_CARNIVAL5_COST = 409   -- 七日豪礼
UIConst.RD_HINT_ACTIVITY_CARNIVAL5_TABLE = { UIConst.RD_HINT_ACTIVITY_CARNIVAL5_REWARD, UIConst
    .RD_HINT_ACTIVITY_CARNIVAL5_COST }

UIConst.RD_HINT_ACTIVITY_CARNIVALSHOP6 = 410    -- 七日豪礼
--UIConst.RD_HINT_ACTIVITY_CARNIVAL6 = 411
UIConst.RD_HINT_ACTIVITY_CARNIVAL6_REWARD = 412 -- 七日豪礼
UIConst.RD_HINT_ACTIVITY_CARNIVAL6_COST = 413   -- 七日豪礼
UIConst.RD_HINT_ACTIVITY_CARNIVAL6_TABLE = { UIConst.RD_HINT_ACTIVITY_CARNIVAL6_REWARD, UIConst
    .RD_HINT_ACTIVITY_CARNIVAL6_COST }

UIConst.RD_HINT_SOULSTONE = 420 --魂石
UIConst.RD_HINT_SOULSTONESKILL = 421 --魂石技能
UIConst.RD_HINT_SOULSTONE14 = 1820 --魂石占星值
UIConst.RD_HINT_SOULSTONE15 = 1920 --魂石占星值
UIConst.RD_HINT_SOULSTONE16 = 2020 --魂石占星值


-- ===============新系统=====================
UIConst.RD_HINT_DIALOG = 501                       --剧情红点
UIConst.RD_HINT_ARENA = 502                        --竞技场红点
UIConst.RD_HINT_ARENAFREE = 503                    --竞技场免费次数红点
UIConst.RD_HINT_ARENARECOAD = 504                  --竞技场被挑战红点
UIConst.RD_HINT_ARENARE_WEEKLY_1V1 = 1501                  --竞技场1V1周奖励红点
UIConst.RD_HINT_ARENARE_WEEKLY_3V3 = 1502                  --竞技场3V3周奖励红点

UIConst.RD_HINT_ARENA_3V3 = 502 * 1000             --竞技场红点
UIConst.RD_HINT_ARENAFREE_3V3 = 503 * 1000         --竞技场免费次数红点
UIConst.RD_HINT_ARENARECOAD_3V3 = 504 * 1000       --竞技场被挑战红点

UIConst.RD_HINT_CITY = 505                         -- 主城红点
UIConst.RD_HINT_HEROLVUP = 506                     -- 英雄升级
UIConst.RD_HINT_MANAGER = 507                      --管理局
UIConst.RD_HINT_NEWBIE = 508                       --萌新优选
UIConst.RD_HINT_SKIN = 509                         --皮肤
UIConst.RD_HINT_GMSJ_ADD = 510                     -- 共鸣水晶可放置英雄
UIConst.RD_HINT_GMSJ_UPLV = 511                    -- 5个建筑可升级
UIConst.RD_HINT_NEWHERO_DIALOG = 522               --新英雄剧情红点
UIConst.RD_HINT_NEWHERO_DIALOG_2 = 522 * 1000      --新英雄剧情红点
UIConst.RD_RENTTASK = 530                          --悬赏

UIConst.RD_HINT_DUANWEI_REWARD = 532               --段位奖励
UIConst.RD_HINT_DUANWEI_REWARD_3V3 = 532 * 1000    --段位奖励
UIConst.RD_HINT_DUANWEI_GUAJI_3V3 = 532 * 1000 + 1 --挂机奖励

--商城    刘启阳 免费礼包的红点 ============动态分配===========
UIConst.RD_HINT_OC_MALL = 531         --商城红点
UIConst.RD_HINT_VIP_REWARD = 533      --商城 VIP奖励红点
UIConst.RD_HINT_BATTLEPASS_ML = 534   --商城 主线战令奖励红点
UIConst.RD_HINT_BATTLEPASS_CT = 535   --商城 爬塔战令奖励红点
UIConst.RD_HINT_BATTLEPASS_AC = 536   --商城 活跃战令奖励红点
UIConst.RD_HINT_BATTLEPASS_PCAC = 537 --商城 创建角色活跃战令奖励红点

UIConst.RD_HINT_OC_RANK = 538         --排行榜红点


--主界面 礼包推送红点
UIConst.RD_HINT_GIFTPUSH_MAIN = 539    --商城 礼包推送红点

UIConst.RD_HINT_FIRST_DRAGON_EGG = 540 --首充礼包红点
UIConst.RD_HINT_MAINTASK = 541         --守护者计划红点 (具备主线任务功能)

--活动商店红点
--锦标赛排行
UIConst.RD_HINT_ACTIVITY_CHAMPIONSHIPS_RANK_1 = 542 --锦标赛1
UIConst.RD_HINT_ACTIVITY_CHAMPIONSHIPS_RANK_2 = 543 --锦标赛2
UIConst.RD_HINT_ACTIVITY_CHAMPIONSHIPS_RANK_3 = 544 --锦标赛3
UIConst.RD_HINT_ACTIVITY_CHAMPIONSHIPS_RANK_4 = 545 --锦标赛4
--锦标赛任务
UIConst.RD_HINT_ACTIVITY_CHAMPIONSHIPS_TASK_1 = 546 --锦标赛1
UIConst.RD_HINT_ACTIVITY_CHAMPIONSHIPS_TASK_2 = 547 --锦标赛2
UIConst.RD_HINT_ACTIVITY_CHAMPIONSHIPS_TASK_3 = 548 --锦标赛3
UIConst.RD_HINT_ACTIVITY_CHAMPIONSHIPS_TASK_4 = 549 --锦标赛4

--魂石召唤
UIConst.RD_HINT_SOULSTONE_DRAW =560

--魂石抽奖
UIConst.RD_HINT_ACTIVITY_SOULSTONE_DRAW = 700
UIConst.RD_HINT_ACTIVITY_SOULSTONE_RANK = 710
--商城     基金红点
UIConst.RD_HINT_MALL_FUND = 711     --基金红点




--专为商城使用的动态分配，下面1000的动态分配不确定谁的逻辑，不敢用
UIConst.RD_FREE_GIFT_TYPE_COUNTER = 2000 --商城礼包红点

--专为活动使用的动态分配，下面1000的动态分配不确定谁的逻辑，不敢用
UIConst.RD_ACTIVITY_TYPE_COUNTER = 3000 --商城礼包红点

-- ===============1000以上预留给动态分配=====================
UIConst.RD_HINT_DYNAMIC_COUNTER = 1000

--召唤奖励红点,预留20个
for i = 1, 20 do
    UIConst['RD_DRAWCARD_CALL_REWARD_' .. i] = 600 + i
end






-- 初始化挑战BOSS类型的红点
local ResBossTower = DataTable.ResBossTower













UIConst.RD_HINT_OC_MALL_TAB = {}
UIConst.RD_HINT_OC_MALL_SUB = {}      -- 二级页签一次性new的红点ID
UIConst.RD_HINT_OC_MALL_ALL_HINT = {} -- 记录所有的红点规则  在初始化时清空下  防止切换账号后出问题



------------------------------OC项目红点End--------------------------------

---------------------红点 end---------------------------

-------------------------AVG-------------------------
UIConst.AVG_TALK_TYPE_LEFT = 0
UIConst.AVG_TALK_TYPE_RIGHT = 1
UIConst.AVG_TALK_TYPE_OS = 2
UIConst.AVG_TALK_TYPE_ASIDE = 3
UIConst.AVG_TALK_TYPE_BRANCH = 4
UIConst.AVG_TALK_TYPE_BOOM = 5
UIConst.AVG_TALK_TYPE_SPECIALOPT = 6    --not use
UIConst.AVG_TALK_TYPE_INTRODUCTION = 7  --not use
UIConst.AVG_TALK_TYPE_CHAPTEREND = 8    --not use
UIConst.AVG_TALK_TYPE_ASIDEBLACK = 9
UIConst.AVG_TALK_TYPE_SECTIONINTRO = 10 --not use
UIConst.AVG_TALK_TYPE_VIDEO = 11
UIConst.AVG_TALK_TYPE_IDCARD = 12       --not use
UIConst.AVG_TALK_TERMINAL_LEFT = 13     --not use
UIConst.AVG_TALK_TERMINAL_BLOOM = 14    --not use
UIConst.AVG_TALK_TYPE_LIVE = 15         --not use
UIConst.AVG_TALK_TYPE_POSTER = 16       --not use

UIConst.AVG_TERMINAL_TYPE_NONE = 0
UIConst.AVG_TERMINAL_TYPE_CALLOUT = 1
UIConst.AVG_TERMINAL_TYPE_CALLIN = 2
UIConst.AVG_TERMINAL_TYPE_TALK = 3
UIConst.AVG_TERMINAL_TYPE_END = 4
UIConst.AVG_TERMINAL_TYPE_OPEN = 5

UIConst.AVG_BG_FAKERECORDER = 1
UIConst.AVG_BG_MEMORY = 2

UIConst.ROLEIMAGE_SHOWTYPE_HANDBOOK = "handbook"
UIConst.ROLEIMAGE_SHOWTYPE_HERO_GET = "hero_get"
UIConst.ROLEIMAGE_SHOWTYPE_BATTLE_SKILL = "battle_skill"
UIConst.ROLEIMAGE_SHOWTYPE_DRAW_CARD = "draw_card"
UIConst.ROLEIMAGE_SHOWTYPE_STAR_UP = "star_up"
UIConst.ROLEIMAGE_SHOWTYPE_GET_SKIN = "get_skin"
UIConst.ROLEIMAGE_SHOWTYPE_BUY_SKIN = "buy_skin"
UIConst.ROLEIMAGE_SHOWTYPE_SHOW_SKIN = "show_skin"               --英雄界面皮肤展示
UIConst.ROLEIMAGE_SHOWTYPE_RENT_TASK = "rent_task"               --悬赏
UIConst.ROLEIMAGE_SHOWTYPE_RENT_TASK_DETAIL = "rent_task_detail" --悬赏详情
UIConst.ROLEIMAGE_SHOWTYPE_HERO_DROP = "hero_drop"               --英雄掉落

UIConst.AVG_OPT_MODE_PRESS = 1
UIConst.AVG_OPT_MODE_CLICK = 2

-- 剧情回看类型
UIConst.PLOT_REWIND_MAIN_LINE = 1
UIConst.PLOT_REWIND_SIDE_LINE = 2

-- UIConst.DETAIL_CELL_WIDTH = 225
UIConst.DETAIL_CELL_WIDTH = 684
UIConst.DETAIL_CELL_HEIGHT = 154
UIConst.CHAPTER_CELL_WIDTH = 684
UIConst.CHAPTER_CELL_HEIGHT = 200

UIConst.AVG_DEFAULT_BG_MATERIAL = "UI/GUIRes/Material/UITransSquare.mat"

-- 弹幕请求情况
UIConst.SERVER_BULLET_NONE = 1
UIConst.SERVER_BULLET_EXIST = 2
UIConst.SERVER_BULLET_UNKNOWN = 3

-- 弹幕种类
UIConst.AVG_BULLET_TEXT = 101
UIConst.AVG_BULLET_EMOJI = 102
UIConst.AVG_BULLET_MOVEEMOJI = 103

---------------------AVG END-------------------------

---------------------应援活动 Begin ------------------------
UIConst.MIKU_CONCERT = 2102
UIConst.AI_CHANNEL = 2103
UIConst.AI_CHANNEL2 = 2104
UIConst.CONCERT_SCROLL_HORIZONTAL = 1
UIConst.CONCERT_SCROLL_VERTICAL = 2
UIConst.CONCERT_REWARD_COMMON = 1
UIConst.CONCERT_REWARD_SHOWGIFT = 2






---------------------应援活动 End ------------------------

--弹窗类型
UIConst.CONFIRM_ONEBTN = 1
UIConst.CONFIRM_TWOBTN = 2
UIConst.CONFIRM_THREEBTN = 3

UIConst.SKILL_PANEL_HERO_BASE = 1
UIConst.SKILL_PANEL_HANDBOOK = 2
UIConst.SKILL_PANEL_HERO_STEP = 3
UIConst.SKILL_PANEL_ROLE_INFO = 4 --个人信息那里的英雄界面
UIConst.SKILL_PANEL_WORLD_BOSS = 5
UIConst.SKILL_PANEL_WORLD_BOSS_NEXT = 6










UIConst.FILTER_TYPE_SINGLE_SEL = 1 -- 单选
UIConst.FILTER_TYPE_MULTI_SEL = 2  -- 多选








---------------------HeroSortConfig END-------------------------

---------------------RANK_UI_INFO-------------------------------
local ResGamePlayNotice = require("Core/ClientData/ResGamePlayNotice")

UIConst.RANK_UI_INFO = {
    [Const.RANK_TYPE_ONCETOWER] = { title = ResGamePlayNotice[Const.GAME_PLAY_NOTICE_ONCE_TOWER].name, title2 = "关卡进度" },
    [Const.RANK_TYPE_BOSSTOWER1] = { title = ResBossTower[1][1].name, title2 = "累积伤害" },
    [Const.RANK_TYPE_BOSSTOWER2] = { title = ResBossTower[2][1].name, title2 = "累积伤害" },
    [Const.RANK_TYPE_BOSSTOWER3] = { title = ResGamePlayNotice[Const.GAME_PLAY_NOTICE_CHALLENGE_BOSS].name, title2 = "圈子成员进度" },
    [Const.RANK_TYPE_BOSSTOWER4] = { title = ResGamePlayNotice[Const.GAME_PLAY_NOTICE_CHALLENGE_BOSS].name, title2 = "累积伤害" },
    [Const.RANK_TYPE_MAINSTAGE] = { title = "主线冒险", title2 = "关卡进度" },
    [Const.RANK_TYPE_ASYNCPVP] = { title = ResGamePlayNotice[Const.GAME_PLAY_NOTICE_ARENA].name, title2 = "积分", hideTime = 1 },
    [Const.RANK_TYPE_GROUP1] = { title = string.format("%s应援榜", ResHeroCampCareerConfig[1][1].name), title2 = "应援积分", },
    [Const.RANK_TYPE_GROUP2] = { title = string.format("%s应援榜", ResHeroCampCareerConfig[1][2].name), title2 = "应援积分", },
    [Const.RANK_TYPE_GROUP3] = { title = string.format("%s应援榜", ResHeroCampCareerConfig[1][3].name), title2 = "应援积分", },
    [Const.RANK_TYPE_MULTIPVP] = { title = "", title2 = "", hideTime = 1 },
    [Const.RANK_TYPE_WORLDBOSS] = { title = "天启阻击战", title2 = "", showSvrName = 1, showBtnAward = 1, showPanelTime = 1 },
    [Const.RANK_TYPE_ACTIVITY_PLOT] = { title = "竞速排行", title2 = "达成所有目标通关", hideTime = 1 },
    [Const.RANK_TYPE_OPACTPVP] = { title = "", title2 = "", hideTime = 1 },
    [Const.RANK_TYPE_HOUSEFAVOR] = { title = "人气排行榜", title2 = "", hideTime = 1 },
    [Const.RANK_TYPE_SEASON_TOWER_SCORE] = { title = "总积分榜", title2 = "累计积分", showSvrName = 1, showBtnAward = 1, showPanelTime = 1 },
    [Const.RANK_TYPE_SEASON_TOWER_LAYER] = { title = "单塔榜", title2 = "层数", hideTitle2 = 1, showSvrName = 1, showPanelTime = 1 },
    [Const.RANK_TYPE_CIRCLE_BATTLE_FEAT] = { title = "首领杯排名", title2 = "战功", hideTitle2 = 1, showBtnAward = 1, showPanelTime = 1 },
    [Const.RANK_TYPE_CIRCLE_BATTLE_LAYER] = { title = "圈子排名", title2 = "层数", hideTitle2 = 1, showBtnAward = 1, showPanelTime = 1 },
}

for i = 1, 9 do
    local title = ""
    UIConst.RANK_UI_INFO[Const["RANK_TYPE_BOSS_EXPAND_" .. i]] = { title = title }
end

function UIConst.getRankScoreStr(rankType, scoreInfo)
    if scoreInfo == 0 and not Const.SPE_EMPTY_PROGRESS_SHOW_TYPE[rankType] then
        return "暂未挑战"
    end
    if rankType == Const.RANK_TYPE_ONCETOWER then
        return scoreInfo .. "F"
    end
    if rankType == Const.RANK_TYPE_MAINSTAGE then
        local season = math.floor(scoreInfo / 10000)
        local chapter = math.floor((scoreInfo - (10000 * season)) / 100)
        local level = scoreInfo - season * 10000 - chapter * 100
        return ClientUtils.getMainStageLevelStr(season, chapter, level)
    end
    if rankType == Const.RANK_TYPE_BOSSTOWER3 then
        local layer = math.floor(scoreInfo / 100000)
        local level = scoreInfo - layer * 100000
        return utils.format("%1s层%2s波", layer, level)
    end
    if rankType == Const.RANK_TYPE_BOSSTOWER1 or rankType == Const.RANK_TYPE_BOSSTOWER2 then
        local layer = math.floor(scoreInfo / 100000)
        local percent = tonumber(string.format('%.2f', (scoreInfo - (100000 * layer)) / 100)) .. '%'
        return utils.format("%1s层%2s", layer, percent)
    end
    if rankType == Const.RANK_TYPE_ACTIVITY_PLOT then
        if scoreInfo > 0 then
            return TimeUtils.calcTimeTxt(scoreInfo)
        else
            return "目标未达成"
        end
    end
    if rankType == Const.RANK_TYPE_SEASON_TOWER_LAYER then
        return string.format("%s关", scoreInfo)
    end
    if rankType == Const.RANK_TYPE_CIRCLE_BATTLE_LAYER then
        if scoreInfo > 0 then
            local layer = math.floor(scoreInfo / 100000)
            local progressValue = math.floor((scoreInfo - (100000 * layer)) / 100)
            local progress = progressValue .. '%'
            return utils.format("通关%1s站（第%2s站%3s）", layer, layer + 1, progress)
        else
            return "暂未通关"
        end
    end
    if rankType == Const.RANK_TYPE_CIRCLE_BATTLE_FEAT then
        return utils.format("<0701>首领杯：%1s", scoreInfo)
    end
    if Const.RANK_TYPE_BOSS_EXPAND_MAP[rankType] then
        return string.format("累计通关：%1s", scoreInfo)
    end
    --保证scoreInfo的数据类型为string
    return scoreInfo .. ""
end

---------------------RANK_UI_INFO_END-------------------------------



--获取跳字状态信息
local ResBattleShowState = DataTable.ResBattleShowState
function UIConst.getBattleShowStateInfo(stateID)
    local data = ResBattleShowState[stateID]
    local info = ""
    if data then
        local arrow = data.arrow or 0
        if arrow == 0 then
            arrow = ""
        else
            arrow = string.format("%02d", arrow)
        end
        info = string.format("%s|%s|%d", data.stateName or "", arrow, data.dir or 0)
    end
    return info
end

local ResHero = DataTable.ResHero
local ResCommonModel = DataTable.ResCommonModel
function UIConst.getHeroIconPath(heroId)
    if ResHero[heroId] then
        local model = ResHero[heroId].model
        if ResCommonModel[model] and ResCommonModel[model].icon_path then
            return { "Atlas/" .. ResCommonModel[model].icon_path, ResCommonModel[model].icon_name }
        end
    end
end

function UIConst.getHeroHeadIconPath(heroId)
    if ResHero[heroId] then
        local model = ResHero[heroId].model
        if ResCommonModel[model] and ResCommonModel[model].head_path then
            return { "Atlas/" .. ResCommonModel[model].head_path, ResCommonModel[model].head_name }
        end
    end
end

function UIConst.getModelHeadIconPath(model)
    if ResCommonModel[model] and ResCommonModel[model].head_path then
        return { "Atlas/" .. ResCommonModel[model].head_path, ResCommonModel[model].head_name }
    end
end

function UIConst.getHeroQualityPath(heroId)
    if ResHero[heroId] and ResHero[heroId].quality then
        return UIConst.HERO_QUALITY_CONFIG[ResHero[heroId].quality]
    end
end

function UIConst.getHeroQuality(heroId)
    if ResHero[heroId] and ResHero[heroId].quality then
        return ResHero[heroId].quality
    end
end

function UIConst.getHeroCamZoomPos(hero)
    local showModelId = hero:getShowModelId()
    if showModelId and ResCommonModel[showModelId] and ResCommonModel[showModelId].camera_zoom_pos then
        return ResCommonModel[showModelId].camera_zoom_pos
    end
end

function UIConst.getHeroDrawCameraInfo(heroId)
    if ResHero[heroId] then
        local model = ResHero[heroId].model
        if ResCommonModel[model] and ResCommonModel[model].draw_camera_pos then
            return ResCommonModel[model].draw_camera_pos, ResCommonModel[model].draw_camera_rot,
                ResCommonModel[model].draw_camera_cue
        end
    end
end

local ResMonster = DataTable.ResMonster
function UIConst.getMonsterIconPath(monsterId)
    if ResMonster[monsterId] then
        local model = ResMonster[monsterId].model
        if ResCommonModel[model] and ResCommonModel[model].icon_path then
            return { ResCommonModel[model].icon_path, ResCommonModel[model].icon_name }
        end
    end
end

function UIConst.getMonsterHeadIconPath(monsterId)
    if ResMonster[monsterId] then
        local model = ResMonster[monsterId].model
        if ResCommonModel[model] and ResCommonModel[model].head_path then
            return { "Atlas/" .. ResCommonModel[model].head_path, ResCommonModel[model].head_name }
        end
    end
end

function UIConst.getHeroCampIconPath(campId)
    --兼容新系统——图集
    --return {"Atlas/HeroAtlas/HeroCardCommonAtlas", "IconGroup0"..campId}
    return { "atlas_icon", "camp" .. campId }
end

function UIConst.getHeroCampLargeIconPath(campId)
    if campId >= 4 then
        return { "Atlas/OtherBattleAtlas/EquipTowerAtlas2", "IconGroupL0" .. campId }
    else
        return { "Atlas/OtherBattleAtlas/EquipTowerAtlas", "IconGroupL0" .. campId }
    end
end

function UIConst.getHeroCampBgIconPath(campId)
    return { "Atlas/CommonAtlas/BgGroupAtlas", "BgGroup0" .. campId }
end

function UIConst.getHeroCampAvgIconPath(campId)
    return { "Atlas/AvgAtlas/AvgAtlas", "BgGroup0" .. campId }
end

function UIConst.getHeroCareerIconPath(careerId)
    --兼容新系统--图集
    --if careerId ~= HeroConst.CAREER_TYPE.ALL then
    --    return {"Atlas/HeroAtlas/HeroCardCommonAtlas", "IconCareer0"..careerId}
    --else
    --    return {"Atlas/HeroAtlas/HeroCardCommonAtlas", "IconCareer00"}
    --end
    if careerId ~= HeroConst.CAREER_TYPE.ALL then
        return { "atlas_icon", "career" .. careerId }
    else
        return { "atlas_battle", "battle_infinite_icon" }
    end
end

function UIConst.getLargeTeamIconPath(teamId)
    if teamId <= 6 then
        return { "Atlas/CommonAtlas/IconTeamLargeAtlas", "TxtTeam0" .. teamId }
    end
end

function UIConst.getHeroGroupTeamIconPath(team)
    if team <= 6 then
        return { "Atlas/CommonAtlas/IconTeamAtlas", "IconTeamLittle0" .. team }
    end
end

function UIConst.getHeroCardBgByCamp(campId)
    if campId == HeroConst.CAMP_TYPE.CLASS then
        return { "atlas_herocard", "armedbattlefront_card" }
    elseif campId == HeroConst.CAMP_TYPE.POPULAR then
        return { "atlas_herocard", "forestofnoldor_card" }
    elseif campId == HeroConst.CAMP_TYPE.LEGEND then
        return { "atlas_herocard", "borealvalley_card" }
    elseif campId == HeroConst.CAMP_TYPE.SLIM_SNOW then
        return { "atlas_herocard", "skycity_card" }
    elseif campId == HeroConst.CAMP_TYPE.NINE_NIGHT then
        return { "atlas_herocard", "titancarrier_card" }
    end

    --if campId == HeroConst.CAMP_TYPE.SLIM_SNOW then
    --    return {HERO_COMMON_ATLAS_PATH, "ImgCardBgNmlLight"}
    --elseif campId == HeroConst.CAMP_TYPE.NINE_NIGHT then
    --    return {HERO_COMMON_ATLAS_PATH, "ImgCardBgNmlBlack"}
    --else
    --    return {HERO_COMMON_ATLAS_PATH, "ImgCardBgNml"}
    --end
end


local ResRoleImageData = DataTable.ResRoleImageData
local ROLE_ATLAS_PATH = "Atlas/CommonAtlas/HeroPortraitAtlas/"
function UIConst.getAvgHeadIconPath(heroId)
    local imageData = ResRoleImageData[heroId]
    local modelCfg = ResCommonModel[heroId]
    if imageData and modelCfg then
        --return { ROLE_ATLAS_PATH .. imageData.res_path, imageData.res_name, imageData.size, imageData.scale }
        return { modelCfg.icon_path, modelCfg.icon_name, imageData.size, imageData.scale }
    end
    return {}
end




function UIConst.getRoleImageByType(heroId, imgType)
    local imageData = ResRoleImageData[heroId]
    if imageData then
        local resPath = ROLE_ATLAS_PATH .. imageData.res_path
        local resName = imageData.res_name
        local pos, scale, size
        if imageData[imgType] and imageData[imgType][1] then
            pos = imageData[imgType][1] and imageData[imgType][1].pos or imageData.pos
            scale = imageData[imgType][1] and imageData[imgType][1].scale or imageData.scale
            size = imageData[imgType][1] and imageData[imgType][1].size or imageData.size
        else
            pos = imageData.pos
            scale = imageData.scale
            size = imageData.size
        end
        return { resPath, resName, pos, scale, size }
    else
        logerror("没有立绘信息：heroId", heroId, imgType)
    end
end

local ResUIBgChange = DataTable.ResUIBgChange
local ResUIBgChangeInfo = DataTable.ResUIBgChangeInfo
function UIConst.getBgChangeInfo(uiName)
    if uiName and ResUIBgChange[uiName] then
        -- 判断当前时间是否在某个开放时间段里
        -- 如果处于多个开放时间段，则返回最靠后的那个
        local changeId
        local tmpStartTime
        for id, changeInfo in pairs(ResUIBgChange[uiName]) do
            if not changeInfo["valid_time_id"] or not changeInfo["expire_time_id"] then
                logerror("替换的时间未填写", uiName, id)
                return
            end
            local startPassed = ClientUtils.isTimeConfigPassed(changeInfo["valid_time_id"])
            local endPassed = ClientUtils.isTimeConfigPassed(changeInfo["expire_time_id"])
            if startPassed and not endPassed then
                -- 在时间段里，如果是新的或者比旧的靠后
                if not changeId or (tmpStartTime and ClientUtils.getTimeConfigTimestamp(changeInfo["valid_time_id"]) > tmpStartTime) then
                    changeId = changeInfo["change_id"]
                    tmpStartTime = ClientUtils.getTimeConfigTimestamp(changeInfo["valid_time_id"])
                end
            end
        end

        if changeId then
            return ResUIBgChangeInfo[changeId]
        end
    end
end

function UIConst.getGenderImagePath(gender)
    if gender == Const.GENDER_MAN then
        return { "Atlas/FriendAtlas/FriendAtlas", "IconMale" }
    else
        return { "Atlas/FriendAtlas/FriendAtlas", "IconFemale" }
    end
end

--- AVG数据 ---



--- AVG数据结束 ----
---篝火阵营
UIConst.TEAM = {
    key = string.format(TeamConst.SHOW_BONFIRE_HERO), --篝火布阵英雄的key
    data = {
        [1] = {
            gid = "",
            idx = 1,
        },
        [2] = {
            gid = "",
            idx = 2,
        },
        [3] = {
            gid = "",
            idx = 3,
        },
        [4] = {
            gid = "",
            idx = 4,
        },
        [5] = {
            gid = "",
            idx = 5,
        },
    }
}
UIConst.TEAMHERO = {
    [1] = 23001, --矮子
    [2] = 21001, --龙人
    [3] = 22001, --兽人
    [4] = 24001, --法师
    [5] = 25001, --牧师
}

return UIConst
