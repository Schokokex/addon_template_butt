exampleability = class({})

function exampleability:OnSpellStart()
	local radius = self:GetSpecialValueFor( "damage_radius" )
	local dmg = self:GetSpecialValueFor( "self_damage" )
	local dur = self:GetSpecialValueFor("duration")
	local initls = self:GetSpecialValueFor("ls_start")
	local units = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetCaster():GetOrigin(), self:GetCaster(), radius, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
	for u,unit in pairs(units) do
		local dmgtype = nil
		if (self:GetCaster()==unit) then
			dmgtype = DAMAGE_TYPE_PURE
		else
			dmgtype = DAMAGE_TYPE_MAGICAL
		end
		local tabel = {
						victim = unit,
						attacker = self:GetCaster(),
						damage = dmg,
						damage_type = dmgtype,
						damage_flags = DOTA_DAMAGE_FLAG_NON_LETHAL, -- Optional
						ability = self	-- Optional
					}
		ApplyDamage( tabel )
	end
	self:GetCaster():AddNewModifier(
						self:GetCaster(), -- handle caster,
						self, -- handle optionalSourceAbility,
						"exampleabilitymodifier", -- string modifierName,
						{ duration = dur, lifesteal = initls } -- handle modifierData)
	)
end


LinkLuaModifier( "exampleabilitymodifier", "abilities/exampleability", LUA_MODIFIER_MOTION_NONE )

exampleabilitymodifier = class({})

function exampleabilitymodifier:GetTexture() return "item_lifesteal" end

function exampleabilitymodifier:OnCreated( kv )
	self.lifesteal = kv.lifesteal
end

function exampleabilitymodifier:OnRefresh( kv )
	self.lifesteal = kv.lifesteal
end

function exampleabilitymodifier:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_ATTACK_LANDED,
	}
end

function exampleabilitymodifier:OnAttackLanded(event)
	if self:GetParent()~=event.attacker then return end
	self:GetParent():Heal(self.lifesteal, self:GetAbility())
	self:GetParent():particleeffect(BUTT_PARTICLE_LIFESTEAL)
	self.lifesteal = self.lifesteal / 2
end