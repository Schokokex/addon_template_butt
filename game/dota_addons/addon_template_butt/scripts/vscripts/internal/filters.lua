require("settings_butt")

local InternalFilters = class({})


ListenToGameEvent("init_game_mode",function()
	print("sad")
	GameRules:GetGameModeEntity():SetAbilityTuningValueFilter( Dynamic_Wrap( InternalFilters, "AbilityTuningValueFilter" ), self )
	GameRules:GetGameModeEntity():SetBountyRunePickupFilter( Dynamic_Wrap( InternalFilters, "BountyRunePickupFilter" ), self )
	GameRules:GetGameModeEntity():SetDamageFilter( Dynamic_Wrap( InternalFilters, "DamageFilter" ), self )
	GameRules:GetGameModeEntity():SetExecuteOrderFilter( PrintTable, self )
	GameRules:GetGameModeEntity():SetHealingFilter( Dynamic_Wrap( InternalFilters, "HealingFilter" ), self )
	GameRules:GetGameModeEntity():SetItemAddedToInventoryFilter( Dynamic_Wrap( InternalFilters, "ItemAddedToInventoryFilter" ), self )
	GameRules:GetGameModeEntity():SetModifierGainedFilter( Dynamic_Wrap( InternalFilters, "ModifierGainedFilter" ), self )
	GameRules:GetGameModeEntity():SetModifyExperienceFilter( Dynamic_Wrap( InternalFilters, "ModifyExperienceFilter" ), self )
	GameRules:GetGameModeEntity():SetModifyGoldFilter( Dynamic_Wrap( InternalFilters, "ModifyGoldFilter" ), self )
	GameRules:GetGameModeEntity():SetRuneSpawnFilter( Dynamic_Wrap( InternalFilters, "RuneSpawnFilter" ), self )
	GameRules:GetGameModeEntity():SetTrackingProjectileFilter( Dynamic_Wrap( InternalFilters, "TrackingProjectileFilter" ), self )
end, GameRules.GameMode)



function InternalFilters:AbilityTuningValueFilter(event)
	return Filters:AbilityTuningValueFilter(event)
end

function InternalFilters:BountyRunePickupFilter(event)
	event.xp_bounty = event.xp_bounty * BUTTINGS.XP_GAIN_PERCENTAGE * 0.01
	event.gold_bounty = event.gold_bounty * BUTTINGS.GOLD_GAIN_PERCENTAGE * 0.01
	return Filters:BountyRunePickupFilter(event)
end

function InternalFilters:DamageFilter(event)
	print("DamageFilter")
	return Filters:DamageFilter(event)
end

function InternalFilters:ExecuteOrderFilter(event)
	print("ExecuteOrderFilter")
	return Filters:ExecuteOrderFilter(event)
end

function InternalFilters:HealingFilter(event)
	return Filters:HealingFilter(event)
end

function InternalFilters:ItemAddedToInventoryFilter(event)
	return Filters:ItemAddedToInventoryFilter(event)
end

function InternalFilters:ModifierGainedFilter(event)
	print("ModifierGainedFilter")
	return Filters:ModifierGainedFilter(event)
end

function InternalFilters:ModifyExperienceFilter(event)
	event.experience = event.experience * BUTTINGS.XP_GAIN_PERCENTAGE * 0.01

	-- ##
	local out = Filters:ModifyExperienceFilter(event)
	-- ##

	local teamHeroes = PlayerResourceButt:GetMainFriendlyHeroes(event.player_id_const)
	teamHeroes[event.player_id_const] = nil
	local count = length(teamHeroes)

	local singleAmt = event.experience * BUTTINGS.SHARED_XP_PERCENTAGE * 0.01 / count
	singleAmt = math.floor(singleAmt + 0.5)

	for h,hero in pairs(teamHeroes) do
		event.experience = event.experience - singleAmt
		hero:AddExperience(singleAmt, DOTA_ModifyXP_Unspecified, false, true)
	end

	return out
end

function InternalFilters:ModifyGoldFilter(event)
	event.gold = event.gold * BUTTINGS.GOLD_GAIN_PERCENTAGE * 0.01

	-- ##
	local out = Filters:ModifyGoldFilter(event) 
	-- ##

	local teamPlayers = PlayerResourceButt:GetFriendlyPlayers(event.player_id_const)
	teamPlayers[event.player_id_const] = nil
	local count = length(teamPlayers)

	local singleAmt = event.gold * BUTTINGS.SHARED_GOLD_PERCENTAGE * 0.01 / count
	singleAmt = math.floor(singleAmt + 0.5)

	for tp,tPlayer in pairs(teamPlayers) do
		event.gold = event.gold - singleAmt
		PlayerResource:ModifyGold(tp,singleAmt,(1 == event.reliable),DOTA_ModifyGold_SharedGold)
	end

	return out
end

function InternalFilters:RuneSpawnFilter(event)
	return Filters:RuneSpawnFilter(event)
end

function InternalFilters:TrackingProjectileFilter(event)
	return Filters:TrackingProjectileFilter(event)
end