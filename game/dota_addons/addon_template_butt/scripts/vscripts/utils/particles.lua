BUTT_PARTICLE_LIFESTEAL = "generic_lifesteal"
BUTT_PARTICLE_COINS = "lasthit_coins_local"
BUTT_PARTICLE_MANABURN = "generic_manaburn"

function CDOTA_BaseNPC:particleeffect(i)
	if ("string"==type(i)) then
		local nFXIndex = ParticleManager:CreateParticle( ("particles/generic_gameplay/"..i..".vpcf"), PATTACH_ABSORIGIN_FOLLOW, self )
		ParticleManager:ReleaseParticleIndex( nFXIndex )
	elseif (i==BUTT_PARTICLE_LIFESTEAL) then
		local nFXIndex = ParticleManager:CreateParticle( "particles/generic_gameplay/generic_lifesteal.vpcf", PATTACH_ABSORIGIN_FOLLOW, self )
		ParticleManager:ReleaseParticleIndex( nFXIndex )
	elseif (i==BUTT_PARTICLE_COINS) then
		local nFXIndex = ParticleManager:CreateParticle( "particles/generic_gameplay/lasthit_coins_local.vpcf", PATTACH_ABSORIGIN_FOLLOW, self )
		ParticleManager:ReleaseParticleIndex( nFXIndex )
	elseif (i==3) then
		-- generic_manaburn.vpcf_c
		-- screen_blood_splatter.vpcf_c
		-- lasthit_coins_local.vpcf_c
	end
end
