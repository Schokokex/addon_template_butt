local spawnedNPCs = {}
ListenToGameEvent("npc_spawned", function(keys)
	-- entindex numbers repeat after a while 
	local npc = EntIndexToHScript(keys.entindex)
	if (spawnedNPCs[keys.entindex] ~= npc) then
		spawnedNPCs[keys.entindex] = npc
		FireGameEvent("npc_first_spawn", {entindex = keys.entindex, unit = npc})
	end
end, nil)

local l1 = 0
local l2 = 0
local function fireGME()
	local gME = GameRules:GetGameModeEntity()
	if (gME) then 									-- comes with the first Buildings
		FireGameEvent("created_game_mode_entity", {gameModeEntity = gME})
		StopListeningToGameEvent(l1)
		StopListeningToGameEvent(l2)
	end
end
l1 = ListenToGameEvent("npc_spawned", fireGME, nil)
l2 = ListenToGameEvent("game_rules_state_change", fireGME, nil) -- backup

function HUDError(message, playerID)
	if ("number"==type(playerID)) then
		CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(playerID), "dota_hud_error_message_player", {splitscreenplayer= 0, reason= 80, message= message})
	else
		CustomGameEventManager:Send_ServerToAllClients("dota_hud_error_message_player", {splitscreenplayer= 0, reason= 80, message= "All Players: "..message})
	end
end
