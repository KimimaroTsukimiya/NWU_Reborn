function return_damage(event)
	local caster = event.caster
	local attacker = event.attacker
	local ability = event.ability
	local return_rate = ability:GetLevelSpecialValueFor("damage_return_rate", ability:GetLevel() - 1 )
	local damage_type = ability:GetAbilityDamageType()
	local damage = return_rate * event.DamageTaken
	ApplyDamage({ victim = attacker, attacker = caster, damage = damage, damage_type = damage_type })
end