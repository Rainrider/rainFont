--[[ CONFIG ]]--
local FONT1 = GameFontNormal:GetFont()
local FONT2 = GameFontNormal:GetFont()
local FONTSIZE = 24 -- only for incoming events
--[[ END OF CONFIG ]]--

local function SetFont(obj, font, size, style, sr, sg, sb, sox, soy)
	obj:SetFont(font, size, style)
	if sr and sg and sb then
		obj:SetShadowColor(sr, sg, sb)
	end
	if sox and soy then
		obj:SetShadowOffset(sox, soy)
	end
end

local function rainSet()
	DAMAGE_TEXT_FONT = FONT1
	COMBAT_TEXT_HEIGHT = FONTSIZE
	UNIT_NAME_FONT = FONT1
	-- NAMEPLATE_FONT = FONT1
	
	-- combat text (inherits from SystemFont_Shadow_Huge3)
	local _, _, fFlags = CombatTextFont:GetFont()
	SetFont(CombatTextFont, FONT1, FONTSIZE, fFlags, 0, 0, 0, 2, -2)

	-- zone text (inherits from SystemFont_OutlineThick_WTF)
	SetFont(ZoneTextFont, FONT1, 30, "OUTLINE", 0, 0, 0, 2, -2)

	-- subzone text (inherits from SystemFont_OutlineThick_Huge4)
	SetFont(SubZoneTextFont, FONT1, 24, "OUTLINE", 0, 0, 0, 2, -2) 

	-- pvp info text (conquested/sanctuary) (inherits from SystemFont_OutlineThick_Huge2)
	SetFont(PVPInfoTextFont, FONT1, 22, "OUTLINE", 0, 0, 0, 2, -2)

	-- error GameFontNormal:GetFont() (inherits from GameFontNormalLarge)
	SetFont(ErrorFont, FONT1, 16, "OUTLINE", 0, 0, 0, 2, -2)
    
    -- boss emotes (inherits from SystemFont_Shadow_Huge3)
	SetFont(BossEmoteNormalHuge, FONT1, 16, "OUTLINE", 0, 0, 0, 2, -2)
    
    -- raid warning (inherits from SystemFont_Shadow_Huge1)
    local _, size, _ = GameFontNormalHuge:GetFont()
    SetFont(GameFontNormalHuge, FONT1, size, "OUTLINE", 0, 0, 0, 2, -2)
    
    -- watch frame
    hooksecurefunc("WatchFrame_Update", function()
		SetFont(WatchFrameTitle, FONT2, 14, nil)
		nextline = 1
		for i = nextline, 50 do
			line = _G["WatchFrameLine"..i]
			if line then
				SetFont(line.text, FONT2, 12, nil)
				SetFont(line.dash, FONT2, 12, nil)
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
	      SetFont(text, FONT2, 10, nil)
        end
    end)

    -- auto follow status
    SetFont(AutoFollowStatusText, FONT1, 14, nil)

end

rainSet()
