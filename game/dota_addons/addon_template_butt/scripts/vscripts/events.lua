ListenToGameEvent("dota_player_killed",function(keys)
	local playerID = keys.PlayerID
	local heroKill = keys.HeroKill
	local towerKill = keys.TowerKill
	-- for k,v in pairs(keys) do print("dota_player_killed",k,v) end
end, nil)

ListenToGameEvent("entity_killed", function(keys)
	local attackerUnit = keys.entindex_attacker and EntIndexToHScript(keys.entindex_attacker)
	local killedUnit = keys.entindex_killed and EntIndexToHScript(keys.entindex_killed)
	local damagebits = keys.damagebits -- This might always be 0 and therefore useless
	-- for k,v in pairs(keys) do	print("entity_killed",k,v) end
end, nil)

ListenToGameEvent("npc_spawned", function(keys)
	local spawnedUnit = keys.entindex and EntIndexToHScript(keys.entindex)
	-- for k,v in pairs(keys) do	print("npc_spawned",k,v) end

end, nil)

ListenToGameEvent("entity_hurt", function(keys)
	local damage = keys.damage
	local attackerUnit = keys.entindex_attacker and EntIndexToHScript(keys.entindex_attacker)
	local victimUnit = keys.entindex_killed and EntIndexToHScript(keys.entindex_killed)
	local damagebits = keys.damagebits -- This might always be 0 and therefore useless
	-- for k,v in pairs(keys) do print("entity_hurt",k,v) end

end, nil)

ListenToGameEvent("dota_player_gained_level", function(keys)
	local newLevel = keys.level
	local playerID = keys.player - 1 -- i guess
	-- for k,v in pairs(keys) do print("dota_player_gained_level",k,v) end
	
end, nil)

ListenToGameEvent("dota_player_used_ability", function(keys)
	local casterUnit = keys.caster_entindex and EntIndexToHScript(keys.caster_entindex)
	local abilityname = keys.abilityname
	local playerID = keys.PlayerID
	local player = keys.PlayerID and PlayerResource:GetPlayer(keys.PlayerID)
	-- local ability = casterUnit and casterUnit.FindAbilityByName and casterUnit:FindAbilityByName(abilityname) -- bugs if hero has 2 times the same ability
	-- for k,v in pairs(keys) do print("dota_player_used_ability",k,v) end

end, nil)

ListenToGameEvent("last_hit", function(keys)
	local killedUnit = keys.EntKilled and EntIndexToHScript(keys.EntKilled)
	local playerID = keys.PlayerID
	local firstBlood = keys.FirstBlood
	local heroKill = keys.HeroKill
	local towerKill = keys.TowerKill
	-- for k,v in pairs(keys) do print("last_hit",k,v) end

end, nil)

ListenToGameEvent("dota_tower_kill", function(keys)
	local gold = keys.gold
	local towerTeam = keys.teamnumber
	local killer_userid = keys.killer_userid
	-- for k,v in pairs(keys) do print("dota_tower_kill",k,v) end

end, nil)

------------------------------------------ example --------------------------------------------------

ListenToGameEvent("this_is_just_an_example", function(keys)
	local targetUnit = EntIndexToHScript(keys.entindex)

	local neighbours = FindUnitsInRadius(
		targetUnit:GetTeam(), -- int teamNumber, 
		targetUnit:GetAbsOrigin(), -- Vector position, 
		false, -- handle cacheUnit, 
		1000, -- float radius,
		DOTA_UNIT_TARGET_TEAM_FRIENDLY, -- int teamFilter, 
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_CREEP, -- int typeFilter, 
		DOTA_UNIT_TARGET_FLAG_NOT_ILLUSIONS + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE, -- int flagFilter, 
		FIND_ANY_ORDER, -- int order, 
		false -- bool canGrowCache
	)

	for u,neighUnit in pairs(neighbours) do

		ApplyDamage({
			victim = neighUnit,
			attacker = targetUnit,
			damage = 100,
			damage_type = DAMAGE_TYPE_MAGICAL,
			damage_flags = DOTA_DAMAGE_FLAG_NON_LETHAL,
			ability = nil
		})

		neighUnit:AddNewModifier(
			targetUnit, -- handle caster, 
			nil, -- handle optionalSourceAbility, 
			"someweirdmodifier", -- string modifierName, 
			{duration = 5} -- handle modifierData
		)

	end
end, nil)