--[[
	Author: LearningDave
	Date: october, 5th 2015.
	Gives the caster the 2nd Ability of the target.
]]
function sharingan( keys )
	local caster = keys.caster
	local target = keys.target
	local ability_level = keys.ability:GetLevel()
	local old_ability = keys.ability
	local copy_timer =  old_ability:GetLevelSpecialValueFor("copy_timer", (old_ability:GetLevel() - 1))
	local duration = keys.ability:GetDuration()
	if target ~= caster then
		if caster:GetAbilityByIndex(4):GetName()  ~= nil then
			caster:RemoveAbility(caster:GetAbilityByIndex(4):GetName())
		end
		Ability = caster:AddAbility(target:GetAbilityByIndex(1):GetName())
		Ability:SetAbilityIndex(4)
		Ability:SetLevel(ability_level)
		Timers:CreateTimer( copy_timer, function()
			caster:RemoveAbility(target:GetAbilityByIndex(4):GetName())
		return nil
		end
		)
	end
end