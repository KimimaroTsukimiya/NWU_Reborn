function initiateValues( keys )
	keys.ability.hitTargets = {}
end

function gatherTargets( keys )
	table.insert(keys.ability.hitTargets, keys.target)
end

function health_cost( keys )
	local caster = keys.caster
	local ability = keys.ability
	local hp_percentage_cost = ability:GetLevelSpecialValueFor( "hp_percentage_cost", ( ability:GetLevel() - 1 ) )
	local reduce_hp = caster:GetMaxHealth() / 100 * hp_percentage_cost
	local new_health = caster:GetHealth() - reduce_hp
	caster:SetHealth(new_health)
	PopupDamage(caster, reduce_hp)
end



function cull_the_weak( keys )
	local duration = keys.ability:GetDuration()
	local caster = keys.caster
	local ability = keys.ability
	local creep_damage = ability:GetLevelSpecialValueFor( "creep_damage", ( ability:GetLevel() - 1 ) )
	local hero_damage = ability:GetLevelSpecialValueFor( "hero_damage", ( ability:GetLevel() - 1 ) )

	for key,oneTarget in pairs(keys.ability.hitTargets) do 
		print(key,oneTarget) 
		keys.ability:ApplyDataDrivenModifier(keys.caster, oneTarget, keys.move_slow_modifier, {Duration = duration})

		local vCaster = keys.caster:GetAbsOrigin()
		local vTarget = oneTarget:GetAbsOrigin()
		local len = -1 * (( vTarget - vCaster ):Length2D()) + 150
		local damage = 0
		if oneTarget:IsHero() then
			damage = hero_damage
		else 
			damage = creep_damage
		end
		local knockbackModifierTable =
		{
			should_stun = 0,
			knockback_duration = 0.3,
			duration = 0.3,
			knockback_distance = len,
			knockback_height = 0,
			center_x = keys.caster:GetAbsOrigin().x,
			center_y = keys.caster:GetAbsOrigin().y,
			center_z = keys.caster:GetAbsOrigin().z
		}
		oneTarget:AddNewModifier( keys.caster, nil, "modifier_knockback", knockbackModifierTable )

		local damageTable = {
				victim = oneTarget,
				attacker = caster,
				damage = damage,
				damage_type = ability:GetAbilityDamageType()
			}
		ApplyDamage( damageTable )


	end

end


function release_pull( keys )
	local target_point = keys.target_points[1]
	local caster_location = keys.caster:GetAbsOrigin()
	local range = keys.ability:GetLevelSpecialValueFor( "range", keys.ability:GetLevel() - 1)
	local pull_radius_start = keys.ability:GetLevelSpecialValueFor( "pull_radius_start", keys.ability:GetLevel() - 1)
	local pull_radius_end = keys.ability:GetLevelSpecialValueFor( "pull_radius_end", keys.ability:GetLevel() - 1)
	local pull_speed = 4000
	local ability = keys.ability
	local point_difference_normalized = (target_point - caster_location):Normalized()
	local velocity = point_difference_normalized * pull_speed


	local info = 
	{
			Ability = keys.ability,

        	vSpawnOrigin = keys.caster:GetAbsOrigin(),
        	fDistance = range,
        	fStartRadius = pull_radius_start,
        	fEndRadius = pull_radius_end,
        	Source = keys.caster,
        	bHasFrontalCone = false,
        	bReplaceExisting = false,
        	iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
        	iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
        	iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			bDeleteOnHit = false,
			vVelocity = velocity,
			bProvidesVision = false
	}
	projectile = ProjectileManager:CreateLinearProjectile(info)
end