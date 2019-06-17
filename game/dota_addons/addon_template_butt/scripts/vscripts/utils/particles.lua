function CDOTA_BaseNPC:particleeffect(i)
	if (0==i) then
		local nFXIndex = ParticleManager:CreateParticle( "particles/generic_gameplay/generic_lifesteal.vpcf", PATTACH_ABSORIGIN_FOLLOW, self )
		ParticleManager:ReleaseParticleIndex( nFXIndex )
	elseif (1==i) then
	end
end

BUTT_PARTICLE_LIFESTEAL = 0