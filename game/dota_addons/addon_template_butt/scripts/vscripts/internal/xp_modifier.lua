LinkLuaModifier("XPModifier","internal/xp_modifier", LUA_MODIFIER_MOTION_NONE)

ListenToGameEvent("npc_spawned",function(event)
	local npc = EntIndexToHScript(event.entindex)
	if npc and npc.AddNewModifier then
		npc:AddNewModifier(npc, nil, "XPModifier", nil)
	end
end, self)

XPModifier = class({})

function XPModifier:IsHidden() return true end

if (IsClient()) then return end

require("settings_butt")

function XPModifier:GetAttributes() 
	return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE
end

function XPModifier:DeclareFunctions() --we want to use these functions in this item
	local funcs = {
		-- MODIFIER_PROPERTY_EXP_RATE_BOOST, -- deprecated
		MODIFIER_PROPERTY_RESPAWNTIME_PERCENTAGE,
		MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,
		MODIFIER_EVENT_ON_ATTACK_FAIL,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}

	return funcs
end

-- function XPModifier:GetModifierPercentageExpRateBoost()
-- 	return BUTTINGS.BONUS_XP_PERCENTAGE
-- end

function XPModifier:GetModifierPercentageRespawnTime()
	return 1 - BUTTINGS.RESPAWN_TIME_PERCENTAGE * 0.01
end


function XPModifier:IsPermanent() 
	return true
end

function XPModifier:IsPurgable()
	return false
end


function XPModifier:GetModifierPercentageCooldown()
	return 100 - BUTTINGS.COOLDOWN_PERCENTAGE
end

function XPModifier:OnAttackFail( event )
	if event.attacker ~= self:GetParent() then return end
	if (1==event.fail_type) and (1==BUTTINGS.NO_UPHILL_MISS) then
		event.attacker:PerformAttack(event.target, false, event.process_procs, true, event.ignore_invis, false, false, false)
		event.fail_type = 0
	end
end

-- Only run on server so client still shows unmodified armor values
if IsServer() then
	function XPModifier:GetModifierPhysicalArmorBonus()
		if (1~=BUTTINGS.CLASSIC_ARMOR) then
			return 0
		end
		local unit = self:GetParent()
		if (self.checkArmor) then
			return 0
		else
			self.checkArmor = true
			self.armor = self:GetParent():GetPhysicalArmorValue(false)
			self.checkArmor = false
			return 45 * self.armor / (52 + 0.2 * math.abs(self.armor)) - self.armor
		end
	end
end


function XPModifier:CheckState()
	return {
		-- [MODIFIER_STATE_CANNOT_MISS] =  false,
		-- [MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY ] =  false,
	}
end