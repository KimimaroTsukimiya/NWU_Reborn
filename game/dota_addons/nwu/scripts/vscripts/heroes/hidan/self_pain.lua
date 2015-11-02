function self_pain( keys )
	local caster = keys.caster
	local ability = keys.ability
	local damage = ability:GetAbilityDamage()
	PopupDamage(caster, damage)
	if (caster:GetHealth() - damage) > 0 then
		caster:SetHealth(caster:GetHealth() - damage)
	else
		caster:SetHealth(1)
	end
end
