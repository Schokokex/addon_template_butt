local startitems = {
	-- item_travel_boots = {},
	-- item_travel_boots = {},
}
local bonusabilities = {
	-- exampleability = { lvl = 1, cd = 120 , nokey = true, hidden = true, cast = true },
	-- roshan_spell_block = { lvl = 4, nokey = true },
}
local bonusmodifier = {
	examplemodifier = {duration = 10},
	-- examplemodifier = {},
}
local talents = {
	[8] = "",	[7] = "",
	[6] = "",	[5] = "",
	[4] = "",	[3] = "",
	[2] = "",	[1] = "",
	-- [2] = "",	[1] = "special_bonus_exampletalent",
}

ListenToGameEvent("dota_player_pick_hero",function(kv)
	local hero = EntIndexToHScript(kv.heroindex)
	
	-- Items

	for i,item in pairs(startitems) do
		if hero:HasRoomForItem(item, true, true) then
			local asd = CreateItem(item, hero, hero)
			asd:SetPurchaseTime(0)
			hero:AddItem(asd)
		end
	end

	-- Abilities

	for abil,kv in pairs(bonusabilities) do
		if (not kv.nokey) then hero:RemoveAbility("generic_hidden") end
		local a = hero:AddAbility(abil)
		a:SetLevel(kv.level or kv.lvl or 0)
		if (kv.cast) then a:CastAbility() end
		a:SetHidden(kv.hidden or false)
		a:StartCooldown(kv.cooldown or kv.cd or 0)
	end

	-- Modifiers

	for name,data in pairs(bonusmodifier) do
		hero:AddNewModifierButt(hero, nil, name, data)
	end

	-- Talents

	local heroTalents = hero:GetAllTalents() -- with abilitynumber
	
	local ind = {}
	for i,_ in pairs(heroTalents) do
		table.insert(ind,i)
	end

	for i,name in pairs(talents) do
		if (name~="") and (not hero:FindAbilityByName(name)) then
			local pos = ind[i]
			hero:RemoveAbility(heroTalents[pos]:GetName())
			hero:AddAbility(name):SetAbilityIndex(pos)
		end
	end

end, self)