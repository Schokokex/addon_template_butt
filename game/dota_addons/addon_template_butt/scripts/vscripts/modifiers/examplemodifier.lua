examplemodifier = class({})

-- check out https://developer.valvesoftware.com/wiki/Dota_2_Workshop_Tools/Scripting/API



function examplemodifier:GetTexture() return "alchemist_chemical_rage" end

function examplemodifier:IsPermanent() return true end
function examplemodifier:RemoveOnDeath() return false end
function examplemodifier:IsHidden() return false end
function examplemodifier:IsDebuff() return false end

function examplemodifier:GetAttributes()
	return 0
		+ MODIFIER_ATTRIBUTE_MULTIPLE
		+ MODIFIER_ATTRIBUTE_PERMANENT
end

function examplemodifier:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ATTACK_LANDED,
		MODIFIER_EVENT_ON_DEATH,
		-- these functions are usually called with everyone on the map
		-- check the link for more
	}
	return funcs
end

function examplemodifier:OnCreated(event)
	for k,v in pairs(event) do print("examplemodifier created",k,v,(IsServer() and "on Server" or "on Client")) end
	-- called when the modifier is created
end

function examplemodifier:OnRefresh(event)
	for k,v in pairs(event) do print("examplemodifier refreshed",k,v,(IsServer() and "on Server" or "on Client")) end
	-- called when the modifier is created
end


function examplemodifier:OnDeath(event)
	for k,v in pairs(event) do print("OnDeath",k,v) end -- find out what event.__ to use
	if IsClient() then return end
	if event.unit~=self:GetParent() then return end -- only affect the own hero
	-- space for some fancy stuff
end

function examplemodifier:OnAttackLanded(event)
	-- for k,v in pairs(event) do print("onattack",k,v) end
	local target=event.target
	local attacker=event.attacker
	local hero=self:GetParent()
	if not (hero==attacker) then return end
	if RollPercentage(50) then
		EmitSoundOn("hitme",hero)
	end
	self:IncrementStackCount()
	if self:GetStackCount()%10==0 then -- every 10th attack
		PlayerResource:ModifyGold(hero:GetPlayerOwnerID(),100,false,DOTA_ModifyGold_CreepKill)
		SendOverheadEventMessage(player, OVERHEAD_ALERT_GOLD, hero, 100, nil)
	end
	if IsInToolsMode() then target:ForceKill(false) end
end

function examplemodifier:CheckState()
	return {
		[MODIFIER_STATE_CANNOT_MISS] =  true,
-- 		[MODIFIER_STATE_UNSELECTABLE] =  true,
		-- check out the link for more
	}
end
