function init()
	local gameModeEnt = GameRules:GetGameModeEntity()
	if (not gameModeEnt) then return Timers:CreateTimer({ useGameTime = false, endTime = 0.1, callback = init }) end

	GameRules:SetFirstBloodActive( true )
	GameRules:SetHeroRespawnEnabled( true )
	-- GameRules:SetHeroSelectionTime( 120 )
	GameRules:SetHideKillMessageHeaders( false )
	-- GameRules:SetPostGameTime( 60 )
	-- GameRules:SetPreGameTime( 30 )
	GameRules:SetRuneSpawnTime( 120 )
	GameRules:SetTreeRegrowTime( 300 )
	GameRules:SetUseBaseGoldBountyOnHeroes( true )

	gameModeEnt:SetAlwaysShowPlayerInventory( false ) -- Show the player hero's inventory in the HUD, regardless of what unit is selected. 
	-- gameModeEnt:SetAlwaysShowPlayerNames( false )
	gameModeEnt:SetAnnouncerDisabled( false )
	gameModeEnt:SetBotsAlwaysPushWithHuman( false )
	gameModeEnt:SetBotsInLateGame( true )
	gameModeEnt:SetBotsMaxPushTier( -1 )
	gameModeEnt:SetBotThinkingEnabled( true )
	gameModeEnt:SetBuybackEnabled( true )
	-- gameModeEnt:SetCameraDistanceOverride( 1134.0 )
	gameModeEnt:SetCustomBuybackCooldownEnabled( false )
	gameModeEnt:SetCustomBuybackCostEnabled( false )
	-- gameModeEnt:SetCustomGameForceHero( "npc_dota_hero_axe" )
	gameModeEnt:SetFixedRespawnTime( -1 ) 
	gameModeEnt:SetFogOfWarDisabled( false )
	gameModeEnt:SetFountainConstantManaRegen( -1 )
	gameModeEnt:SetFountainPercentageHealthRegen( -1 )
	gameModeEnt:SetFountainPercentageManaRegen( -1 )
	gameModeEnt:SetGoldSoundDisabled( false )
	gameModeEnt:SetLoseGoldOnDeath( true )
	-- gameModeEnt:SetMaximumAttackSpeed( 700 )
	-- gameModeEnt:SetMinimumAttackSpeed( 20 )
	gameModeEnt:SetPauseEnabled( true )
	gameModeEnt:SetRemoveIllusionsOnDeath( false )
	gameModeEnt:SetStashPurchasingDisabled( false )
	gameModeEnt:SetTopBarTeamValuesVisible( true )
	gameModeEnt:SetTowerBackdoorProtectionEnabled( true )
	gameModeEnt:SetUnseenFogOfWarEnabled( false )

	if false then
		gameModeEnt:SetUseDefaultDOTARuneSpawnLogic(false)
		gameModeEnt:SetRuneEnabled(DOTA_RUNE_DOUBLEDAMAGE, true)
		gameModeEnt:SetRuneEnabled(DOTA_RUNE_HASTE, true)
		gameModeEnt:SetRuneEnabled(DOTA_RUNE_ILLUSION, true)
		gameModeEnt:SetRuneEnabled(DOTA_RUNE_INVISIBILITY, true)
		--gameModeEnt:SetRuneEnabled(DOTA_RUNE_REGENERATION, true) doesnt work therefore always true
	end

	if false then
		SetTeamCustomHealthbarColor(DOTA_TEAM_GOODGUYS, 61, 210, 150 )	--	Teal
		SetTeamCustomHealthbarColor(DOTA_TEAM_BADGUYS, 243, 201, 9 )	--	Yellow
		SetTeamCustomHealthbarColor(DOTA_TEAM_CUSTOM_1, 197, 77, 168 )	--	Pink
		SetTeamCustomHealthbarColor(DOTA_TEAM_CUSTOM_2, 255, 108, 0 )	--	Orange
		SetTeamCustomHealthbarColor(DOTA_TEAM_CUSTOM_3, 52, 85, 255 )	--	Blue
		SetTeamCustomHealthbarColor(DOTA_TEAM_CUSTOM_4, 101, 212, 19 )	--	Green
		SetTeamCustomHealthbarColor(DOTA_TEAM_CUSTOM_5, 129, 83, 54 )	--	Brown
		SetTeamCustomHealthbarColor(DOTA_TEAM_CUSTOM_6, 27, 192, 216 )	--	Cyan
		SetTeamCustomHealthbarColor(DOTA_TEAM_CUSTOM_7, 199, 228, 13 )	--	Olive
		SetTeamCustomHealthbarColor(DOTA_TEAM_CUSTOM_8, 140, 42, 244 )	--	Purple
	end
end
init()