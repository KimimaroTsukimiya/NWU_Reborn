function return_damage(event)
	local caster = event.caster
	local attacker = event.attacker
	local ability = event.ability
	local damage = ability:GetLevelSpecialValueFor("damage", ability:GetLevel() - 1 )
	local stun_duration = ability:GetLevelSpecialValueFor("stun_duration", ability:GetLevel() - 1 )
	local damage_type = ability:GetAbilityDamageType()
	ApplyDamage({ victim = attacker, attacker = caster, damage = damage, damage_type = damage_type })
	attacker:AddNewModifier(caster, ability, "modifier_stunned", {duration = stun_duration})
end