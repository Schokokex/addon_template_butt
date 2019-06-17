require("settings")

function GameMode:LoadFilters()
	GameRules:GetGameModeEntity():SetAbilityTuningValueFilter( Dynamic_Wrap( GameMode, "AbilityTuningValueFilter" ), self )
	GameRules:GetGameModeEntity():SetBountyRunePickupFilter( Dynamic_Wrap( GameMode, "BountyRunePickupFilter" ), self )
	GameRules:GetGameModeEntity():SetDamageFilter( Dynamic_Wrap( GameMode, "DamageFilter" ), self )
	GameRules:GetGameModeEntity():SetExecuteOrderFilter( Dynamic_Wrap( GameMode, "ExecuteOrderFilter" ), self )
	GameRules:GetGameModeEntity():SetItemAddedToInventoryFilter( Dynamic_Wrap( GameMode, "ItemAddedToInventoryFilter" ), self )
	GameRules:GetGameModeEntity():SetModifierGainedFilter( Dynamic_Wrap( GameMode, "ModifierGainedFilter" ), self )
	GameRules:GetGameModeEntity():SetModifyExperienceFilter( Dynamic_Wrap( GameMode, "ModifyExperienceFilter" ), self )
	GameRules:GetGameModeEntity():SetModifyGoldFilter( Dynamic_Wrap( GameMode, "ModifyGoldFilter" ), self )
	GameRules:GetGameModeEntity():SetRuneSpawnFilter( Dynamic_Wrap( GameMode, "RuneSpawnFilter" ), self )
	GameRules:GetGameModeEntity():SetTrackingProjectileFilter( Dynamic_Wrap( GameMode, "TrackingProjectileFilter" ), self )
end

function GameMode:AbilityTuningValueFilter(event)
	-- 	PrintTable(event)
	return true
end

function GameMode:BountyRunePickupFilter(event)
	event.xp_bounty = event.xp_bounty * BUTTINGS.XP_GAIN_PERCENTAGE * 0.01
	event.gold_bounty = event.gold_bounty * BUTTINGS.GOLD_GAIN_PERCENTAGE * 0.01
	-- PrintTable(event)
	return true
end

function GameMode:DamageFilter(event)
	-- PrintTable(event)
	return true
end

function GameMode:ExecuteOrderFilter(event)
	-- PrintTable(event)
	-- npc_dota_goodguys_healers
	return true
end

function GameMode:ItemAddedToInventoryFilter(event)
	-- 	PrintTable(event)
	return true
end

function GameMode:ModifierGainedFilter(event)
	-- 	PrintTable(event)
	return true
end

function GameMode:ModifyExperienceFilter(event)
	event.experience = event.experience * BUTTINGS.XP_GAIN_PERCENTAGE * 0.01
	-- PrintTable(event) -- event.experience
	-- local playerID = event.player_id_const
	-- local reason = event.reason_const

	-- your stuff
	-- your stuff


	do -- keep this bottom
		local teamHeroes = PlayerResourceButt:GetMainFriendlyHeroes(event.player_id_const)
		teamHeroes[event.player_id_const] = nil
		local count = length(teamHeroes)

		local singleAmt = event.experience * BUTTINGS.SHARED_XP_PERCENTAGE * 0.01 / count
		singleAmt = math.floor(singleAmt + 0.5)

		for h,hero in pairs(teamHeroes) do
			event.experience = event.experience - singleAmt
			hero:AddExperience(singleAmt, DOTA_ModifyXP_Unspecified, false, true)
		end
	end
	return true
end

function GameMode:ModifyGoldFilter(event)
	event.gold = event.gold * BUTTINGS.GOLD_GAIN_PERCENTAGE * 0.01
	-- PrintTable(event) -- event.gold
	-- local playerID = event.player_id_const
	-- local reliable = event.reliable
	-- local reason = event.reason_const
	


	--your stuff
	--your stuff


	
	do -- keep this bottom
		local teamPlayers = PlayerResourceButt:GetFriendlyPlayers(event.player_id_const)
		teamPlayers[event.player_id_const] = nil
		local count = length(teamPlayers)

		local singleAmt = event.gold * BUTTINGS.SHARED_GOLD_PERCENTAGE * 0.01 / count
		singleAmt = math.floor(singleAmt + 0.5)

		for tp,tPlayer in pairs(teamPlayers) do
			event.gold = event.gold - singleAmt
			PlayerResource:ModifyGold(tp,singleAmt,(1 == event.reliable),DOTA_ModifyGold_SharedGold)
		end
	end
	return true
end


function GameMode:RuneSpawnFilter(event)
	-- 	PrintTable(event)
	return true
end

function GameMode:TrackingProjectileFilter(event)
	-- PrintTable(event)
	return true
end