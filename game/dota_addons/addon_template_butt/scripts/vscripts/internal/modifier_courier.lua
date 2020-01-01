modifier_courier =  class({})

-- check out https://developer.valvesoftware.com/wiki/Dota_2_Workshop_Tools/Scripting/API

-- The modifier Tooltip is inside resource/addon_english.txt (Have fun playing)


-- function modifier_courier:GetTexture() return "alchemist_chemical_rage" end -- get the icon from a different ability

function modifier_courier:IsPermanent() return true end
function modifier_courier:RemoveOnDeath() return false end
function modifier_courier:IsHidden() return true end 	-- we can hide the modifier
function modifier_courier:IsDebuff() return false end 	-- make it red or green

function modifier_courier:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BASE_OVERRIDE, -- GetModifierMoveSpeedOverride 
		MODIFIER_PROPERTY_RESPAWNTIME , -- GetModifierConstantRespawnTime  
		MODIFIER_EVENT_ON_MODEL_CHANGED , -- OnModelChanged   
		MODIFIER_EVENT_ON_DEATH, -- OnDeath
		MODIFIER_EVENT_ON_RESPAWN, -- OnRespawn 
		-- these functions are usually called with everyone on the map
		-- check the link for more
		-- https://developer.valvesoftware.com/wiki/Dota_2_Workshop_Tools/Scripting/API#modifierfunction
	}
	return funcs
end

function modifier_courier:OnRespawn(event)
	if IsClient() then return end
	if event.unit~=self:GetParent() then return end -- only affect the own hero
	self:updateHealth()
end

function modifier_courier:OnDeath(event)
	if IsClient() then return end
	if event.unit~=self:GetParent() then return end -- only affect the own hero
	self:GetParent():SetUnitCanRespawn(false)
	self:StartIntervalThink(self.level * 7 + 43)
end

function modifier_courier:OnIntervalThink()
	self:GetParent():SetUnitCanRespawn(true)
	self:GetParent():RespawnUnit()
	self:StartIntervalThink(-1)
end


function modifier_courier:OnCreated(event)
	self.startlevel = event.level or 1
	self.level = self.startlevel
	self.flying = (self.startlevel>=5)

	-- local self = self
	self.levelListener = ListenToGameEvent("dota_player_gained_level", function(self,event) -- for k,v in pairs(event) do			print("mod dota_player_gained_level",IsClient(),event,k,v)		end
		local hero = EntIndexToHScript(event.hero_entindex)
		if (self:GetCaster()~=hero) then return end
		local courier = self:GetParent()
		self.level = self.startlevel - 1 + event.level
		if IsServer() then 
			courier:SetDeathXP( self.level * 20 + 15 ) 
			courier:SetMaximumGoldBounty( self.level * 5 + 20 ) 
			courier:SetMinimumGoldBounty( self.level * 5 + 20 )
		end
		self:updateHealth()	
		if (event.level>=5) then
			self.flying = true
			self:OnModelChanged()
		end
		if IsClient() then return end
		if (event.level>=10) then
			courier:FindAbilityByName("courier_burst"):SetLevel(1)
		end
		if (event.level>=15) then
			-- can place wards
		end
		if (event.level>=20) then
			courier:FindAbilityByName("courier_shield"):SetLevel(1)
		end
		if (event.level>=25) then
			-- can use items
		end
	end, self)
end

function modifier_courier:updateHealth(event)
	if IsClient() then return end
	local courier = self:GetParent()
	local percHealth = courier:GetHealth()/courier:GetMaxHealth()
	courier:SetMaxHealth(self.level * 10 +  60)
	courier:SetHealth(percHealth*courier:GetMaxHealth())
end

function modifier_courier:OnDestroy(event)
	StopListeningToGameEvent(self.levelListener)
end


function modifier_courier:GetModifierMoveSpeedOverride()
	self:updateHealth()	
	return self.level * 10 + 270 
end
function modifier_courier:GetModifierConstantRespawnTime()	return     end

function modifier_courier:OnModelChanged()
	if IsClient() or not self.flying then return end
	self:GetParent():SetOriginalModel("models/props_gameplay/donkey_wings.vmdl")
	self:GetParent():SetModel("models/props_gameplay/donkey_wings.vmdl")
end

function modifier_courier:CheckState()
	return {
		[MODIFIER_STATE_FLYING] =  self.flying,
		-- https://developer.valvesoftware.com/wiki/Dota_2_Workshop_Tools/Scripting/API#modifierstate
	}
end
