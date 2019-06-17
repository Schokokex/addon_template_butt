PlayerList = class({})

function PlayerList:GetAllPlayers()
	local out = {}
	for p=0,DOTA_MAX_PLAYERS do
		if (PlayerResource:IsValidPlayer(p)) then
			out[p] = PlayerResource:GetPlayer(p)
		else
			out[p] = nil
		end
	end
	return out
end

function PlayerList:GetValidTeamPlayers()
	local out = {}
	for p=0,DOTA_MAX_PLAYERS do
		if (PlayerResource:IsValidTeamPlayer(p)) then
			out[p] = PlayerResource:GetPlayer(p)
		else
			out[p] = nil
		end
	end
	return out
end

function PlayerList:GetFriendlyPlayers(teamID) -- returns playerID and player
	local out = {}
	for p=0,DOTA_MAX_PLAYERS do
		if (PlayerResource:IsValidPlayer(p)) and (PlayerResource:GetTeam(p)==teamID) then
			out[p] = PlayerResource:GetPlayer(p)
		else
			out[p] = nil
		end
	end
	return out
end

---------------------------
-- extend PlayerResource --
---------------------------

PlayerResourceButt = class({})

function PlayerResourceButt:GetFriendlyPlayers(playerID) -- returns table with playerID and player
	local teamID = PlayerResource:GetTeam(playerID)
	local out = {}
	for p=0,DOTA_MAX_PLAYERS do
		if (PlayerResource:IsValidPlayer(p)) and (PlayerResource:GetTeam(p)==teamID) then
			out[p] = PlayerResource:GetPlayer(p)
		else
			out[p] = nil
		end
	end
	return out
end

function PlayerResourceButt:GetFriendlyHeroes(playerID) -- Friendly HeroList
	local teamID = PlayerResource:GetTeam(playerID)
	local out = HeroList:GetAllHeroes()
	for h,hero in pairs(out) do
		if (hero:GetTeam()~=teamID) then
			out[h] = nil
		end
	end
	return out
end

function PlayerResourceButt:GetMainFriendlyHeroes(playerID) -- One Hero per Person on playerID
	local teamID = PlayerResource:GetTeam(playerID)
	local out = {}
	for p=0,DOTA_MAX_PLAYERS do
		if (PlayerResource:GetSelectedHeroEntity(p)) and (PlayerResource:GetTeam(p)==teamID) then
			out[p] = PlayerResource:GetSelectedHeroEntity(p)
		else
			out[p] = nil
		end
	end
	return out
end

---------------------
-- extend HeroList --
---------------------

HeroListButt = class({})

function HeroListButt:GetFriendlyHeroes(teamID)
	local out = HeroList:GetAllHeroes()
	for h,hero in pairs(out) do
		if (hero:GetTeam()==teamID) then
		else
			out[h] = nil
		end
	end
	return out
end

function HeroListButt:GetMainHeroes()
	local out = {}
	for p=0,DOTA_MAX_PLAYERS do
		if (PlayerResource:HasSelectedHero(p)) then
			out[p] = PlayerResource:GetSelectedHeroEntity(p)
		else
			out[p] = nil
		end
	end
	return out
end

function HeroListButt:GetMainFriendlyHeroes(teamID)
	local out = {}
	for p=0,DOTA_MAX_PLAYERS do
		if (PlayerResource:GetSelectedHeroEntity(p)) and (PlayerResource:GetTeam(p)==teamID) then
			out[p] = PlayerResource:GetSelectedHeroEntity(p)
		else
			out[p] = nil
		end
	end
	return out
end

function HeroListButt:GetOneHeroPerTeam()
	local out = {}
	for h,hero in pairs(HeroList:GetAllHeroes()) do
		local team = hero:GetTeam()
		if (not out[team]) then
			out[team] = hero
		end
	end
	return out
end


---------------------
-- TeamList --
---------------------

TeamList = class({})

function TeamList:GetPlayableTeams()
	local out = {}
	for t=2,14 do
		-- print("TeamList",GameRules:GetCustomGameTeamMaxPlayers(t))
		if (GameRules:GetCustomGameTeamMaxPlayers(t)>0) then
			table.insert(out,t)
		end
	end
	return out
end

function TeamList:GetFirstPlayers()
	local out = {}
	for p=0,DOTA_MAX_PLAYERS do
		local team = PlayerResource:GetTeam(p)
		if (not out[team]) then
			out[team] = PlayerResource:GetPlayer(p)
		end
	end
	return out
end

function TeamList:GetFreeCouriers()
	for t,hero in pairs(HeroListButt:GetOneHeroPerTeam()) do
		if (not PlayerResource:GetNthCourierForTeam(0,t)) then
			local courier = hero:AddItemByName("item_courier")
			-- hero:CastAbilityImmediately(courier, hero:GetPlayerID())
			courier:CastAbility()
		end
	end
end

function TeamList:GetTotalEarnedGold()
	local out = {}
	for p=0,DOTA_MAX_PLAYERS do
		local team = PlayerResource:GetTeam(p)
		out[team] = PlayerResource:GetTotalEarnedGold(p) + (out[team] or 0)
	end
	return out
end

function TeamList:GetTotalEarnedXP()
	local out = {}
	for p=0,DOTA_MAX_PLAYERS do
		local team = PlayerResource:GetTeam(p)
		out[team] = PlayerResource:GetTotalEarnedXP(p) + (out[team] or 0)
	end
	return out
end


---------------------
-- TeamResource --
---------------------

TeamResource = class({})

function TeamResource:GetTotalEarnedGold(teamID)
	local out = 0
	for p=0,DOTA_MAX_PLAYERS do
		if (PlayerResource:IsValidPlayer(p)) and (PlayerResource:GetTeam(p)==teamID) then
			out = out + PlayerResource:GetTotalEarnedGold(p)
		end
	end
	return out
end

function TeamResource:GetTotalEarnedXP(teamID)
	local out = 0
	for p=0,DOTA_MAX_PLAYERS do
		if (PlayerResource:IsValidPlayer(p)) and (PlayerResource:GetTeam(p)==teamID) then
			out = out + PlayerResource:GetTotalEarnedXP(p)
		end
	end
	return out
end

function TeamResource:GetTeamKills(teamID)
	return PlayerResource:GetTeamKills(teamID)
end

--------------------------
-- extend CDOTA_BaseNPC --
--------------------------

function CDOTA_BaseNPC:GetAllAbilities()
	local out = {}
	for i=0,29 do
		out[i] = self:GetAbilityByIndex(i)
	end
	return out
end

function CDOTA_BaseNPC:GetAllTalents()
	local out = {}
	for i=0,29 do
		local abil = self:GetAbilityByIndex(i)
		if (abil) and (abil:GetName():find("special_bonus_") == 1) then
			out[i] = abil
		end
	end
	return out
end