function chakra_enhanced_strength( keys )
	if not keys.target:IsBuilding() then
		keys.ability.enemy = keys.target
		keys.ability:ApplyDataDrivenModifier(keys.caster, keys.target, keys.modifier_name, {duration = 1})
	end
end

function chakra_enhanced_strength_apply( keys )
	local vCaster = keys.caster:GetAbsOrigin()
	local vTarget = keys.ability.enemy:GetAbsOrigin()
	local len = ( vTarget - vCaster ):Length2D()
	len = keys.distance - keys.distance * ( len / keys.range )
	local knockbackModifierTable =
	{
		should_stun = 1,
		knockback_duration = keys.duration,
		duration = keys.duration,
		knockback_distance = len,
		knockback_height = 0,
		center_x = keys.caster:GetAbsOrigin().x,
		center_y = keys.caster:GetAbsOrigin().y,
		center_z = keys.caster:GetAbsOrigin().z
	}
	keys.ability.enemy:AddNewModifier( keys.caster, nil, "modifier_knockback", knockbackModifierTable )


	local damageTable = {}
	damageTable.attacker = keys.caster
	damageTable.victim = keys.ability.enemy
	damageTable.damage_type = keys.ability:GetAbilityDamageType()
	damageTable.ability = keys.ability
	damageTable.damage = keys.damage
	ApplyDamage(damageTable)


	keys.caster:RemoveModifierByName(keys.modifier_name)
end