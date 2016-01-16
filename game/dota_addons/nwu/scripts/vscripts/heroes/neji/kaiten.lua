function createParticle( keys )
	local particle = ParticleManager:CreateParticle("particles/units/heroes/neji/neji_forgot_a.vpcf", PATTACH_ABSORIGIN_FOLLOW, keys.caster)
	ParticleManager:SetParticleControl(particle, 1, keys.caster:GetAbsOrigin()) -- Origin
	ParticleManager:SetParticleControlEnt(particle, 0, keys.caster, PATTACH_POINT_FOLLOW, "attach_hitloc", keys.caster:GetAbsOrigin(), true)
	keys.ability.ultiParticle = particle
end

function removeParticle( keys )
	keys.caster:Stop()
	ParticleManager:DestroyParticle( keys.ability.ultiParticle, true )
end