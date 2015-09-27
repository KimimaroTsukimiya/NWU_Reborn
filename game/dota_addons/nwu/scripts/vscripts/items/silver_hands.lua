function cleave ( event )
	local radius = event.ability:GetLevelSpecialValueFor("radius", (event.ability:GetLevel()-1))
	local single_target_damage = event.ability:GetLevelSpecialValueFor("damage", (event.ability:GetLevel()-1)) + ( event.caster:GetStrength() * 4 )
	local aoe_damage = event.ability:GetLevelSpecialValueFor("aoe_damage_percent", (event.ability:GetLevel()-1)) + ( event.caster:GetStrength() * 3 )
	local target = event.target

		print("Performing Cleave!")
		-- Adds four times your Strength plus xxxx bonus damage to your next attack against a single target
			ApplyDamage({
					victim = target,
					attacker = event.caster,
					damage =  single_target_damage,
					damage_type = DAMAGE_TYPE_PHYSICAL
					})
		print("Done " .. single_target_damage .. " damage to the main target") 

		EmitSoundOn("Hero_Axe.CounterHelix_Blood_Chaser", target)

		-- causes three times your Strength plus xxxx damage to nearby enemy units for xx mana. 
		-- Find enemies
		enemies = FindUnitsInRadius(event.caster:GetTeamNumber(),
	                      target:GetAbsOrigin(), --cleave center based on the main target
	                      nil,
	                      radius,
	                      DOTA_UNIT_TARGET_TEAM_ENEMY,
	                      DOTA_UNIT_TARGET_ALL,
	                      DOTA_UNIT_TARGET_FLAG_NONE,
	                      FIND_ANY_ORDER,
	                      false)

		-- Do damage in AoE
		for _,enemy in pairs(enemies) do
			if enemy ~= target then -- exclude the original target
				ApplyDamage({
					victim = enemy,
					attacker = event.caster,
					damage =  aoe_damage,
					damage_type = DAMAGE_TYPE_PHYSICAL
					})
			end
	    end
	    print("Done " .. aoe_damage .. " in " .. radius )
end 