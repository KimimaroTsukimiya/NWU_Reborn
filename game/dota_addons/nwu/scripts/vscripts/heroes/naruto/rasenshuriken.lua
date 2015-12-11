function rasenshuriken_impact(keys)
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	local damage = ability:GetAbilityDamage()
	local damage_type = ability:GetAbilityDamageType()
	local target_flags = ability:GetAbilityTargetType()
	
	local aoe = keys.AoE
	local modifier = keys.rs_modifier

	local targetEntities = FindUnitsInRadius(caster:GetOpposingTeamNumber(), target:GetAbsOrigin(), nil,
		aoe, DOTA_UNIT_TARGET_TEAM_FRIENDLY, target_flags , DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
		
	if( not targetEntities )then
		return
	end
	
	for i,value in pairs(targetEntities) do
	
		ability:ApplyDataDrivenModifier(
			caster,
			value,
			modifier,
			{}
		)
		
		ApplyDamage({attacker = caster, victim = value, ability = ability, damage = damage, damage_type = damage_type})
		
	end
	
end