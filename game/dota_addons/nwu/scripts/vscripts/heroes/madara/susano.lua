--[[Author LearningDave
	Date october, 25th 2015
	Swaps abilities (madara_susano <> madara_susano_active) (couldnt use toggle behavior cause the custom model animations made problems(no act_dota_toggle found))
]]
function SwapAbility( keys )
	local caster = keys.caster	
	local ability = keys.ability
	local ability_level = ability:GetLevel()

	local main_ability_name = keys.main_ability_name
	local sub_ability_name = keys.sub_ability_name
	print(main_ability_name)
	print(sub_ability_name)
	-- Ability swap
	caster:RemoveAbility(main_ability_name)
		
	Ability = caster:AddAbility(sub_ability_name)
	Ability:SetAbilityIndex(1)
	Ability:SetLevel(ability_level)

end
--[[
	Author LearningDave
	Date october, 25th 2015.
	Reduces the mana of the caster and switches to madara_susano if the caster is out of mana
]]
function ManaCost( keys )
	-- Variables
	local ability_level = keys.ability:GetLevel()
	print("test")
	local caster = keys.caster
	local ability = keys.ability
	local manacost_per_second = keys.ability:GetLevelSpecialValueFor("mana_cost_per_second", keys.ability:GetLevel() - 1 )
	local current_mana = caster:GetMana()
	local new_mana = current_mana - manacost_per_second
	print(new_mana)
	--local particle = keys.ability.particle
	if (current_mana - manacost_per_second) <= 0 then
		caster:SetMana(1)
		caster:RemoveAbility("madara_susano_active")
		
		Ability = caster:AddAbility("madara_susano")
		Ability:SetAbilityIndex(1)
		Ability:SetLevel(ability_level)
	else
		caster:SetMana(new_mana)
	end
end
--[[
	Author LearningDave
	Date october, 25th 2015.
	Applies damage to all nearby enemy units of the caster
]]
function BurnEnemies( keys )
	-- Variables
	local caster = keys.caster
	local ability = keys.ability
	local burn_radius = keys.ability:GetLevelSpecialValueFor("burn_radius", keys.ability:GetLevel() - 1 )
	local burn_damage = keys.ability:GetLevelSpecialValueFor("burn_damage", keys.ability:GetLevel() - 1 )
	local targetEntities = FindUnitsInRadius(keys.caster:GetTeamNumber(), caster:GetAbsOrigin(), nil, burn_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
		if targetEntities then
			for _,oneTarget in pairs(targetEntities) do
				local damage_table = {}
				damage_table.attacker = caster
				damage_table.victim = oneTarget
				damage_table.damage_type = ability:GetAbilityDamageType()
				damage_table.ability = ability
				damage_table.damage = burn_damage
				ApplyDamage(damage_table)
				--PopupDamage(oneTarget, burn_damage)
				local particle = ParticleManager:CreateParticle("particles/dire_fx/fire_barracks_glow_b.vpcf", PATTACH_ABSORIGIN_FOLLOW, nil) 
				ParticleManager:SetParticleControl(particle , 0, oneTarget:GetAbsOrigin())
			end
		end
end
--[[
	Author LearningDave
	Date october, 25th 2015.
	Burns all nearby trees if madara_wood_release is skilled
]]
function BurnTrees( keys )
	local ability_index = keys.caster:FindAbilityByName("madara_wood_release"):GetAbilityIndex()
    local wood_ability = keys.caster:GetAbilityByIndex(ability_index)
    local wood_ability_level = keys.caster:GetAbilityByIndex(ability_index):GetLevel()
    local tree_vision = wood_ability:GetLevelSpecialValueFor("tree_vision", wood_ability_level)
    local tree_burn_duration = wood_ability:GetLevelSpecialValueFor("tree_burn_duration", wood_ability_level)
    local aoe = keys.ability:GetLevelSpecialValueFor("burn_radius", keys.ability:GetLevel() - 1 )

    if wood_ability_level > 0 then
		local trees = GridNav:GetAllTreesAroundPoint(keys.caster:GetAbsOrigin(), aoe, false) 
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
         
          						local targetEntities = FindUnitsInRadius(keys.caster:GetTeamNumber(), origin, nil, tree_vision, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
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
