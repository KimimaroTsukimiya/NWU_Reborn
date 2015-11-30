function sharingan( keys )
	if not keys.target:IsBuilding() then
		local ability    = keys.ability
		local target     = keys.target
		local duration 	 = keys.ability:GetLevelSpecialValueFor("duration", keys.ability:GetLevel() - 1)
		local damage 	 = keys.caster:GetBaseDamageMax()
		print(damage)
		print(keys.caster:GetBaseDamageMin())
		print(keys.caster:GetAgility())
		keys.ability:ApplyDataDrivenModifier(keys.caster, target, "modifier_itachi_sharingan_mr_reduce", {duration = duration})
		ApplyDamage({victim = target, attacker = keys.caster, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL})
		PopupDamage(target, damage)
	end
end