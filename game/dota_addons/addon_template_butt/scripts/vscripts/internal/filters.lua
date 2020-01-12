BUTTINGS = BUTTINGS or {}

InternalFilters = class({})
Filters = class({})

local filterTables = {}
local filterLabels = {}

local filterNames = {"BountyRunePickup", "AbilityTuningValue", "Damage", "ExecuteOrder", "RuneSpawn", "Healing", "ItemAdedToInventory", "ModifierGained", "ModifyExperience", "ModifyGold", "TrackingProjectile"}

ListenToGameEvent("addon_game_mode_activate",function()
	local contxt = {}
	local gEnt = GameRules:GetGameModeEntity()
	for _,fName in pairs(filterNames) do
		gEnt["Set"..fName.."Filter"](gEnt, InternalFilters[fName.."Filter"], contxt)
	end
end, nil)



function InternalFilters:AbilityTuningValueFilter(event)
	return Filters:ApplyAllAbilityTuningValueFilters(event)
end

function InternalFilters:BountyRunePickupFilter(event)
	event.xp_bounty = event.xp_bounty * BUTTINGS.XP_GAIN_PERCENTAGE * 0.01
	event.gold_bounty = event.gold_bounty * BUTTINGS.GOLD_GAIN_PERCENTAGE * 0.01

	return Filters:ApplyAllBountyRunePickupFilters(event)
end

function InternalFilters:DamageFilter(event)
	return Filters:ApplyAllDamageFilters(event)
end

function InternalFilters:ExecuteOrderFilter(event)
	if 1==BUTTINGS.BUYBACK_RULES and DOTA_UNIT_ORDER_BUYBACK==event.order_type then
		local iUnit = event.units and event.units["0"]
		self.bbCount = self.bbCount or {}
		self.bbCount[iUnit] = self.bbCount[iUnit] or BUTTINGS.BUYBACK_LIMIT
		local hero = EntIndexToHScript(iUnit)
		if self.bbCount[iUnit] <= 0 then
			HUDError("No buybacks left", hero:GetPlayerOwnerID())
			return false 
		else
			hero:SetThink(function() hero:SetBuybackCooldownTime(BUTTINGS.BUYBACK_COOLDOWN) end, 0.2)
			self.bbCount[iUnit] = self.bbCount[iUnit] - 1 
		end
	end
	if EditFilterToCourier and false==EditFilterToCourier(event) then
		return false
	end
	return Filters:ApplyAllExecuteOrderFilters(event)
end

function InternalFilters:HealingFilter(event)
	return Filters:ApplyAllHealingFilters(event)
end

function InternalFilters:ItemAddedToInventoryFilter(event)
	return Filters:ApplyAllItemAddedToInventoryFilters(event)
end

function InternalFilters:ModifierGainedFilter(event)
	return Filters:ApplyAllModifierGainedFilters(event)
end

function InternalFilters:ModifyExperienceFilter(event)
	event.experience = event.experience * BUTTINGS.XP_GAIN_PERCENTAGE * 0.01

	-- PrintTable(event)
	local playerID = event.player_id_const
	local reason = event.reason_const
	local xp = event.experience -- can not get modified with local

	local heroUnit = playerID and PlayerResource:GetSelectedHeroEntity(playerID)
	
	-- ##
	local out = Filters:ApplyAllModifyExperienceFilters(event)
	-- ##

	local teamHeroes = PlayerResourceButt:GetMainFriendlyHeroes(event.player_id_const)
	teamHeroes[event.player_id_const] = nil
	local count = table.length(teamHeroes)

	local singleAmt = event.experience * BUTTINGS.SHARED_XP_PERCENTAGE * 0.01 / count
	singleAmt = math.floor(singleAmt + 0.5)

	for h,hero in pairs(teamHeroes) do
		event.experience = event.experience - singleAmt
		hero:AddExperience(singleAmt, DOTA_ModifyXP_Unspecified, false, true)
	end

	return out
end

function InternalFilters:ModifyGoldFilter(event)
	event.gold = event.gold * BUTTINGS.GOLD_GAIN_PERCENTAGE * 0.01

	-- PrintTable(event) 
	local playerID = event.player_id_const
	local reason = event.reason_const
	local gold = event.gold -- can not get modified with local
	local reliable = event.reliable -- can not get modified with local
	
	local heroUnit = playerID and PlayerResource:GetSelectedHeroEntity(playerID)

	-- ##
	local out = Filters:ApplyAllModifyGoldFilters(event)
	-- ##
	
	local teamPlayers = PlayerResourceButt:GetFriendlyPlayers(event.player_id_const)
	teamPlayers[event.player_id_const] = nil
	local count = table.length(teamPlayers)

	local singleAmt = event.gold * BUTTINGS.SHARED_GOLD_PERCENTAGE * 0.01 / count
	singleAmt = math.floor(singleAmt + 0.5)

	for tp,tPlayer in pairs(teamPlayers) do
		event.gold = event.gold - singleAmt
		PlayerResource:ModifyGold(tp,singleAmt,(1 == event.reliable),DOTA_ModifyGold_SharedGold)
	end
	return out
end


function InternalFilters:RuneSpawnFilter(event)
	-- PrintTable(event)
	-- maybe deprecated? 
	return Filters:ApplyAllRuneSpawnFilters(event)
end

function InternalFilters:TrackingProjectileFilter(event)
	return Filters:ApplyAllTrackingProjectileFilters(event)
end

---- new update ----

for _,fName in pairs(filterNames) do
	filterTables[fName] = {}
	filterLabels[fName] = {}
	local xFilterTable = filterTables[fName]
	local xFilterLabelTable = filterLabels[fName]
	Filters[fName.."Filter"] = function (self,num, func, str)
		local pos,f,s = argSorter({num,func,str},{"number","function","string"},{[2]=true})
		pos = pos and math.clamp(math.ceil(pos),#xFilterTable+1,1) or #xFilterTable +1
		table.insert(xFilterTable ,pos,f)
		table.insert(xFilterLabelTable ,pos, s or tostring(f))
		return pos
	end

	Filters["Get"..fName.."Filters"] = function(self)
		return table.pack(table.unpack(xFilterLabelTable))
	end

	Filters["Remove"..fName.."Filter"] = function(self,pos)
		table.remove(xFilterTable,pos)
		table.remove(xFilterLabelTable,pos)
	end

	Filters["RemoveAll"..fName.."Filters"] = function(self)
		xFilterTable = {}
		xFilterLabelTable = {}
	end

	Filters["ApplyAll"..fName.."Filters"] = function(self,event)
		for _,f in ipairs(xFilterTable) do
			if not f(event) then return false end
		end
	end
end