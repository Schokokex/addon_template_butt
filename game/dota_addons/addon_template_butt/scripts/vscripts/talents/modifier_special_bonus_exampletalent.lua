LinkLuaModifier("modifier_special_bonus_exampletalent", "talents/modifier_special_bonus_exampletalent", LUA_MODIFIER_MOTION_NONE)

require("talents/modifier_special_bonus_base")
modifier_special_bonus_exampletalent = class(modifier_special_bonus_base)

function modifier_special_bonus_exampletalent:DeclareFunctions()
	return {
			MODIFIER_PROPERTY_CASTTIME_PERCENTAGE,
			MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,
		}
end

-- 90% castpoint reduction
function modifier_special_bonus_exampletalent:GetModifierPercentageCasttime( event )
	-- return 90
	return self:GetAbility():GetSpecialValueFor("value")
end

function modifier_special_bonus_exampletalent:GetModifierPercentageCooldown( event )
	-- return 90
	return self:GetAbility():GetSpecialValueFor("value")
end
