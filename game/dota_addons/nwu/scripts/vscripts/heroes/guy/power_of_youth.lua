--[[
  Author: LearningDave
  Date: October, 28th 2015
  Initiates the variables which are needed for 'power_of_youth'
]]
function power_of_youth_initiate( keys )
	keys.ability.stacks = 0
	keys.ability.attack_speed = keys.caster:GetAttackSpeed()
	keys.ability.same_target = 0
	keys.ability.new_attack_speed = 0
end
--[[
  Author: LearningDave
  Date: October, 28th 2015
  Stacks Guy's attackspeed if he is hitting the same target, if not bonus is devicded by 2 (max 100)
]]
function power_of_youth( keys )
	local caster = keys.caster
	local ability = keys.ability
	local target = keys.target
	local attack_speed_bonus_percentage = ability:GetLevelSpecialValueFor( "bonus_attack_speed", ability:GetLevel() - 1)
	local stacks = ability.stacks
	local attack_speed = keys.ability.attack_speed
	local new_attack_speed = attack_speed
	local sametarget = keys.same_target
	if keys.ability.same_target == target then
		keys.ability.stacks = keys.ability.stacks + 1
	else
		if keys.ability.stacks ~= 0 then
			if (keys.ability.stacks * attack_speed_bonus_percentage) >= 100 then
				keys.ability.stacks = tonumber(string.format("%." ..  0 .. "f", (100 / attack_speed_bonus_percentage  / 2)))
			else
				keys.ability.stacks = keys.ability.stacks / 2
			end
			
		else
			keys.ability.stacks = 1
		end
	end	
	if (keys.ability.stacks * attack_speed_bonus_percentage) < 100 and keys.ability.stacks > 0 then
		new_attack_speed = keys.ability.stacks * attack_speed_bonus_percentage
	elseif  (keys.ability.stacks * attack_speed_bonus_percentage) >= 100 and keys.ability.stacks > 0 then
		new_attack_speed = 100
	end	
	keys.ability.same_target = target
	if new_attack_speed > 100 then
		new_attack_speed = 100
	end
	--SetModifierStackCount does MULTIPLY ALL properties of the modifier with the 3rd parameter!!!
	caster:SetModifierStackCount("modifier_guy_power_of_youth_as_bonus", caster, new_attack_speed)
end