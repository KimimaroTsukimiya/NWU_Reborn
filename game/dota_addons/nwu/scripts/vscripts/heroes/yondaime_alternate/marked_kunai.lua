function marked_kunai(keys)
	if keys.caster:HasModifier(keys.modifierCheck) then
		keys.ability:ApplyDataDrivenModifier(keys.caster, keys.caster, keys.modifier, {})
	else
		keys.caster:RemoveModifierByName(keys.modifier)
	end	
end