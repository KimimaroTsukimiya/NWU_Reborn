function return_damage(event)
	local caster = event.caster
	local attacker = event.attacker
	local ability = event.ability
	local damage = ability:GetLevelSpecialValueFor("damage", ability:GetLevel() - 1 )
	local stun_duration = ability:GetLevelSpecialValueFor("stun_duration", ability:GetLevel() - 1 )
	local damage_type = ability:GetAbilityDamageType()
	ApplyDamage({ victim = attacker, attacker = caster, damage = damage, damage_type = damage_type })
	attacker:AddNewModifier(caster, ability, "modifier_stunned", {duration = stun_duration})
end

function applyEffect( keys )
	print("test")
	local particle = ParticleManager:CreateParticle("particles/units/heroes/onoki/armor_core.vpcf",  PATTACH_ABSORIGIN_FOLLOW, keys.caster)
	ParticleManager:SetParticleControlEnt(particle, 0, keys.target, PATTACH_POINT_FOLLOW, "attach_hitloc", keys.target:GetAbsOrigin(), false)
	ParticleManager:SetParticleControlEnt(particle, 3, keys.target, PATTACH_POINT_FOLLOW, "attach_hitloc", keys.target:GetAbsOrigin(), false)
end