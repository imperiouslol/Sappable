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
