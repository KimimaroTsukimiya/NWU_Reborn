function Doton( keys )
	local target = keys.target
	local caster = keys.caster
	local ability = keys.ability
	local stun_duration = ability:GetLevelSpecialValueFor("stun_duration", ability:GetLevel() - 1)
	local damage = ability:GetAbilityDamage()
	target:AddNewModifier(caster, ability, "modifier_stunned", {duration = stun_duration})
	ApplyDamage({victim = target, attacker = caster, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL})
end
		