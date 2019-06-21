LinkLuaModifier("xp_modifier","internal/xp_modifier", LUA_MODIFIER_MOTION_NONE)

ListenToGameEvent("npc_spawned",function(event)
	local npc = EntIndexToHScript(event.entindex)
	if npc and npc.AddNewModifier then
		npc:AddNewModifier(npc, nil, "xp_modifier", nil)
	end
end, self)

xp_modifier = class({})

function xp_modifier:IsHidden() return true end

if (IsClient()) then return end

require("settings_butt")

function xp_modifier:GetAttributes() 
	return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE
end

function xp_modifier:DeclareFunctions() --we want to use these functions in this item
	local funcs = {
		-- MODIFIER_PROPERTY_EXP_RATE_BOOST, -- deprecated
		MODIFIER_PROPERTY_RESPAWNTIME_PERCENTAGE,
		MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,
		MODIFIER_EVENT_ON_ATTACK_FAIL,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}

	return funcs
end

-- function xp_modifier:GetModifierPercentageExpRateBoost()
-- 	return BUTTINGS.BONUS_XP_PERCENTAGE
-- end

function xp_modifier:GetModifierPercentageRespawnTime()
	return 1 - BUTTINGS.RESPAWN_TIME_PERCENTAGE * 0.01
end


function xp_modifier:IsPermanent() 
	return true
end

function xp_modifier:IsPurgable()
	return false
end


function xp_modifier:GetModifierPercentageCooldown()
	return 100 - BUTTINGS.COOLDOWN_PERCENTAGE
end

function xp_modifier:OnAttackFail( event )
	if event.attacker ~= self:GetParent() then return end
	if (event.fail_type==1) and (BUTTINGS.NO_UPHILL_MISS) then
		event.attacker:PerformAttack(event.target, false, event.process_procs, true, event.ignore_invis, false, false, false)
		event.fail_type = 0
	end
end

-- Only run on server so client still shows unmodified armor values
if IsServer() then
	function xp_modifier:GetModifierPhysicalArmorBonus()
		if (not BUTTINGS.CLASSIC_ARMOR) then
			return 0
		end
		local unit = self:GetParent()
		if (not unit:IsRealHero()) and ((not unit:IsConsideredHero()) or unit:IsIllusion()) then
			return 0
		end
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


function xp_modifier:CheckState()
	return {
		-- [MODIFIER_STATE_CANNOT_MISS] =  false,
		-- [MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY ] =  false,
	}
end
