
function LaunchArrow( keys )
	local caster = keys.caster
	local caster_location = caster:GetAbsOrigin()
	local target_point = keys.target_points[1]
	local ability = keys.ability
	local ability_level = ability:GetLevel() - 1

	local lariat_dummy = CreateUnitByName("npc_dummy_unit", caster_location, false, nil, nil, keys.caster:GetTeam())
	lariat_dummy.particle_name = keys.particle_name
	lariat_dummy.projectileTo = target_point
	lariat_dummy.projectileFrom = caster_location
	lariat_dummy.dummy_ability = ability
	lariat_dummy:AddAbility("dummy")
	lariat_dummy.projectile_speed = ability:GetLevelSpecialValueFor("arrow_speed", ability_level)
	lariat_dummy.projectile_distance = ability:GetLevelSpecialValueFor("arrow_range", ability_level)
	local point_difference_normalized = (target_point - caster_location):Normalized()
	local velocity = point_difference_normalized * lariat_dummy.projectile_speed

	local info = 
	{
		Ability = lariat_dummy.dummy_ability,
        EffectName = lariat_dummy.particle_name,
        vSpawnOrigin = lariat_dummy.projectileFrom,
        fDistance = lariat_dummy.projectile_distance,
        fStartRadius = 64,
        fEndRadius = 64,
        Source = caster,
        bHasFrontalCone = false,
        bReplaceExisting = false,
        iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
        iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
        iUnitTargetType = DOTA_UNIT_TARGET_HERO,
        fExpireTime = GameRules:GetGameTime() + 10.0,
		bDeleteOnHit = true,
		vVelocity = velocity,
		bProvidesVision = true,
		iVisionRadius = 1000,
		iVisionTeamNumber = caster:GetTeamNumber()
	}
	projectile = ProjectileManager:CreateLinearProjectile(info)
end


function LaunchArrowCheck( keys )
	-- Remove caster from the world
	keys.ability:ApplyDataDrivenModifier(caster, caster, modifier_caster, {})
	keys.caster:AddNoDraw()


end

function LaunchArrowCheckInit( keys )
	


	local caster = keys.caster
	local caster_location = caster:GetAbsOrigin()
	local ability = keys.ability
	local ability_level = ability:GetLevel() - 1

	local lariat_dummy = CreateUnitByName("npc_dummy_unit", caster_location, false, nil, nil, keys.caster:GetTeam())
	 lariat_dummy.particle_name = keys.particle_name
	 lariat_dummy.dummy_ability = ability
	 lariat_dummy:AddAbility("dummy")
	 lariat_dummy.projectile_speed = ability:GetLevelSpecialValueFor("arrow_speed", ability_level)
	 lariat_dummy.projectile_distance = ability:GetLevelSpecialValueFor("arrow_range", ability_level)
	local direction = (keys.ability:GetCursorPosition() - lariat_dummy.projectileFrom:Normalized() 
	local spawn = clariat_dummy + lariat_dummy.projectile_distance + lariat_dummy.projectileFrom:Normalized()
	local elocity = -direction * lariat_dummy.projectile_distance
	local info = 
	{
		Ability = lariat_dummy.dummy_ability,
        EffectName = lariat_dummy.particle_name,
        vSpawnOrigin = spawn,
        fDistance = lariat_dummy.projectile_distance,
        fStartRadius = 64,
        fEndRadius = 64,
        Source = caster,
        bHasFrontalCone = false,
        bReplaceExisting = false,
        iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
        iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
        iUnitTargetType = DOTA_UNIT_TARGET_HERO,
        fExpireTime = GameRules:GetGameTime() + 10.0,
		bDeleteOnHit = true,
		vVelocity = elocity,
		bProvidesVision = true,
		iVisionRadius = 1000,
		iVisionTeamNumber = caster:GetTeamNumber()
	}
	projectile = ProjectileManager:CreateLinearProjectile(info)
end


function Comeback( args )
	
	local range = args.ability:GetLevelSpecialValueFor("arrow_range", args.ability:GetLevel() - 1)
	print(range)
	local caster = args.caster 
	local spawn = caster:GetAbsOrigin() + range + caster:GetAbsOrigin():Normalized()
	local info = 
	{
		Ability = args.ability,
        	EffectName = args.arrow_particle,
        	vSpawnOrigin = spawn,
        	fDistance = range,
        	fStartRadius = 64,
        	fEndRadius = 64,
        	Source = caster,
        	bHasFrontalCone = false,
        	bReplaceExisting = false,
        	iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
        	iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
        	iUnitTargetType = DOTA_UNIT_TARGET_HERO,
        	fExpireTime = GameRules:GetGameTime() + 10.0,
			bDeleteOnHit = true,
			vVelocity = caster:GetAbsOrigin():Normalized() * range,
			bProvidesVision = true,
			iVisionRadius = 1000,
			iVisionTeamNumber = caster:GetTeamNumber()
	}
	projectile = ProjectileManager:CreateLinearProjectile(info)
end