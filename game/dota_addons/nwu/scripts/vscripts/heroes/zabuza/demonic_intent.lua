function demonic_intent_attack( keys )
	-- Variables
	local caster = keys.caster
	local ability = keys.ability
	local modifierName = "modifier_demonic_intent_buff_datadriven"

	if caster:HasModifier( modifierName ) then
		local current_stack = caster:GetModifierStackCount( modifierName, ability )	
		ability:ApplyDataDrivenModifier( caster, caster, modifierName, {})
		caster:SetModifierStackCount( modifierName, ability, math.min(current_stack + 1, 4))
	else
		ability:ApplyDataDrivenModifier( caster, caster, modifierName, {})
		caster:SetModifierStackCount( modifierName, ability, 1)
	end
end