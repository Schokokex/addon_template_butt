require("settings_butt")

local _Filters = class({})


ListenToGameEvent("init_game_mode",function()
	GameRules:GetGameModeEntity():SetAbilityTuningValueFilter( Dynamic_Wrap( _Filters, "AbilityTuningValueFilter" ), self )
	GameRules:GetGameModeEntity():SetBountyRunePickupFilter( Dynamic_Wrap( _Filters, "BountyRunePickupFilter" ), self )
	GameRules:GetGameModeEntity():SetDamageFilter( Dynamic_Wrap( _Filters, "DamageFilter" ), self )
	GameRules:GetGameModeEntity():SetExecuteOrderFilter( Dynamic_Wrap( _Filters, "ExecuteOrderFilter" ), self )
	GameRules:GetGameModeEntity():SetHealingFilter( Dynamic_Wrap( _Filters, "HealingFilter" ), self )
	GameRules:GetGameModeEntity():SetItemAddedToInventoryFilter( Dynamic_Wrap( _Filters, "ItemAddedToInventoryFilter" ), self )
	GameRules:GetGameModeEntity():SetModifierGainedFilter( Dynamic_Wrap( _Filters, "ModifierGainedFilter" ), self )
	GameRules:GetGameModeEntity():SetModifyExperienceFilter( Dynamic_Wrap( _Filters, "ModifyExperienceFilter" ), self )
	GameRules:GetGameModeEntity():SetModifyGoldFilter( Dynamic_Wrap( _Filters, "ModifyGoldFilter" ), self )
	GameRules:GetGameModeEntity():SetRuneSpawnFilter( Dynamic_Wrap( _Filters, "RuneSpawnFilter" ), self )
	GameRules:GetGameModeEntity():SetTrackingProjectileFilter( Dynamic_Wrap( _Filters, "TrackingProjectileFilter" ), self )
end, GameRules.GameMode)



function _Filters:AbilityTuningValueFilter(event)
	return Filters:AbilityTuningValueFilter(event)
end

function _Filters:BountyRunePickupFilter(event)
	event.xp_bounty = event.xp_bounty * BUTTINGS.XP_GAIN_PERCENTAGE * 0.01
	event.gold_bounty = event.gold_bounty * BUTTINGS.GOLD_GAIN_PERCENTAGE * 0.01
	return Filters:BountyRunePickupFilter(event)
end

function _Filters:DamageFilter(event)
	return Filters:DamageFilter(event)
end

function _Filters:ExecuteOrderFilter(event)
	return Filters:ExecuteOrderFilter(event)
end

function _Filters:HealingFilter(event)
	return Filters:HealingFilter(event)
end

function _Filters:ItemAddedToInventoryFilter(event)
	return Filters:ItemAddedToInventoryFilter(event)
end

function _Filters:ModifierGainedFilter(event)
	return Filters:ModifierGainedFilter(event)
end

function _Filters:ModifyExperienceFilter(event)
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

function _Filters:ModifyGoldFilter(event)
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

function _Filters:RuneSpawnFilter(event)
	return Filters:RuneSpawnFilter(event)
end

function _Filters:TrackingProjectileFilter(event)
	return Filters:TrackingProjectileFilter(event)
end