_G.ADDON_FOLDER = debug.getinfo(1,"S").source:sub(2,-37)
if not IsInToolsMode() then
	_G.PUBLISH_DATA = LoadKeyValues(ADDON_FOLDER:sub(5,-16).."publish_data.txt")
	_G.WORKSHOP_TITLE = PUBLISH_DATA.title -- LoadKeyValues(debug.getinfo(1,"S").source:sub(7,-53).."publish_data.txt").title 
end

_G.GameMode = _G.GameMode or class({})

require("utils/util")
require("internal/init")

require("utils/butt_api")
require("utils/custom_gameevents")
require("utils/particles")
require("utils/timers")
-- require("utils/notifications") -- will test it tomorrow

require("internal/events")
require("internal/filters")
require("internal/panorama")
require("internal/shortcuts")
require("internal/talents")
require("internal/thinker")
require("internal/xp_modifier")

require("events")
require("filters")
require("settings_butt")
require("settings_misc")
require("startitems")
require("thinker")

function Precache( context )
	PrecacheResource("soundfile", "soundevents/custom_sounds.vsndevts", context)
	--[[
		Precache things we know we'll use.  Possible file types include (but not limited to):
			PrecacheResource( "model", "*.vmdl", context )
			PrecacheResource( "particle", "*.vpcf", context )
			PrecacheResource( "particle_folder", "particles/folder", context )
	]]
end

-- Create the game mode when we activate
function Activate()
	GameRules:GetGameModeEntity():SetUseDefaultDOTARuneSpawnLogic(true)
	GameRules:GetGameModeEntity():SetTowerBackdoorProtectionEnabled(true)
	GameRules:SetShowcaseTime(0)
	
	GameRules.GameMode = GameMode()
	-- GameRules.AddonTemplate:InitGameMode()
	FireGameEvent("init_game_mode",{})
end

ListenToGameEvent("init_game_mode", function()
	print( "Template addon is loaded." )
end, GameRules.GameMode)
