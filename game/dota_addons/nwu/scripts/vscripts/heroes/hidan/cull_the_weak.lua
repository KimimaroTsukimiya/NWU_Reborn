function initiateValues( keys )
	keys.ability.hitTargets = {}
end

function gatherTargets( keys )
	print("TARGETHIT")
	print("test39")
	
end

function cull_the_weak( keys )
	print("test222")
	local caster = keys.caster
	local ability = keys.ability
	
	print("test1")
	print(keys.ability.hitTargets[0])
	for k,v in ipairs(keys.ability.hitTargets) do
      print(v.GetAbsOrigin())
      print("test")
    end
end


function release_pull( keys )
	local target_point = keys.target_points[1]
	local caster_location = keys.caster:GetAbsOrigin()
	local range = 400
	local pull_radius_start = 1000
	local pull_radius_end = 1000
	local pull_speed = 1000
	local ability = keys.ability
	local point_difference_normalized = (target_point - caster_location):Normalized()
	local velocity = point_difference_normalized * pull_speed


	local info = 
	{
			Ability = keys.ability,
        	EffectName = keys.fire_particle,
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