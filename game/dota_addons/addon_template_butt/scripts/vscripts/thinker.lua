ListenToGameEvent("game_rules_state_change", function()
	if (GameRules:State_Get()==DOTA_GAMERULES_STATE_GAME_IN_PROGRESS) then
		GameRules:GetGameModeEntity():SetThink( "VeryVeryOften", GameMode, 0 )
		GameRules:GetGameModeEntity():SetThink( "VeryOften", GameMode, 0 )
		GameRules:GetGameModeEntity():SetThink( "Often", GameMode, 0 )
		GameRules:GetGameModeEntity():SetThink( "Regular", GameMode, 0 )
		GameRules:GetGameModeEntity():SetThink( "Seldom", GameMode, 0 )
		GameRules:GetGameModeEntity():SetThink( "DontForgetToSubscribe", GameMode, 20*60 )
		GameRules:GetGameModeEntity():SetThink( "LateGame", GameMode, 30*60 )
	end
end, self)

function GameMode:DontForgetToSubscribe()
	-- print("20 minutes")
	return nil
end

function GameMode:LateGame()
	-- print("30 minutes")
	return nil
end

function GameMode:VeryVeryOften()
	-- print("every 10 seconds")
	return 10
end

function GameMode:VeryOften()
	-- print("every minute")
	return 1*60
end

function GameMode:Often()
	-- print("every 5 minutes")
	return 5*60
end

function GameMode:Regular()
	-- print("every 15 minutes")
	return 15*60
end

function GameMode:Seldom()
	-- print("every 30 minutes")
	return 30*60
end
