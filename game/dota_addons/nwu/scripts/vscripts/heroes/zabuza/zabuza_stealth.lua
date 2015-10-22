function stealth( keys )
	local target = keys.target
	local caster = keys.caster
	FindClearSpaceForUnit( caster, target:GetAbsOrigin(), false )
end