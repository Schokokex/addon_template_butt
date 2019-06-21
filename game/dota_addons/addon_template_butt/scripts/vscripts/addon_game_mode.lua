-- Generated from template

if GameMode == nil then
	_G.GameMode = class({})
end

require("utils/particles")
require("utils/ButtAPI")
require("utils/timers")
require("utils/util")
require("utils/shortcuts")

require("internal/panorama")
require("internal/events")
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
	
	GameRules.AddonTemplate = GameMode()
	GameRules.AddonTemplate:InitGameMode()
end

function GameMode:InitGameMode()
	print( "Template addon is loaded." )
	GameMode:LoadFilters()
end
