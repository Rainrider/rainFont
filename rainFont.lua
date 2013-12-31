--[[ CONFIG ]]--
local FONT1 = rainDB and rainDB.font1 or GameFontNormal:GetFont()
local FONT2 = rainDB and rainDB.font2 or GameFontNormal:GetFont()
local FONTSIZE = 24 -- only for incoming events
local BARTEXTURE = "Interface\\AddOns\\rainFont\\normtexc.tga"
local BORDERTEXTURE = "Interface\\AddOns\\rainFont\\border.tga"
--[[ END OF CONFIG ]]--

local mirrorIcons = {
	[EXHAUSTION_LABEL] = "Interface\\Icons\\Spell_Holy_PainSupression",
	[BREATH_LABEL] = "Interface\\Icons\\Spell_Shadow_DemonBreath",
	[GetSpellInfo(5384)] = "Interface\\Icons\\Ability_Rogue_FeignDeath",
}

local function SetFont(obj, font, size, style, sr, sg, sb, sox, soy)
	obj:SetFont(font, size, style)
	if sr and sg and sb then
		obj:SetShadowColor(sr, sg, sb)
	end
	if sox and soy then
		obj:SetShadowOffset(sox, soy)
	end
end

local function ChangeFonts()
	DAMAGE_TEXT_FONT = FONT1
	COMBAT_TEXT_HEIGHT = FONTSIZE
	UNIT_NAME_FONT = FONT1

	-- combat text
	local _, _, fFlags = CombatTextFont:GetFont()
	SetFont(CombatTextFont, FONT1, FONTSIZE, fFlags, 0, 0, 0, 2, -2)

	-- zone text
	SetFont(ZoneTextString, FONT1, 30, "OUTLINE", 0, 0, 0, 2, -2)

	-- subzone text
	SetFont(SubZoneTextString, FONT1, 24, "OUTLINE", 0, 0, 0, 2, -2)

	-- pvp info text
	SetFont(PVPInfoTextString, FONT1, 22, "OUTLINE", 0, 0, 0, 2, -2)

	-- pvp arena text
	SetFont(PVPArenaTextString, FONT1, 22, "OUTLINE", 0, 0, 0, 2, -2)

	-- error GameFontNormal:GetFont()
	SetFont(ErrorFont, FONT1, 16, "OUTLINE", 0, 0, 0, 2, -2)

	-- raid warning
	-- RaidNotice_AddMessage( RaidWarningFrame, "Raid Warning Message!", ChatTypeInfo["RAID_WARNING"] )
	local _, size = GameFontNormalHuge:GetFont()
	SetFont(RaidWarningFrameSlot1, FONT1, size, "OUTLINE", 0, 0, 0, 2, -2)
	SetFont(RaidWarningFrameSlot2, FONT1, size, "OUTLINE", 0, 0, 0, 2, -2)

	-- raid boss emote
	-- RaidNotice_AddMessage( RaidBossEmoteFrame, "Raid Boss Emote Message!", ChatTypeInfo["RAID_BOSS_EMOTE"] )
	SetFont(RaidBossEmoteFrameSlot1, FONT1, size, "OUTLINE", 0, 0, 0, 2, -2)
	SetFont(RaidBossEmoteFrameSlot2, FONT1, size, "OUTLINE", 0, 0, 0, 2, -2)

	-- watch frame
	hooksecurefunc("WatchFrame_Update", function()
		SetFont(WatchFrameTitle, FONT2, 14)
		nextline = 1
		for i = nextline, 50 do
			line = _G["WatchFrameLine"..i]
			if line then
				SetFont(line.text, FONT2, 12)
				SetFont(line.dash, FONT2, 12)
			else
				nextline = i	-- so we only have to change new lines during the hook
				break
			end
		end
	end)

	-- world state frame
	hooksecurefunc("WorldStateAlwaysUpFrame_Update", function()
		for i=1, NUM_ALWAYS_UP_UI_FRAMES do
			text = _G["AlwaysUpFrame"..i.."Text"]
			SetFont(text, FONT2, 10)
		end
	end)

	-- auto follow status
	SetFont(AutoFollowStatusText, FONT1, 14)

end

local function StyleMirrorTimerBars()
	local frame, name, text, statusBar, border, fontHeight, fontFlags, _
	local icon, height
	for i = 1, MIRRORTIMER_NUMTIMERS do
		frame = _G["MirrorTimer"..i]
		name = frame:GetName()
		text = _G[name.."Text"]
		border = _G[name.."Border"]
		statusBar  = _G[name.."StatusBar"]

		_, fontHeight, fontFlags = text:GetFont()
		text:SetFont(FONT2, fontHeight, fontFlags)
		text:ClearAllPoints()
		text:SetPoint("CENTER", statusBar, 0, 0)
		border:SetTexture(BORDERTEXTURE)
		border:ClearAllPoints()
		border:SetPoint("TOPLEFT", statusBar, -2, 2)
		border:SetPoint("BOTTOMRIGHT", statusBar, 2, -2)
		statusBar:SetStatusBarTexture(BARTEXTURE)

		icon = frame:CreateTexture(name.."Icon", "OVERLAY")
		height = border:GetHeight()
		icon:SetSize(height, height)
		icon:SetPoint("LEFT", statusBar, "RIGHT", 5, 0)
		frame.icon = icon

		frame:HookScript("OnShow", function(self)
			local icon = self.icon
			icon:SetTexture(mirrorIcons[(_G[self:GetName().."Text"]):GetText()])
			icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			icon:Show()
		end)

		frame:HookScript("OnHide", function(self)
			self.icon:Hide()
		end)

	end
end

ChangeFonts()
StyleMirrorTimerBars()
