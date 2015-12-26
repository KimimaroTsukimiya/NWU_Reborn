--[[ ============================================================================================================
	Author: Zenicus
	Date: November 22, 2015
	Called when Tornado is cast.
	Additional parameters: keys.TravelSpeed, keys.AreaOfEffect, keys.VisionDistance, and keys.EndVisionDuration
================================================================================================================= ]]
function temari_fusajin_no_jutsu_on_spell_start(keys)
	local caster_origin = keys.caster:GetAbsOrigin()

	--Tornado's travel distance and lift duration are dependent on the level of Quas.
	local tornado_travel_distance = 0
	local tornado_lift_duration = 0
	local target = keys.target
	local ability = keys.ability
	local caster = keys.caster
	
	local tornado_travel_distance = (caster:GetAbsOrigin() - target:GetAbsOrigin())::Length2D() 
	


	tornado_dummy_unit:EmitSound("Hero_Invoker.Tornado")  --Emit a sound that will follow the tornado.
	tornado_dummy_unit:SetDayTimeVisionRange(keys.VisionDistance)
	tornado_dummy_unit:SetNightTimeVisionRange(keys.VisionDistance)
	
	local projectile_information =  
	{
		EffectName = "particles/units/heroes/hero_invoker/invoker_tornado.vpcf",
		vSpawnOrigin = caster_origin,
		fDistance = tornado_travel_distance,
		fStartRadius = keys.AreaOfEffect,
		fEndRadius = keys.AreaOfEffect,
		Source = tornado_dummy_unit,
		bHasFrontalCone = false,
		iMoveSpeed = keys.TravelSpeed,
		bReplaceExisting = false,
		bProvidesVision = true,
		iVisionTeamNumber = keys.caster:GetTeam(),
		iVisionRadius = keys.VisionDistance,
		bDrawsOnMinimap = false,
		bVisibleToEnemies = true, 
		iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
		iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
		iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_CREEP,
		fExpireTime = GameRules:GetGameTime() + 20.0,
	}

	local target_point = keys.target_points[1]
	target_point.z = 0
	local caster_point = keys.caster:GetAbsOrigin()
	caster_point.z = 0
	local point_difference_normalized = (target_point - caster_point):Normalized()
	projectile_information.vVelocity = point_difference_normalized * keys.TravelSpeed
	
	local tornado_projectile = ProjectileManager:CreateLinearProjectile(projectile_information)
	
	--When the projectile ID can be passed into a OnProjectileHitUnit block, an array like this can be used to store the stats associated with the projectile.
	--[[
	--Store the lift duration and bonus landing damage associated with the projectile, using the Quas/Exort levels from when Tornado was cast.
	if keys.caster.tornado_projectile_information == nil then
		keys.caster.tornado_projectile_information = {}
	end
	local tornado_projectile_information = {}
	tornado_projectile_information["tornado_lift_duration"] = tornado_lift_duration
	tornado_projectile_information[tornado_projectile])["tornado_landing_damage_bonus"] = tornado_landing_damage_bonus
	keys.caster.tornado_projectile_information[tornado_projectile] = tornado_projectile_information
	]]
	
	tornado_dummy_unit.temari_tornado_lift_duration = tornado_lift_duration
	
	--Calculate where and when the Tornado projectile will end up.
	local tornado_duration = tornado_travel_distance / keys.TravelSpeed
	local tornado_final_position = caster_origin + (projectile_information.vVelocity * tornado_duration)
	local tornado_velocity_per_frame = projectile_information.vVelocity * .03
	
	--Adjust the dummy unit's position every frame to match that of the tornado particle effect.
	local endTime = GameRules:GetGameTime() + tornado_duration
	Timers:CreateTimer({
		endTime = .03,
		callback = function()
			tornado_dummy_unit:SetAbsOrigin(tornado_dummy_unit:GetAbsOrigin() + tornado_velocity_per_frame)
			if GameRules:GetGameTime() > endTime then
				tornado_dummy_unit:StopSound("Hero_Invoker.Tornado")
				
				--Have the dummy unit linger in the position the tornado ended up in, in order to provide vision.
				Timers:CreateTimer({
					endTime = keys.EndVisionDuration,
					callback = function()
						tornado_dummy_unit:RemoveSelf()
					end
				})
				
				return 
			else 
				return .03
			end
		end
	})
end