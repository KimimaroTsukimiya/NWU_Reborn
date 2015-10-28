LinkLuaModifier( "modifier_guy_power_of_youth" , "heroes/guy/modifiers/modifier_guy_power_of_youth.lua" , LUA_MODIFIER_MOTION_NONE )

function power_of_youth_initiate( keys )
	keys.ability.stacks = 0
	keys.ability.attack_speed = keys.caster:GetAttackSpeed()
	keys.ability.same_target = 0
	keys.ability.new_attack_speed = 0
end

function power_of_youth( keys )
	print("test")

	keys.caster:RemoveModifierByName("modifier_guy_power_of_youth")
	local caster = keys.caster
	local ability = keys.ability
	local target = keys.target
	local attack_speed_bonus_percentage = ability:GetLevelSpecialValueFor( "bonus_attack_speed", ability:GetLevel() - 1)
	local stacks = ability.stacks
	local attack_speed = keys.ability.attack_speed
	local new_attack_speed = attack_speed
	local sametarget = keys.same_target
	if keys.ability.same_target ~= 0 then
		if keys.ability.same_target == target then
			keys.ability.stacks = keys.ability.stacks + 1
		else
			keys.ability.stacks = keys.ability.stacks / 2
		end
	end
	if (keys.ability.stacks * attack_speed_bonus_percentage) < 100 and keys.ability.stacks > 0 then
		new_attack_speed = ((keys.ability.stacks * attack_speed_bonus_percentage) * (attack_speed / 100)) + attack_speed
	elseif  (keys.ability.stacks * attack_speed_bonus_percentage) >= 100 and keys.ability.stacks > 0 then
		new_attack_speed = attack_speed * 2
	end	
	keys.ability.same_target = target
	print(new_attack_speed)

	keys.ability.new_attack_speed = new_attack_speed
	keys.caster:AddNewModifier(keys.caster, keys.caster, "modifier_guy_power_of_youth", {})
end