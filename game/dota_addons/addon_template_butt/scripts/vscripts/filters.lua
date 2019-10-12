require("settings_butt")

function GameMode:LoadFilters()
	GameRules:GetGameModeEntity():SetAbilityTuningValueFilter( Dynamic_Wrap( GameMode, "AbilityTuningValueFilter" ), self )
	GameRules:GetGameModeEntity():SetBountyRunePickupFilter( Dynamic_Wrap( GameMode, "BountyRunePickupFilter" ), self )
	GameRules:GetGameModeEntity():SetDamageFilter( Dynamic_Wrap( GameMode, "DamageFilter" ), self )
	GameRules:GetGameModeEntity():SetExecuteOrderFilter( Dynamic_Wrap( GameMode, "ExecuteOrderFilter" ), self )
	GameRules:GetGameModeEntity():SetHealingFilter( Dynamic_Wrap( GameMode, "HealingFilter" ), self )
	GameRules:GetGameModeEntity():SetItemAddedToInventoryFilter( Dynamic_Wrap( GameMode, "ItemAddedToInventoryFilter" ), self )
	GameRules:GetGameModeEntity():SetModifierGainedFilter( Dynamic_Wrap( GameMode, "ModifierGainedFilter" ), self )
	GameRules:GetGameModeEntity():SetModifyExperienceFilter( Dynamic_Wrap( GameMode, "ModifyExperienceFilter" ), self )
	GameRules:GetGameModeEntity():SetModifyGoldFilter( Dynamic_Wrap( GameMode, "ModifyGoldFilter" ), self )
	GameRules:GetGameModeEntity():SetRuneSpawnFilter( Dynamic_Wrap( GameMode, "RuneSpawnFilter" ), self )
	GameRules:GetGameModeEntity():SetTrackingProjectileFilter( Dynamic_Wrap( GameMode, "TrackingProjectileFilter" ), self )
end

function GameMode:AbilityTuningValueFilter(event)
	-- called on most abilities for each value
	-- PrintTable(event)
	local ability = EntIndexToHScript(event.entindex_ability_const)
	local casterUnit = EntIndexToHScript(event.entindex_caster_const)
	local valueName = event.value_name_const -- e.g. duration or area_of_affect
	local value = event.value -- can not get modified with local

	return true
end

function GameMode:BountyRunePickupFilter(event)
	event.xp_bounty = event.xp_bounty * BUTTINGS.XP_GAIN_PERCENTAGE * 0.01
	event.gold_bounty = event.gold_bounty * BUTTINGS.GOLD_GAIN_PERCENTAGE * 0.01

	-- PrintTable(event)
	local playerID = event.player_id_const
	local xp = event.xp_bounty -- can not get modified with local
	local gold = event.gold_bounty -- can not get modified with local

	local heroUnit = playerID and PlayerResource:GetSelectedHeroEntity(playerID)

	-- your stuff

	return true
end

function GameMode:DamageFilter(event)
	-- PrintTable(event)
	local attackerUnit = EntIndexToHScript(event.entindex_attacker_const)
	local victimUnit = EntIndexToHScript(event.entindex_victim_const)
	local damageType = event.damagetype_const
	local damage = event.damage -- can not get modified with local

	-- your stuff

	return true
end

function GameMode:ExecuteOrderFilter(event)
	-- PrintTable(event)
	local ability = EntIndexToHScript(event.entindex_ability)
	local targetUnit = EntIndexToHScript(event.entindex_target)
	local playerID = event.issuer_player_id_const
	local orderType = event.order_type
	local pos = Vector(event.position_x,event.position_y,event.position_z)
	local queue = event.queue
	local seqNum = event.sequence_number_const
	local units = event.units
	local unit = units and units["0"] and EntIndexToHScript(units["0"])

	-- your stuff

	return true
end

function GameMode:HealingFilter(event)
	-- PrintTable(event)
	local targetUnit = EntIndexToHScript(event.entindex_target_const)
	local heal = event.heal -- can not get modified with local

	-- your stuff
	
	return true
end

function GameMode:ItemAddedToInventoryFilter(event)
	-- PrintTable(event)
	local inventory = EntIndexToHScript(event.inventory_parent_entindex_const)
	local item = EntIndexToHScript(event.item_entindex_const)
	local itemParent = EntIndexToHScript(event.item_parent_entindex_const)
	local sugg = event.suggested_slot

	-- your stuff
	
	return true
end

function GameMode:ModifierGainedFilter(event)
	-- PrintTable(event)
	local name = event.name_const
	local duration = event.duration -- can not get modified with local
	local casterUnit = EntIndexToHScript(event.entindex_caster_const)
	local parentUnit = EntIndexToHScript(event.entindex_parent_const)

	-- your stuff
	
	return true
end

function GameMode:ModifyExperienceFilter(event)
	event.experience = event.experience * BUTTINGS.XP_GAIN_PERCENTAGE * 0.01

	-- PrintTable(event)
	local playerID = event.player_id_const
	local reason = event.reason_const
	local xp = event.experience -- can not get modified with local

	local heroUnit = playerID and PlayerResource:GetSelectedHeroEntity(playerID)
	
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

	-- PrintTable(event) 
	local playerID = event.player_id_const
	local reason = event.reason_const
	local gold = event.gold -- can not get modified with local
	local reliable = event.reliable -- can not get modified with local
	
	local heroUnit = playerID and PlayerResource:GetSelectedHeroEntity(playerID)

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
	-- PrintTable(event)
	-- maybe deprecated? 
	return true
end

function GameMode:TrackingProjectileFilter(event)
	-- PrintTable(event)
	local dodgeable = event.dodgeable
	local ability = EntIndexToHScript(event.entindex_ability_const)
	local attackerUnit = EntIndexToHScript(event.entindex_source_const)
	local targetUnit = EntIndexToHScript(event.entindex_target_const)
	local expireTime = event.expire_time
	local isAttack = (1==event.is_attack)
	local maxImpactTime = event.max_impact_time
	local moveSpeed = event.move_speed -- can not get modified with local

	return true
end
