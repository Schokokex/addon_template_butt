ListenToGameEvent("game_rules_state_change", function()
	if (GameRules:State_Get()==DOTA_GAMERULES_STATE_GAME_IN_PROGRESS) then
		GameRules:GetGameModeEntity():SetThink( "VeryOften", GameMode, "Think1", 0 )
		GameRules:GetGameModeEntity():SetThink( "Often", GameMode, "Think5", 0 )
		GameRules:GetGameModeEntity():SetThink( "Regular", GameMode, "Think15", 0 )
		GameRules:GetGameModeEntity():SetThink( "Seldom", GameMode, "Think30", 0 )
		GameRules:GetGameModeEntity():SetThink( "DontForgetToSubscribe", GameMode, "Delay20", 20*60 )
		GameRules:GetGameModeEntity():SetThink( "LateGame", GameMode, "Delay30", 30*60 )
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

function GameMode:VeryOften()
	print("every minute")
	return 1*60
end

function GameMode:Often()
	print("every 5 minutes")
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
