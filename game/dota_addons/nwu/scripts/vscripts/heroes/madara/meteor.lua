--[[ ============================================================================================================
	Author: LearningDave
	Date: October 26th, 2015
	Launches the Meteor
================================================================================================================= ]]
function LaunchMeteor(keys)
	--ParticleManager:DestroyParticle(keys.ability.particle, true)
	local caster_point = keys.caster:GetAbsOrigin()
	local target_point = keys.target_points[1]
	
	local caster_point_temp = Vector(caster_point.x, caster_point.y, 0)
	local target_point_temp = Vector(target_point.x, target_point.y, 0)
	
	local point_difference_normalized = (target_point_temp - caster_point_temp):Normalized()
	local velocity_per_second = point_difference_normalized * keys.TravelSpeed
	
	keys.caster:EmitSound("Hero_Invoker.ChaosMeteor.Cast")



	--Create a particle effect consisting of the meteor falling from the sky and landing at the target point.
	local meteor_fly_original_point = (target_point - (velocity_per_second * keys.LandTime)) + Vector (0, 0, 1000)  --Start the meteor in the air in a place where it'll be moving the same speed when flying and when rolling.
	local chaos_meteor_fly_particle_effect = ParticleManager:CreateParticle("particles/units/heroes/hero_invoker/invoker_chaos_meteor_fly.vpcf", PATTACH_ABSORIGIN, keys.caster)
	ParticleManager:SetParticleControl(chaos_meteor_fly_particle_effect, 0, meteor_fly_original_point)
	ParticleManager:SetParticleControl(chaos_meteor_fly_particle_effect, 1, target_point)
	ParticleManager:SetParticleControl(chaos_meteor_fly_particle_effect, 2, Vector(1.3, 0, 0))
end
--[[ ============================================================================================================
	Author: LearningDave
	Date: October 26th, 2015
	Fire a explosion effect, applies damage to all enimies in the aoe, burns trees if wood_release is skilled
================================================================================================================= ]]
function meteorExplode(keys)
	local target_point = keys.target_points[1]
	local aoe = keys.aoe
	local damage = keys.damage
	local ability_index = keys.caster:FindAbilityByName("madara_wood_release"):GetAbilityIndex()
    local wood_ability = keys.caster:GetAbilityByIndex(ability_index)
    local wood_ability_level = keys.caster:GetAbilityByIndex(ability_index):GetLevel()
    local tree_vision = wood_ability:GetLevelSpecialValueFor("tree_vision", wood_ability_level)
    local tree_burn_duration = wood_ability:GetLevelSpecialValueFor("tree_burn_duration", wood_ability_level)
	local nearby_enemy_units = FindUnitsInRadius(keys.caster:GetTeam(), target_point, nil, aoe, DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, FIND_ANY_ORDER, false)

	for i, individual_unit in ipairs(nearby_enemy_units) do
			
			ApplyDamage({victim = individual_unit, attacker = keys.caster, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL,})
	end
	local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_warlock/warlock_rain_of_chaos_explosion.vpcf", PATTACH_CUSTOMORIGIN, nil) 
	ParticleManager:SetParticleControl(particle , 0, target_point)

	if wood_ability_level > 0 then
		local trees = GridNav:GetAllTreesAroundPoint(target_point, aoe, false) 
				if trees then
					for _,tree in pairs(trees) do
						local origin = tree:GetAbsOrigin()
						xcoord = origin.x
						ycoord = origin.y
						--local dummy = CreateUnitByName( "npc_burning_tree", Vector(xcoord, ycoord, 0.0), false, keys.caster, nil, keys.caster:GetTeamNumber() )
						--dummy:GetAbilityByIndex(0):SetLevel(wood_ability_level)
						GridNav:DestroyTreesAroundPoint(origin, 40, true)
						local treesSecond = GridNav:GetAllTreesAroundPoint(origin, 50, false) 
						
						local particle = ParticleManager:CreateParticle("particles/units/heroes/madara/burning_tree.vpcf", PATTACH_CUSTOMORIGIN, nil) 
          				ParticleManager:SetParticleControl(particle , 0, origin)
 						

          				Timers:CreateTimer( function()
         
          						local targetEntities = FindUnitsInRadius(keys.caster:GetTeamNumber(), origin, nil, tree_vision, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, FIND_ANY_ORDER, false)
							    if targetEntities then
							      for _,oneTarget in pairs(targetEntities) do
							        local modfifier = oneTarget:FindModifierByName("burning_tree_dot")
							        if modifier == nil then
							          wood_ability:ApplyDataDrivenModifier(keys.caster, oneTarget, "burning_tree_dot", {Duration = tree_burn_duration})
							          local particle = ParticleManager:CreateParticle("particles/dire_fx/fire_barracks_glow_b.vpcf", PATTACH_ABSORIGIN_FOLLOW, nil) 
							          ParticleManager:SetParticleControl(particle , 0, oneTarget:GetAbsOrigin())
							        end
							      end
							    end

          						if stopCheck then
          							return 0.3
          						else
          							return nil
          						end
							  
						end
					  	)

          				Timers:CreateTimer( tree_burn_duration, function()
          						stopCheck = false
						   		ParticleManager:DestroyParticle(particle, true)
							  return nil
						end
					  	)
					end
				end
	end
end
--[[ ============================================================================================================
	Author: LearningDave
	Date: October 26th, 2015
	Fires the shadow for the meteor while madara is channeling
================================================================================================================= ]]
function spawnShadow(keys)
	local caster_point = keys.caster:GetAbsOrigin()
	local target_point = keys.target_points[1]
	
	local caster_point_temp = Vector(caster_point.x, caster_point.y, 0)
	local target_point_temp = Vector(target_point.x, target_point.y, 0)
	
	local point_difference_normalized = (target_point_temp - caster_point_temp):Normalized()
	local velocity_per_second = target_point_temp:Normalized() * keys.TravelSpeed
	--Create a particle effect consisting of the meteor falling from the sky and landing at the target point.
	local meteor_fly_original_point = target_point + Vector (-900, 0, 2000)  --Start the meteor in the air in a place where it'll be moving the same speed when flying and when rolling.
	local meteor_fly_original_point_2 = target_point + Vector (-900, 0, 2000)
	local meteor_fly_original_point_3 = (target_point - (velocity_per_second * keys.LandTime)) + Vector (0, 0, 100)
	local chaos_meteor_fly_particle_effect = ParticleManager:CreateParticle("particles/units/heroes/hero_invoker/invoker_chaos_meteor_fly_shadow.vpcf", PATTACH_ABSORIGIN, keys.caster)
	 	ParticleManager:SetParticleControl(chaos_meteor_fly_particle_effect, 0, meteor_fly_original_point)
		ParticleManager:SetParticleControl(chaos_meteor_fly_particle_effect, 1, meteor_fly_original_point_2)
		ParticleManager:SetParticleControl(chaos_meteor_fly_particle_effect, 2, Vector(3.8 , 0, 0))
	 keys.ability.particle = chaos_meteor_fly_particle_effect
end
