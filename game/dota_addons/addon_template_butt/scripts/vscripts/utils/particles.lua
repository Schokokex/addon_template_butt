BUTT_PARTICLE_LIFESTEAL = 0
BUTT_PARTICLE_COINS = 1

function CDOTA_BaseNPC:particleeffect(i)
	if (i==BUTT_PARTICLE_LIFESTEAL) then
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
