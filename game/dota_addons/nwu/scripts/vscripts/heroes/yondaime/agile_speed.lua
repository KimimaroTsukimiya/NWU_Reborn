function apply_bonus_damage( data )
	if data.ability.ms == data.caster:GetIdealSpeed() then
		print('nothing should happend, cause ms didnt change')
	else 
		local caster = data.caster
		--TODO find out right getcurrentms
		local ms = data.caster:GetIdealSpeed()
		PrintTable(caster)
		local ms_bonus_percent_damage = data.ability:GetLevelSpecialValueFor("bonus_damage_ms_percent", data.ability:GetLevel() - 1 )
		print('ms '..ms)
		print('percentage '..ms_bonus_percent_damage)
		local average_damage = caster:GetAverageTrueAttackDamage()
		print('average damage'..caster:GetAverageTrueAttackDamage())
		local agility_bonus = caster:GetAgility()
		local add_damage = ms / 100 * ms_bonus_percent_damage
		local max_damage = caster:GetBaseDamageMax()
		local min_damage = caster:GetBaseDamageMin()
		local new_damage_min = min_damage + add_damage
		local new_damage_max = max_damage + add_damage
			print('add damage'..add_damage)
		print('min '..caster:GetBaseDamageMin())
		print('max '..caster:GetBaseDamageMax())
		print('average'..caster:GetAverageTrueAttackDamage())

		caster:SetBaseDamageMax(new_damage_max - agility_bonus)
		caster:SetBaseDamageMin(new_damage_min - agility_bonus)
		
		print('averagee '..caster:GetAverageTrueAttackDamage())
		print('min '..caster:GetBaseDamageMin())
		print('max '..caster:GetBaseDamageMax())
	end 	
	
end

function init_agile_speed( data )
	data.ability.ms = data.caster:GetIdealSpeed()
end