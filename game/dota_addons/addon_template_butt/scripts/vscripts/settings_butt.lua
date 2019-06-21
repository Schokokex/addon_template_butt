
-- these will be the default settings shown on the team select screen
BUTTINGS = {
	-- cleaned up Version by Schokokeks

	GAME_TITLE = "Dota 2 but...",	-- change me! :) :)
	-- AR stands for All Random, every player will get a random hero
	-- AP is just All Pick, the default dota 2 style
	GAME_MODE = "AR", -- "AR" "AP"
	-- allow duplicate heroes or not
	ALLOW_SAME_HERO_SELECTION = 0,
	-- enable banning phase before picking
	HERO_BANNING = 1,
	-- autofill empty slots with bots, don't use it for now
	USE_BOTS = 0, -- TODO
	-- the max level a hero can reach
	MAX_LEVEL = 25,
	-- allow purchasing any item at any shop (secret/side/base)
	UNIVERSAL_SHOP_MODE = 1,
	-- scales all ability cooldowns
	COOLDOWN_PERCENTAGE = 100,
	-- scales gold gain
	GOLD_GAIN_PERCENTAGE = 150,
	-- base passive gold per minute
	GOLD_PER_MINUTE = 90,
	-- scales spawn time
	RESPAWN_TIME_PERCENTAGE = 60,
	-- scales experience gain
	XP_GAIN_PERCENTAGE = 150,
	-- killed heroes leave a tombstone, allies can join to channel to resurrect
	TOMBSTONE = 1,
	-- old armor formula for calculating damage reduction
	-- set this to 1, if your game mode will feature high amounts of armor or agility
	-- otherwise the physical resistance can go to 100% making things immune to physical damage
	CLASSIC_ARMOR = 1,
	-- removes uphill miss chance
	NO_UPHILL_MISS = 1,
	-- start the game with a free courier
	FREE_COURIER = 1,
	-- passive experience gain
	XP_PER_MINUTE = 90,
	COMEBACK_TIMER = 30,
	COMEBACK_GPM = 50,
	COMEBACK_XPPM = 50,
	SHARED_GOLD_PERCENTAGE = 15,
	SHARED_XP_PERCENTAGE = 15,
	-- enable alternative win-conditions
	ALT_WINNING = 1,
	-- game ends if one of the teams reach this amount of kills
	ALT_KILL_LIMIT = 100,
	-- games ends after this amount of minutes, highest kills win
	ALT_TIME_LIMIT = 60,

}

function BUTTINGS.ALTERNATIVE_XP_TABLE()
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
	} for i = #ALTERNATIVE_XP_TABLE + 1, BUTTINGS.MAX_LEVEL do ALTERNATIVE_XP_TABLE[i] = ALTERNATIVE_XP_TABLE[i - 1] + (300 * ( i - 15 )) end
	return ALTERNATIVE_XP_TABLE
end

BUTTINGS_DEFAULT = table.copy(BUTTINGS)
