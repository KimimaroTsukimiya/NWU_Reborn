--[[
	Author: Mognakor (recode)
	Date: december, 4th 2015.
	Gives the caster the 2nd Ability of the target.
]]
function sharingan( keys )
	local caster = keys.caster
	local target = keys.target
	local ability_level = keys.ability:GetLevel()
	local copy_timer =  old_ability:GetLevelSpecialValueFor("copy_timer", (old_ability:GetLevel() - 1))
	
	if target == caster or target:GetOwner() == caster:GetOwner() then
		return
	end
	
	if( caster.sharingan_ability ) then
		caster:SwapAbilities("kakashi_empty", caster.sharingan_ability, true, false)
		caster:RemoveAbility(caster.sharingan_ability)
	end
	
	local ability1_name = target:GetAbilityByIndex(1):GetName()
	caster:AddAbility(ability1_name)

	caster:SwapAbilities("kakashi_empty", ability1_name, false, true)
	caster.sharingan_ability = ability1_name
	
	Timers:CreateTimer( copy_timer,
			function()
				caster:SwapAbilities("kakashi_empty", caster.sharingan_ability, true, false)
				caster:RemoveAbility(caster.sharingan_ability)
				caster.sharingan_ability =  nil
				return nil
			end
			)
end