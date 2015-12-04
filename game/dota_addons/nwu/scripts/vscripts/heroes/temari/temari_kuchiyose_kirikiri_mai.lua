--[[ ============================================================================================================
	Author: Zenicus
	Date: November 25, 2015
	Temari's Ult.  Produces 5 bursts of winds and by passes through units.  It also destroys trees in the path.
	Additional parameters: keys.TravelSpeed, keys.AreaOfEffect, keys.VisionDistance, and keys.EndVisionDuration
================================================================================================================= ]]
function temari_kuchiyose_kirikiri_mai_on_spell_start(keys)
	local caster_origin = keys.caster:GetAbsOrigin()
	local parent = keys.target
	local ability = keys.ability
	local caster = keys.caster
	local tornado_projectile_array = {}
	local tornado_dummy_array = {}
	local point_difference_normalized
	local caster_point = keys.caster:GetAbsOrigin()
	local mouse_point = keys.target_points[1]
	local target_point = mouse_point
	local angle = math.atan2(target_point.y - caster_point.y, target_point.x - caster_point.x)
	local angle_spacing = 10
	local pointer_distance = math.sqrt((mouse_point.y - caster_point.y)^2 + (mouse_point.x - caster_point.x)^2)
	local tornado_radius = keys.AreaOfEffect
	local tornado_travel_distance = keys.ability:GetLevelSpecialValueFor("travel_distance", ability:GetLevel() - 1)

	--Create 5 Tornadoes & 5 Dummy Units, calculate where and when the Tornadoes projectile will end up.
	for i = 0, 4 do

		--Create a dummy unit that will follow the path of the tornado, providing flying vision and sound.
		--Its invoker_tornado_datadriven ability also applies the cyclone modifier to hit enemy units, since if Invoker uninvokes Tornado,
		--existing modifiers linked to that ability can cause errors.
		local tornado_dummy = CreateUnitByName("npc_dummy_unit", caster_origin, false, nil, nil, keys.caster:GetTeam())
		tornado_dummy:AddAbility("temari_kuchiyose_kirikiri_mai")

		local emp_unit_ability = tornado_dummy:FindAbilityByName("temari_kuchiyose_kirikiri_mai")
		if emp_unit_ability ~= nil then
			emp_unit_ability:SetLevel(1)
			emp_unit_ability:ApplyDataDrivenModifier(tornado_dummy, tornado_dummy, "modifier_temari_kuchiyose_kirikiri_mai_unit_ability", {duration = -1})
		end

		tornado_dummy:EmitSound("Hero_Invoker.Tornado")  --Emit a sound that will follow the tornado.
		tornado_dummy:SetDayTimeVisionRange(keys.VisionDistance)
		tornado_dummy:SetNightTimeVisionRange(keys.VisionDistance)

		local projectile_information =  
		{
			EffectName = "particles/units/heroes/hero_invoker/invoker_tornado.vpcf",
			Ability = emp_unit_ability,
			vSpawnOrigin = caster_origin,
			fDistance = tornado_travel_distance,
			fStartRadius = keys.AreaOfEffect,
			fEndRadius = keys.AreaOfEffect,
			Source = tornado_dummy,
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
			iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_CREEP + DOTA_UNIT_TARGET_TREE,
			fExpireTime = GameRules:GetGameTime() + 20.0,
		}

		if (i == 0) then
			--target_point.z = 0
			--caster_point.z = 0
		elseif (i == 1) then
			target_point.y =  caster_point.y + pointer_distance * math.sin(math.rad(math.deg(angle)-angle_spacing))
			target_point.x =  caster_point.x + pointer_distance * math.cos(math.rad(math.deg(angle)-angle_spacing))
		elseif (i == 2) then
			target_point.y =  caster_point.y + pointer_distance * math.sin(math.rad(math.deg(angle)+angle_spacing))
			target_point.x =  caster_point.x + pointer_distance * math.cos(math.rad(math.deg(angle)+angle_spacing))
		elseif (i == 3) then
			target_point.y =  caster_point.y + pointer_distance * math.sin(math.rad(math.deg(angle)-angle_spacing*2))
			target_point.x =  caster_point.x + pointer_distance * math.cos(math.rad(math.deg(angle)-angle_spacing*2))
		elseif (i == 4) then
			target_point.y =  caster_point.y + pointer_distance * math.sin(math.rad(math.deg(angle)+angle_spacing*2))
			target_point.x =  caster_point.x + pointer_distance * math.cos(math.rad(math.deg(angle)+angle_spacing*2))
		end
		
		point_difference_normalized = (target_point - caster_point):Normalized()

		projectile_information.vVelocity = point_difference_normalized * keys.TravelSpeed
		
		local tornado_projectile = ProjectileManager:CreateLinearProjectile(projectile_information)	
		local tornado_duration = tornado_travel_distance / keys.TravelSpeed
		local tornado_final_position = caster_origin + (projectile_information.vVelocity * tornado_duration)
		local tornado_velocity_per_frame = projectile_information.vVelocity * .03
		
		table.insert(tornado_projectile_array, tornado_projectile)

		--Adjust the dummy unit's position every frame to match that of the tornado particle effect.
		local endTime = GameRules:GetGameTime() + tornado_duration
		Timers:CreateTimer({
			endTime = .03,
			callback = function()

				local tornado_dummy_pos = tornado_dummy:GetAbsOrigin() + tornado_velocity_per_frame

				tornado_dummy:SetAbsOrigin(tornado_dummy_pos)

				if GridNav:IsNearbyTree(tornado_dummy_pos, tornado_radius, true ) then
					GridNav:DestroyTreesAroundPoint(tornado_dummy_pos, tornado_radius, false)
				end

				if GameRules:GetGameTime() > endTime then
					tornado_dummy:StopSound("Hero_Invoker.Tornado")
				
					--Have the dummy unit linger in the position the tornado ended up in, in order to provide vision.
					Timers:CreateTimer({
						endTime = keys.EndVisionDuration,
						callback = function()
							tornado_dummy:RemoveSelf()
						end
					})
				
					return 
					else 
					return .03
				end
			end
		})
		table.insert(tornado_dummy_array, tornado_dummy)
	end
end

--[[ ============================================================================================================
	Author: Zenicus
	Date: November 22, 2015
	Called when Tornado hits an enemy unit.
================================================================================================================= ]]
function temari_kuchiyose_kirikiri_mai_on_projectile_hit_unit(keys)
	
	local ability = keys.ability

	local burst_damage = ability:GetLevelSpecialValueFor("base_damage", ability:GetLevel() - 1)
	keys.target:EmitSound("Hero_Invoker.Tornado.Target")

	ApplyDamage({victim = keys.target, attacker = keys.caster, damage = burst_damage, damage_type = DAMAGE_TYPE_MAGICAL,})

	--Stop the sound when the cycloning ends.
	Timers:CreateTimer({
		endTime = keys.caster.temari_tornado_duration,
		callback = function()
			keys.target:StopSound("Hero_Invoker.Tornado.Target")
		end
	})

end