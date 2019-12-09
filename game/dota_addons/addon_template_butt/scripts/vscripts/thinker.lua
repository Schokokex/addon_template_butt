GameMode.Thinker = class({})
local Thinker = GameMode.Thinker

ListenToGameEvent("game_rules_state_change", function()
	if (GameRules:State_Get()==DOTA_GAMERULES_STATE_GAME_IN_PROGRESS) then
		GameRules:GetGameModeEntity():SetThink( "Minute00", Thinker, 0 )
		GameRules:GetGameModeEntity():SetThink( "VeryVeryOften", Thinker, 0 )
		GameRules:GetGameModeEntity():SetThink( "VeryOften", Thinker, 0 )
		GameRules:GetGameModeEntity():SetThink( "Often", Thinker, 0 )
		GameRules:GetGameModeEntity():SetThink( "Regular", Thinker, 0 )
		GameRules:GetGameModeEntity():SetThink( "Seldom", Thinker, 0 )
		GameRules:GetGameModeEntity():SetThink( "DontForgetToSubscribe", Thinker, 20*60 )
		GameRules:GetGameModeEntity():SetThink( "LateGame", Thinker, 30*60 )
	end
end, GameMode)

function Thinker:Minute00()
	-- print("0:00")
end

function Thinker:DontForgetToSubscribe()
	-- print("20 minutes")
	return nil -- does not repeat
end

function Thinker:LateGame()
	-- print("30 minutes")
	return nil -- does not repeat
end

function Thinker:VeryVeryOften()
	-- print("every 10 seconds")
	return 10
end

function Thinker:VeryOften()
	-- print("every minute")
	return 1*60
end

function Thinker:Often()
	-- print("every 5 minutes")
	return 5*60
end

function Thinker:Regular()
	-- print("every 15 minutes")
	return 15*60
end

function Thinker:Seldom()
	-- print("every 30 minutes")
	return 30*60
end
