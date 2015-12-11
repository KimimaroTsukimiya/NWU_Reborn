function createParticle( keys )
	local particle = ParticleManager:CreateParticle("particles/units/heroes/neji/kaiten.vpcf", PATTACH_ABSORIGIN_FOLLOW, keys.caster)
	ParticleManager:SetParticleControl(particle, 0, keys.caster:GetAbsOrigin()) -- Origin
	keys.ability.ultiParticle = particle
end

function removeParticle( keys )
	keys.caster:Stop()
	ParticleManager:DestroyParticle( keys.ability.ultiParticle, true )
end