require("settings_butt")
require("internal/utils/butt_api")

_Thinker = class({})

ListenToGameEvent("game_rules_state_change", function()
	if (GameRules:State_Get()==DOTA_GAMERULES_STATE_GAME_IN_PROGRESS) then
		GameRules:GetGameModeEntity():SetThink( "ComebackXP", _Thinker, BUTTINGS.COMEBACK_TIMER*60 )
		GameRules:GetGameModeEntity():SetThink( "ComebackGold", _Thinker, BUTTINGS.COMEBACK_TIMER*60 )
		GameRules:GetGameModeEntity():SetThink( "XPThinker", _Thinker, 0 )
		GameRules:GetGameModeEntity():SetThink( "Outpost", _Thinker, 0 )
		GameRules:GetGameModeEntity():SetThink( "WinThinker", _Thinker, BUTTINGS.ALT_TIME_LIMIT*60 )
	end
end, self)

function _Thinker:ComebackXP()
	local team = 0
	local amt = nil
	for t,xp in pairs(TeamList:GetTotalEarnedXP()) do
		if (not amt) or (amt>xp) then
			team = t
			amt = xp
		end
	end
	for h,hero in pairs(HeroListButt:GetMainHeroesInTeam(team)) do
		hero:AddExperience(1, DOTA_ModifyXP_Unspecified, false, true)
	end
	return 60/BUTTINGS.COMEBACK_XPPM
end

function _Thinker:ComebackGold()
	local team = 0
	local amt = nil
	for t,gold in pairs(TeamList:GetTotalEarnedGold()) do
		if (not amt) or (amt>gold) then
			team = t
			amt = gold
		end
	end
	for p,player in pairs(PlayerList:GetPlayersInTeam(team)) do
		PlayerResource:ModifyGold(p, 1, false, DOTA_ModifyGold_GameTick) 
	end
	return 60/BUTTINGS.COMEBACK_GPM
end

function _Thinker:XPThinker()
	for h,hero in pairs(HeroListButt:GetMainHeroes()) do
		hero:AddExperience(1, DOTA_ModifyXP_Unspecified, false, true)
	end
	return 60/BUTTINGS.XP_PER_MINUTE
end

function _Thinker:WinThinker()
	if (1==BUTTINGS.ALT_WINNING) then
		local team = DOTA_TEAM_NOTEAM 
		local kills = 0
		for _,t in ipairs(TeamList:GetPlayableTeams()) do
			if (PlayerResource:GetTeamKills(t)>kills) then
				team = t
				kills = PlayerResource:GetTeamKills(t)
			end
		end
			GameRules:SetGameWinner(team)
	end
end

function _Thinker:Outpost()
	-- local delay = units.npc_dota_watch_tower and units.npc_dota_watch_tower.StartingTime or 600
	Butt:ProtectAllOutposts() -- protects all Outposts until 10:00
	-- refresh at 10:00 or new modifier
end