function rasenshuriken_impact(keys)
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	local damage = ability:GetAbilityDamage()
	local damage_type = ability:GetAbilityDamageType()
	local target_flags = ability:GetAbilityTargetType()
	
	local aoe = keys.AoE
	local modifier = keys.rs_modifier
	local targetEntities = FindUnitsInRadius(caster:GetTeamNumber(), target:GetAbsOrigin(), nil, aoe, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, 0, FIND_ANY_ORDER, false)

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

function addEffect( keys )
	local particle = ParticleManager:CreateParticle("particles/units/heroes/yondaime/raseng_model.vpcf", PATTACH_POINT_FOLLOW, keys.caster) 
	ParticleManager:SetParticleControlEnt(particle, 0, keys.caster, PATTACH_POINT_FOLLOW, "attach_right_hand", keys.caster:GetAbsOrigin(), true)
	ParticleManager:SetParticleControlEnt(particle, 1, keys.caster, PATTACH_POINT_FOLLOW, "attach_right_hand", keys.caster:GetAbsOrigin(), true)
	ParticleManager:SetParticleControlEnt(particle, 3, keys.caster, PATTACH_POINT_FOLLOW, "attach_right_hand", keys.caster:GetAbsOrigin(), true)
 	keys.caster.rasenParticle = particle

end

function removeEffect( keys )
	ParticleManager:DestroyParticle(keys.caster.rasenParticle, true)
end