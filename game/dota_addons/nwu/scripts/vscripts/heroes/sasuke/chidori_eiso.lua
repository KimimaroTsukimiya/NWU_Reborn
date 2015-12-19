require('items')

function chidori_eiso(keys)
	local target = keys.target
	local caster = keys.caster
	local particle = keys.particle
	local ability = keys.ability
	local duration = ability:GetLevelSpecialValueFor("stun_duration", ability:GetLevel() - 1)

	-- Lightning particle
	local pid = ParticleManager:CreateParticle(particle, PATTACH_CUSTOMORIGIN, caster)
    ParticleManager:SetParticleControl(pid, 0, target:GetAbsOrigin() + Vector(0, 0, 75))
    ParticleManager:SetParticleControl(pid, 1, caster:GetAbsOrigin() + Vector(0, 0, 75))

	local event = keys
	keys.GenericFunction = "GenericSpellFunction"
	keys.Modifier1 = "modifier_chidori_eiso"
	keys.Duration1 = duration
	keys.doDamage = true
	
	CheckForSpellBlock(event)
	
end