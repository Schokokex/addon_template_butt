_G.ADDON_FOLDER = debug.getinfo(1,"S").source:sub(2,-37)
if not IsInToolsMode() then
	_G.PUBLISH_DATA = LoadKeyValues(ADDON_FOLDER:sub(5,-16).."publish_data.txt")
	_G.WORKSHOP_TITLE = PUBLISH_DATA.title -- LoadKeyValues(debug.getinfo(1,"S").source:sub(7,-53).."publish_data.txt").title 
end

_G.GameMode = _G.GameMode or class({})

require("internal/utils/util")
require("internal/init")

require("internal/courier")

require("internal/utils/butt_api")
require("internal/utils/custom_gameevents")
require("internal/utils/particles")
require("internal/utils/timers")
-- require("internal/utils/notifications") -- will test it tomorrow

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

function Spawn()
	local gmE = GameRules:GetGameModeEntity()

	gmE:SetUseDefaultDOTARuneSpawnLogic(true)
	gmE:SetTowerBackdoorProtectionEnabled(true)
	GameRules:SetShowcaseTime(0)

	FireGameEvent("created_game_mode_entity",{gameModeEntity = gmE})
end

function Activate()
	GameRules.GameMode = GameMode()
	FireGameEvent("init_game_mode",{})
end

ListenToGameEvent("init_game_mode", function()
	print( "Template addon is loaded." )
end, GameRules.GameMode)
