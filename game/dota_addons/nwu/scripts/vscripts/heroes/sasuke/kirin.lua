function kirin_teleport(keys)
	local target = keys.target_points[1]
	local caster = keys.caster
	local particle = keys.particle

	-- Lightning particle
	local pid = ParticleManager:CreateParticle(particle, PATTACH_CUSTOMORIGIN, caster)
    ParticleManager:SetParticleControl(pid, 0, target)
    ParticleManager:SetParticleControl(pid, 1, target + Vector(0, 0, 1500))

	-- Teleport the caster to the target
	local caster_pos = caster:GetAbsOrigin()
	local blink_pos = target + ( caster_pos - target ):Normalized() * 100
	FindClearSpaceForUnit(caster, blink_pos, true)
end