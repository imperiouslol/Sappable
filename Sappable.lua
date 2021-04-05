targetIndicator=CreateFrame("Frame");
targetIndicator:SetParent(TargetFrame);
targetIndicator.t=targetIndicator:CreateTexture(nil,BORDER);
targetIndicator.t:SetAllPoints();
targetIndicator.t:SetTexture("Interface\\Icons\\ABILITY_SAP");
targetIndicator:Hide();

focusIndicator=CreateFrame("Frame");
focusIndicator:SetParent(FocusFrame);
focusIndicator.t=focusIndicator:CreateTexture(nil,BORDER);
focusIndicator.t:SetAllPoints();
focusIndicator.t:SetTexture("Interface\\Icons\\ABILITY_SAP");
focusIndicator:Hide();

tCreatureTypesByLocale = {};
tCreatureTypesByLocale["enUS"]={"Humanoid", "Beast", "Demon", "Dragonkin"};
tCreatureTypesByLocale["deDE"]={"Humanoid", "Wildtier", "Dämon", "Drachkin"};
tCreatureTypesByLocale["esES"]={"Humanoide", "Bestia", "Demonio", "Dragonante"};
tCreatureTypesByLocale["esMX"]={"Humanoide", "Bestia", "Demonio", "Dragonante"};
tCreatureTypesByLocale["frFR"]={"d’humanoïde", "de bête", "Démon", "draconiques"};
tCreatureTypesByLocale["itIT"]={"Umanoidi", "Bestiali", "Demone", "Dragoidi"};
tCreatureTypesByLocale["koKR"]={"인간형", "야수", "악마", "용족"};
tCreatureTypesByLocale["ptBR"]={"Humanoide", "Fera", "Demônio", "Draconiano"};
tCreatureTypesByLocale["zhCN"]={"人型", "野兽", "恶魔", "龙类"};
tCreatureTypesByLocale["zhTW"]={"人形", "野獸", "惡魔", "龍類"};

local function updateIndicatorSize()
	if indicatorScale == nil then
		indicatorScale = 26;
		end
	targetIndicator.t:ClearAllPoints()
	targetIndicator.t:SetSize(indicatorScale, indicatorScale)
	targetIndicator.t:SetPoint("Right", TargetFrame, "Right", indicatorScale/2, 0)
	focusIndicator.t:ClearAllPoints()
	focusIndicator.t:SetSize(indicatorScale, indicatorScale)
	focusIndicator.t:SetPoint("Right", FocusFrame, "Right", indicatorScale/2, 0)
end;

local function MyAddonCommands(msg)
	local msg, value = string.split(" ", msg)
	if msg == 'resize' then
	indicatorScale = value
	updateIndicatorSize();
	print("Sap Indicator resized to ", value)
	else
    print("Sappable Options:")
	print("/sappable resize X")
  end
end
SLASH_SAPPABLE1, SLASH_SAPPABLE2 = '/sappable', '/sap'
SlashCmdList["SAPPABLE"] = MyAddonCommands

local function creatureIsSappable(unit)
	creatureType = UnitCreatureType(unit)
	for index, value in ipairs(tCreatureTypesByLocale[GetLocale()]) do
		if (value == creatureType) then
                	return true;
		end;
        end;
	
	return false;
end;

local function showIndicator(self, unit)
	if (creatureIsSappable(unit)
                and not UnitIsFriend("player", unit)
		and not UnitAffectingCombat(unit)) then
		self:Show();
        else
                self:Hide();
        end;
end;

local t = CreateFrame("Frame")
t:SetScript("OnUpdate", function(self) showIndicator(targetIndicator, "target") end);
local f = CreateFrame("Frame")
f:SetScript("OnUpdate", function(self) showIndicator(focusIndicator, "focus") end);
local x = CreateFrame("Frame")
x:RegisterEvent("ADDON_LOADED")
x:SetScript("OnEvent", updateIndicatorSize);
