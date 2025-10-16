-- 跳过翻译：↓↓↓↓↓↓
-- 1.日志方法 跳过
print "跳过日志方法0:print"
print("跳过日志方法1:print")
log("跳过日志方法2:log")
logerror("跳过日志方法3:logerror")
-- 2.注释内容 跳过
local s1 = "@跳过注释内容1:文本内容以\"@开头"
local s2 = "L|跳过注释内容2:文本内容以\"L|开头"
-- 跳过翻译：↑↑↑↑↑↑

self.txtSkillLv:setText(string.format(__"%1s/%2s级",item:getSkillLevel(),item:getMaxSkillLv()))
local iconPath = string.format("upgrade_%1_%2",item:getSkillLevel(),item:getMaxSkillLv())

self.ReftxtText:setText(string.format(__"将于<color=#ffa200>%s</color>后\n（通关<color=#ffa200>1-1</color>后，商品）",txtTime))


self.txt_Text:setText(string.format(__"剩余:"..self.surplusNum..__"个"))

self.txt_Text:setText(string.format(__"售罄"))

self.txt_Text:setText(string.format(__"本日剩余:".._data.period))


function UITimeReward:setText(newIdx,num)
    local a = math.floor(num*10)
    if newIdx==1 then
        self.txt_Gold:setText(string.format(a..__"/分"))
    elseif newIdx==2 then
        self.txt_Exp:setText(string.format(a..__"/分"))
    elseif newIdx==3 then
        self.txt_HeroExp:setText(string.format(a..__"/分"))
    end
end

function UICommonHeroHeadItem:init(Hero,Camp)
    self.heroData=Hero
    self.heroData.Camp =Camp
    self.edge:setImage("atlas_heroinfo",self.starcolour[Hero.star])
    self.img_HeroIcon:setImage(ResCommonModel[Hero.resid].head_path,ResCommonModel[Hero.resid].head_name)
    self.txt_lv:setText(string.format("LV."..Hero.level.." "))
    if Hero.star>9 then
        self.img_star:setImage("atlas_herocard","card_big_iconstartl"..Hero.star)
    else
        self.img_star:setImage("atlas_herocard","card_big_iconstartl0"..Hero.star)
    end
    self.img_CampIcon:setImage("atlas_icon",string.format("camp"..Camp))
end