--local function defaultFunc(L, key)
--	return key;
--end

--MyLocalizationTable = setmetatable({}, {__index=defaultFunc});

--local L = MyLocalizationTable;

--sappableCreatureTypes = {L["Humanoid"], L["Beast"], L["Demon"], L["Dragonkin"]};

local LOCALE = GetLocale()

if LOCALE == "enUS" then
sappableCreatureTypes = {"Humanoid", "Beast", "Demon", "Dragonkin"};
end

if LOCALE == "deDE" then
	sappableCreatureTypes = {"Humanoid", "Wildtier", "Dämon", "Drachkin"};
end

if LOCALE == "esES" then
	sappableCreatureTypes = {"Humanoide", "Bestia", "Demonio", "Dragonante"};
end

if LOCALE == "esMX" then
	sappableCreatureTypes = {"Humanoide", "Bestia", "Demonio", "Dragonante"};
end

if LOCALE == "frFR" then
	sappableCreatureTypes = {"d’humanoïde", "de bête", "Démon", "draconiques"};
end

if LOCALE == "itIT" then
	sappableCreatureTypes = {"Umanoidi", "Bestiali", "Demone", "Dragoidi"};
end

if LOCALE == "koKR" then
	sappableCreatureTypes = {"인간형", "야수", "악마", "용족"};
end

if LOCALE == "ptBR" then
	sappableCreatureTypes = {"Humanoide", "Fera", "Demônio", "Draconiano"};
end

if LOCALE == "zhCN" then
	sappableCreatureTypes = {"人型", "野兽", "恶魔", "龙类"};
end

if LOCALE == "zhTW" then
	sappableCreatureTypes = {"人形", "野獸", "惡魔", "龍類"};
end

targetIndicator=CreateFrame("Frame");
targetIndicator:SetParent(TargetFrame);
targetIndicator:SetPoint("Right", TargetFrame, -15);
targetIndicator:SetSize(26, 26);
targetIndicator.t=targetIndicator:CreateTexture(nil,BORDER);
targetIndicator.t:SetAllPoints();
targetIndicator.t:SetTexture("Interface\\Icons\\ABILITY_SAP");
targetIndicator:Hide();

focusIndicator=CreateFrame("Frame");
focusIndicator:SetParent(FocusFrame);
focusIndicator:SetPoint("Right", FocusFrame, -15);
focusIndicator:SetSize(26, 26);
focusIndicator.t=focusIndicator:CreateTexture(nil,BORDER);
focusIndicator.t:SetAllPoints();
focusIndicator.t:SetTexture("Interface\\Icons\\ABILITY_SAP");
focusIndicator:Hide();

local function creatureIsSappable(unit)
	creatureType = UnitCreatureType(unit)
	for index, value in ipairs(sappableCreatureTypes) do
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
