function chidori_eiso(keys)
	local target = keys.target
	local caster = keys.caster
	local particle = keys.particle
	local ability = keys.ability
	local ability_level = ability:GetLevel() - 1
	local damage = ability:GetLevelSpecialValueFor("damage", ability_level)
	local duration = ability:GetLevelSpecialValueFor("stun_duration", ability_level)

	-- Lightning particle
	local pid = ParticleManager:CreateParticle(particle, PATTACH_CUSTOMORIGIN, caster)
    ParticleManager:SetParticleControl(pid, 0, target:GetAbsOrigin() + Vector(0, 0, 75))
    ParticleManager:SetParticleControl(pid, 1, caster:GetAbsOrigin() + Vector(0, 0, 75))

    -- Apply Damage and stun
	ApplyDamage({attacker = caster, victim = target, ability = ability, damage = damage, damage_type = ability:GetAbilityDamageType()})
	target:AddNewModifier(caster, ability, "modifier_stunned", {duration = duration})
end