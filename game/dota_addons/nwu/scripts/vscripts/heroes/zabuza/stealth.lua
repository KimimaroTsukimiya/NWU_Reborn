function stealth( keys )
	local target = keys.target
	local caster = keys.caster
	print(target:GetAbsOrigin())
	PrintTable(target)
	FindClearSpaceForUnit( caster, target:GetAbsOrigin(), false )
end