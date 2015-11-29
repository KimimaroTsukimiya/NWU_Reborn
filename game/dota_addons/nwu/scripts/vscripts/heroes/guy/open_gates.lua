function openGates( keys )
	local bat = keys.ability:GetLevelSpecialValueFor( "base_attack_time", keys.ability:GetLevel() - 1)
	print(bat)
	print(keys.caster:GetBaseAttackTime())
	keys.ability.old_bat = keys.caster:GetBaseAttackTime()
	keys.caster:SetBaseAttackTime(bat)
	print(keys.caster:GetBaseAttackTime())
end

function removeBAT( keys )
	print(keys.caster:GetBaseAttackTime())
	keys.caster:SetBaseAttackTime(keys.ability.old_bat)
	print(keys.caster:GetBaseAttackTime())
end