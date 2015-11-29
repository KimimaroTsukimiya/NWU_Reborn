function attachEffects( keys )
	keys.ability.effectOrigin = ParticleManager:CreateParticle("particles/units/heroes/invis/wyvern_winters_curse_buff.vpcf", PATTACH_ABSORIGIN, keys.caster)
	ParticleManager:SetParticleControlEnt(keys.ability.effectOrigin, 0, keys.caster, PATTACH_POINT_FOLLOW, "attach_origin", keys.caster:GetAbsOrigin(), true)
	keys.ability.effect = ParticleManager:CreateParticle("particles/units/heroes/invis/wyvern_winters_curse_buff.vpcf", PATTACH_ABSORIGIN, keys.caster)
	ParticleManager:SetParticleControlEnt(keys.ability.effect, 0, keys.caster, PATTACH_POINT_FOLLOW, "attach_hitloc", keys.caster:GetAbsOrigin(), true)
end

function removeEffects( keys )
	ParticleManager:DestroyParticle(keys.ability.effectOrigin,false)
	ParticleManager:DestroyParticle(keys.ability.effect,false)
end