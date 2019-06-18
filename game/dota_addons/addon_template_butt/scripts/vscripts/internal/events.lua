require("settings")

ListenToGameEvent("game_rules_state_change", function()
	if (GameRules:State_Get()==DOTA_GAMERULES_STATE_HERO_SELECTION) then
		
		GameRules:SetSameHeroSelectionEnabled( 1 == BUTTINGS.ALLOW_SAME_HERO_SELECTION )
		GameRules:SetUseUniversalShopMode( 1 == BUTTINGS.UNIVERSAL_SHOP_MODE )
		GameRules:SetGoldTickTime( 60/BUTTINGS.GOLD_PER_MINUTE )

		
		GameRules:GetGameModeEntity():SetCustomXPRequiredToReachNextLevel( BUTTINGS.ALTERNATIVE_XP_TABLE() )
		GameRules:GetGameModeEntity():SetUseCustomHeroLevels(BUTTINGS.MAX_LEVEL~=25)
		GameRules:SetUseCustomHeroXPValues(BUTTINGS.MAX_LEVEL~=25)
		GameRules:GetGameModeEntity():SetCustomHeroMaxLevel(BUTTINGS.MAX_LEVEL)

		if ("AR"==BUTTINGS.GAME_MODE) then
			local time = (BUTTINGS.HERO_BANNING) and 16 or 0
			GameRules:GetGameModeEntity():SetThink( function()
				for p,player in pairs(PlayerList:GetValidTeamPlayers()) do
					player:MakeRandomHeroSelection()
				end
			end, time)
		end
	elseif (GameRules:State_Get()==DOTA_GAMERULES_STATE_PRE_GAME) then
		if (1==BUTTINGS.FREE_COURIER) then TeamList:GetFreeCouriers() end
	end
end, nil)

if (1==BUTTINGS.ALT_WINNING) then
	ListenToGameEvent("dota_player_killed",function(kv)
		-- local unit = PlayerResource:GetSelectedHeroEntity(kv.PlayerID)
		for _,t in ipairs(TeamList:GetPlayableTeams()) do
			if (PlayerResource:GetTeamKills(t)>=BUTTINGS.ALT_KILL_LIMIT) then
				GameRules:SetGameWinner(t)
			end
		end
	end, nil)
end

if (1==BUTTINGS.TOMBSTONE) then
	ListenToGameEvent("entity_killed", function(keys)
		local killedUnit = EntIndexToHScript(keys.entindex_killed)
		if killedUnit:IsRealHero() and not killedUnit:IsTempestDouble() and not killedUnit:IsReincarnating() then
			local tombstoneItem = CreateItem("item_tombstone", killedUnit, killedUnit)
			if (tombstoneItem) then
				local tombstone = SpawnEntityFromTableSynchronous("dota_item_tombstone_drop", {})
				tombstone:SetContainedItem(tombstoneItem)
				tombstone:SetAngles(0, RandomFloat(0, 360), 0)
				FindClearSpaceForUnit(tombstone, killedUnit:GetAbsOrigin(), true)
			end
		end
	end, nil)
end