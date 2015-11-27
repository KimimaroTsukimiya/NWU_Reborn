function kirin_teleport(keys)
	local target = keys.target_points[1]
	local caster = keys.caster

	-- Teleport the caster to the target
	local caster_pos = caster:GetAbsOrigin()
	local blink_pos = target + ( caster_pos - target ):Normalized() * 100
	FindClearSpaceForUnit(caster, blink_pos, true)
end