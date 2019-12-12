require("settings_butt")

_G.Filters = class({})

-- called from internal/filters

function Filters:AbilityTuningValueFilter(event)
	-- called on most abilities for each value
	-- PrintTable(event)
	local ability = EntIndexToHScript(event.entindex_ability_const)
	local casterUnit = EntIndexToHScript(event.entindex_caster_const)
	local valueName = event.value_name_const -- e.g. duration or area_of_affect
	local value = event.value -- can not get modified with local

	return true
end

function Filters:BountyRunePickupFilter(event)
	-- PrintTable(event)
	local playerID = event.player_id_const
	local xp = event.xp_bounty -- can not get modified with local
	local gold = event.gold_bounty -- can not get modified with local

	local heroUnit = playerID and PlayerResource:GetSelectedHeroEntity(playerID)

	-- your stuff

	return true
end

function Filters:DamageFilter(event)
	-- PrintTable(event)
	local attackerUnit = EntIndexToHScript(event.entindex_attacker_const)
	local victimUnit = EntIndexToHScript(event.entindex_victim_const)
	local damageType = event.damagetype_const
	local damage = event.damage -- can not get modified with local

	-- your stuff

	return true
end

function Filters:ExecuteOrderFilter(event)
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

function Filters:HealingFilter(event)
	-- PrintTable(event)
	local targetUnit = EntIndexToHScript(event.entindex_target_const)
	local heal = event.heal -- can not get modified with local

	-- your stuff
	
	return true
end

function Filters:ItemAddedToInventoryFilter(event)
	-- PrintTable(event)
	local inventory = EntIndexToHScript(event.inventory_parent_entindex_const)
	local item = EntIndexToHScript(event.item_entindex_const)
	local itemParent = EntIndexToHScript(event.item_parent_entindex_const)
	local sugg = event.suggested_slot

	-- your stuff
	
	return true
end

function Filters:ModifierGainedFilter(event)
	PrintTable(event)
	local name = event.name_const
	local duration = event.duration -- can not get modified with local
	local casterUnit = EntIndexToHScript(event.entindex_caster_const)
	local parentUnit = EntIndexToHScript(event.entindex_parent_const)

	-- your stuff
	
	return true
end

function Filters:ModifyExperienceFilter(event)
	-- PrintTable(event)
	local playerID = event.player_id_const
	local reason = event.reason_const
	local xp = event.experience -- can not get modified with local

	local heroUnit = playerID and PlayerResource:GetSelectedHeroEntity(playerID)
	
	-- your stuff

	return true
end

function Filters:ModifyGoldFilter(event)

	-- PrintTable(event) 
	local playerID = event.player_id_const
	local reason = event.reason_const
	local gold = event.gold -- can not get modified with local
	local reliable = event.reliable -- can not get modified with local
	
	local heroUnit = playerID and PlayerResource:GetSelectedHeroEntity(playerID)

	--your stuff

	return true
end


function Filters:RuneSpawnFilter(event)
	-- PrintTable(event)
	-- maybe deprecated? 
	return true
end

function Filters:TrackingProjectileFilter(event)
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
