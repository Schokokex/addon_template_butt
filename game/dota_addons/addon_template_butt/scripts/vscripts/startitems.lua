local startitems = {
	-- "item_travel_boots",
}
local bonusabilities = {
	-- "exampleability",
}
local bonusmodifier = {
	examplemodifier = {duration = 30},
	-- examplemodifier = {},
}
local talents = {
	l4 = "special_bonus_exampletalent",	r4 = "special_bonus_exampletalent",
	l3 = "special_bonus_exampletalent",	r3 = "special_bonus_exampletalent",
	l2 = "special_bonus_exampletalent",	r2 = "special_bonus_exampletalent",
	l1 = "special_bonus_exampletalent",	r1 = "special_bonus_exampletalent",
}

LinkLuaModifier("examplemodifier", "modifiers/examplemodifier", LUA_MODIFIER_MOTION_NONE)

ListenToGameEvent("dota_player_pick_hero",function(kv)
	print("picked")
	local hero = EntIndexToHScript(kv.heroindex)
	for i,item in pairs(startitems) do
		if hero:HasRoomForItem(item, true, true) then
			local asd = CreateItem(item, hero, hero)
			asd:SetPurchaseTime(0)
			hero:AddItem(asd)
		end
	end

	for a,abil in pairs(bonusabilities) do
		hero:AddAbility(abil)
	end

	for name,data in pairs(bonusmodifier) do
		hero:AddNewModifier(hero, nil, name, data)
	end

	local tal = {
		l4 = 7, r4 = 8,
		l3 = 5, r3 = 6,
		l2 = 3, r2 = 4,
		l1 = 1, r1 = 2,
	}

	local heroTalents = hero:GetAllTalents() -- with abilitynumber

	-- for k,i in pairs(heroTalents) do
	-- 	if talents[k] then
	-- 		heroTalents[i]:Destroy()
	-- 		hero:SetAbilityByIndex(hero:AddAbility(talents[k]),i)
	-- 	end
	-- end
	
end, self)