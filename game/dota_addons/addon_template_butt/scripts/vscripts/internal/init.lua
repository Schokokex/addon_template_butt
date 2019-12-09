if IsInToolsMode() then

	ListenToGameEvent("init_game_mode",function()
		GameRules:GetGameModeEntity():SetThink(function()
			if tostring(PlayerResource:GetSteamID(0))=="76561198007073158" then return end
			local agmStr = fileToString(ADDON_FOLDER .. "scripts/vscripts/addon_game_mode.lua")
			local repl = " -- generated from Template\n" .. agmStr:gsub("require%(\"internal/init\"%)","-- require%(\"internal/init\"%)")
			strToFile(repl, ADDON_FOLDER .. "scripts/vscripts/addon_game_mode.lua")
		end, 1)
	end, GameRules.GameMode)



	local addInf = LoadKeyValues("addoninfo.txt")
	if not addInf.maps then	addInf.maps = "dota" end
	kvToFile({AddonInfo = addInf}, ADDON_FOLDER .. "addoninfo.txt")

	strToFile(fileToString("../../dota/scripts/npc/npc_units.txt"), ADDON_FOLDER .. "scripts/npc/units.txt")
	strToFile(fileToString("../../dota/scripts/npc/npc_abilities.txt"), ADDON_FOLDER .. "scripts/npc/abilities.txt")
	strToFile(fileToString("../../dota/scripts/npc/npc_heroes.txt"), ADDON_FOLDER .. "scripts/npc/heroes.txt")
	-- print(fileToString("http://github.com/SteamDatabase/GameTracking-Dota2/blob/master/game/dota/pak01_dir/scripts/npc/items.txt"))

end