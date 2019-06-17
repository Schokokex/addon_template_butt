BUTTINGS = {
	-- cleaned up Version by Schokokeks

	GAME_TITLE = "Dota 2 but...",	-- change me! :) :)

	GAME_MODE = "AR", -- "AR" "AP" 
	ALLOW_SAME_HERO_SELECTION = 0,
	HERO_BANNING = 1,
	USE_BOTS = 0, -- TODO
	MAX_LEVEL = 25,

	UNIVERSAL_SHOP_MODE = 1,
	COOLDOWN_PERCENTAGE = 100,
	GOLD_GAIN_PERCENTAGE = 150,
	GOLD_PER_MINUTE = 90,
	RESPAWN_TIME_PERCENTAGE = 60,
	XP_GAIN_PERCENTAGE = 150,

	TOMBSTONE = 1,
	CLASSIC_ARMOR = 1,
	NO_UPHILL_MISS = 1,
	FREE_COURIER = 1,
	XP_PER_MINUTE = 90,
	COMEBACK_TIMER = 30,
	COMEBACK_GPM = 50,
	COMEBACK_XPPM = 50,
	SHARED_GOLD_PERCENTAGE = 15,
	SHARED_XP_PERCENTAGE = 15,

	ALT_WINNING = 1,
	ALT_KILL_LIMIT = 100,
	ALT_TIME_LIMIT = 60,

}

function SETMAXLEVEL(level)
	local ALTERNATIVE_XP_TABLE = {
		0,
		240,
		600,
		1080,
		1680,
		2300,
		2940,
		3600,
		4280,
		5080,
		5900,
		6740,
		7640,
		8865,
		10115,
		11390,
		12690,
		14015,
		15415,
		16905,
		18505,
		20405,
		22605,
		25105,
		27800,
	} for i = #ALTERNATIVE_XP_TABLE + 1, level do ALTERNATIVE_XP_TABLE[i] = ALTERNATIVE_XP_TABLE[i - 1] + (300 * ( i - 15 )) end
	local USE_CUSTOM_HERO_LEVELS = (level~=25)					
	local USE_CUSTOM_XP_VALUES = (level~=25)
	
	GameRules:GetGameModeEntity():SetCustomXPRequiredToReachNextLevel( ALTERNATIVE_XP_TABLE )
	GameRules:GetGameModeEntity():SetUseCustomHeroLevels(USE_CUSTOM_HERO_LEVELS)
	GameRules:SetUseCustomHeroXPValues(USE_CUSTOM_XP_VALUES)
	GameRules:GetGameModeEntity():SetCustomHeroMaxLevel(MAX_LEVEL)
end

BUTTINGS_DEFAULT = table.copy(BUTTINGS)