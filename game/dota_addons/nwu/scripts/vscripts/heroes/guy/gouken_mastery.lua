function ApplyDoubleDamage( keys )
	local target = keys.target
	local caster = keys.caster
	local ability = keys.ability
	local abilityDamageType = ability:GetAbilityDamageType()
	local damage = keys.caster:GetAttackDamage()
	PopupDamamge(target, damage)
	local damageTable = {
			victim = target,
			attacker = caster,
			damage = damage,
			damage_type = abilityDamageType
		}
	ApplyDamage( damageTable )

end