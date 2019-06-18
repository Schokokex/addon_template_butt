ListenToGameEvent("dota_player_killed",function(keys)
	for k,v in pairs(keys) do	print("dota_player_killed",k,v) end
	-- local unit = PlayerResource:GetSelectedHeroEntity(keys.PlayerID)
end, nil)

ListenToGameEvent("entity_killed", function(keys)
	local killedUnit = EntIndexToHScript(keys.entindex_killed)
	-- entity_killed	entindex_attacker	634
	-- entity_killed	entindex_killed	852
	-- entity_killed	damagebits	0
	-- entity_killed	splitscreenplayer	-1
	-- for k,v in pairs(keys) do	print("entity_killed",k,v) end
end, nil)

ListenToGameEvent("npc_spawned", function(keys)
	-- npc_spawned	entindex	621
	-- npc_spawned	splitscreenplayer	-1
	-- for k,v in pairs(keys) do	print("npc_spawned",k,v) end

end, nil)

ListenToGameEvent("entity_hurt", function(keys)
	-- entity_hurt	damagebits	0
	-- entity_hurt	entindex_killed	893
	-- entity_hurt	damage	18.807228088379
	-- entity_hurt	entindex_attacker	636
	-- entity_hurt	splitscreenplayer	-1
	-- for k,v in pairs(keys) do	print("entity_hurt",k,v) end

end, nil)

ListenToGameEvent("dota_player_gained_level", function(keys)
	for k,v in pairs(keys) do	print("dota_player_gained_level",k,v) end

end, nil)

ListenToGameEvent("dota_player_used_ability", function(keys)
	-- dota_player_used_ability	caster_entindex	465
	-- dota_player_used_ability	abilityname	item_courier
	-- dota_player_used_ability	PlayerID	0
	-- dota_player_used_ability	splitscreenplayer	-1
	-- for k,v in pairs(keys) do	print("dota_player_used_ability",k,v) end

end, nil)

ListenToGameEvent("player_shoot", function(keys)
	for k,v in pairs(keys) do	print("player_shoot",k,v) end

end, nil)

ListenToGameEvent("last_hit", function(keys)
	for k,v in pairs(keys) do	print("last_hit",k,v) end

end, nil)

ListenToGameEvent("dota_tower_kill", function(keys)
	for k,v in pairs(keys) do	print("dota_tower_kill",k,v) end

end, nil)
