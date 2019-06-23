require("settings_butt")

CustomNetTables:SetTableValue("butt_settings", "default", BUTTINGS)

local l0 = CustomGameEventManager:RegisterListener("butt_setting_changed", function(_,kv)
	BUTTINGS[kv.setting] = kv.value
	print(kv.setting,":",kv.value)
end)

local l1 =ListenToGameEvent("game_rules_state_change", function()
	if (GameRules:State_Get()==DOTA_GAMERULES_STATE_HERO_SELECTION) then
		CustomNetTables:SetTableValue("butt_settings", "locked", BUTTINGS)
	end
end, nil)

local l2 = CustomGameEventManager:RegisterListener("butt_on_clicked", function(_,kv)
	local name = kv.button
	if ("RESET"==name) then
		-- BUTTINGS = table.copy(BUTTINGS_DEFAULT)
		for k,v in pairs(BUTTINGS_DEFAULT) do
			CustomGameEventManager:Send_ServerToAllClients("butt_setting_changed", {setting = k, value = v})
		end
	end
end)

---------------------------------------------------------------------------------

CustomGameEventManager:RegisterListener("endscreen_butt", function(_,request)
	local playerInfo = {}
	print("endscreen_butt requested")
	for k,v in pairs(request) do
		print("req",k,v,type(k))
		local pID = tonumber(k)
		if pID then
			-- print(pID,v.team)
			playerInfo[pID] = { team = v.team }
			playerInfo[pID].Kills = PlayerResource:GetKills(pID).." ("..PlayerResource:GetStreak(pID)..")"
			playerInfo[pID].Damage = PlayerResource:GetRawPlayerDamage(pID)
			playerInfo[pID].Healing = PlayerResource:GetHealing(pID)
			playerInfo[pID].LH = PlayerResource:GetLastHits(pID).." ("..PlayerResource:GetLastHitStreak(pID)..")"
			playerInfo[pID].GPM = math.floor(PlayerResource:GetGoldPerMin(pID)+0.5)
			playerInfo[pID].EPM = math.floor(PlayerResource:GetXPPerMin(pID)+0.5)
			playerInfo[pID].TotalXP = PlayerResource:GetTotalEarnedXP(pID)
			playerInfo[pID].DamageTaken = PlayerResource:GetCreepDamageTaken(pID) + PlayerResource:GetHeroDamageTaken(pID) + PlayerResource:GetTowerDamageTaken(pID)
			playerInfo[pID].GetGoldSpentOnItems = PlayerResource:GetGoldSpentOnItems(pID)
			playerInfo[pID].RunePickups = PlayerResource:GetRunePickups(pID)
		end
	end
	CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(request.PlayerID),"endscreen_butt",playerInfo)
end)