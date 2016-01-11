function rasengan(keys)
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	
	if target:IsBuilding() then
		return
	end
	local range = keys.ability:GetLevelSpecialValueFor( "distance", ( keys.ability:GetLevel() - 1 ) )
	local bonus_damage_percent = keys.ability:GetLevelSpecialValueFor( "bonus_damage", ( keys.ability:GetLevel() - 1 ) )
	keys.caster:RemoveModifierByName(keys.modifier)
	keys.caster:RemoveModifierByName(keys.damageModifier)

	local vCaster = keys.caster:GetAbsOrigin()
	local vTarget = keys.target:GetAbsOrigin()
	local len = ( vTarget - vCaster ):Length2D()
	len = range - range * ( len / range )

	
	local knockbackModifierTable =
	{
		should_stun = 1,
		knockback_duration = 0.2,
		duration = 0.2,
		knockback_distance = len,
		knockback_height = 0,
		center_x = keys.caster:GetAbsOrigin().x,
		center_y = keys.caster:GetAbsOrigin().y,
		center_z = keys.caster:GetAbsOrigin().z
	}
	keys.target:AddNewModifier( keys.caster, nil, "modifier_knockback", knockbackModifierTable )
	
	local damage = caster:GetAverageTrueAttackDamage() + (caster:GetAverageTrueAttackDamage() / 100 * bonus_damage_percent)
	ApplyDamage({ victim = target, attacker = caster, damage = damage, damage_type = DAMAGE_TYPE_PHYSICAL })
	
	local particle = ParticleManager:CreateParticle("particles/units/heroes/yondaime/raseng_impact.vpcf", PATTACH_POINT_FOLLOW, keys.caster) 
	ParticleManager:SetParticleControlEnt(particle, 0, keys.target, PATTACH_POINT_FOLLOW, "attach_hitloc", keys.target:GetAbsOrigin(), true)
	ParticleManager:SetParticleControlEnt(particle, 2, keys.target, PATTACH_POINT_FOLLOW, "attach_hitloc", keys.target:GetAbsOrigin(), true)
	ParticleManager:SetParticleControlEnt(particle, 3, keys.target, PATTACH_POINT_FOLLOW, "attach_hitloc", keys.target:GetAbsOrigin(), true)

end

function rasengan_bonus_damage( keys )
	local damage_percent = keys.ability:GetLevelSpecialValueFor( "bonus_damage", ( keys.ability:GetLevel() - 1 ) )
	local damage = (keys.caster:GetAttackDamage() / 100 * damage_percent)
	keys.caster:SetModifierStackCount("modifier_rasengan_bonus_damage", keys.ability, damage)


	local particle = ParticleManager:CreateParticle("particles/units/heroes/yondaime/raseng_model.vpcf", PATTACH_POINT_FOLLOW, keys.caster) 
	ParticleManager:SetParticleControlEnt(particle, 0, keys.caster, PATTACH_POINT_FOLLOW, "attach_right_hand", keys.caster:GetAbsOrigin(), true)
	ParticleManager:SetParticleControlEnt(particle, 1, keys.caster, PATTACH_POINT_FOLLOW, "attach_right_hand", keys.caster:GetAbsOrigin(), true)
	ParticleManager:SetParticleControlEnt(particle, 3, keys.caster, PATTACH_POINT_FOLLOW, "attach_right_hand", keys.caster:GetAbsOrigin(), true)
 	keys.caster.rasenParticle = particle
end

function destroyRasenParticle( keys )
	ParticleManager:DestroyParticle(keys.caster.rasenParticle, true)
end