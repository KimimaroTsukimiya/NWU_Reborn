function tsukiyomi( keys )
	local duration = keys.ability:GetLevelSpecialValueFor("duration", keys.ability:GetLevel() - 1)
	local ability_damage = keys.ability:GetAbilityDamage()
	keys.ability:ApplyDataDrivenModifier(keys.caster, keys.target, "modifier_itachi_tsukiyomi_stun", {duration = duration})
	ApplyDamage({victim = keys.target, attacker = keys.caster, damage = ability_damage, damage_type = DAMAGE_TYPE_MAGICAL})
end