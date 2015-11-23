--[[Handling the stacking of Temari's Sheer Wind ability
	Author: Zenicus
	Date: November 22, 2015.]]
function sheer_wind( keys )
	local caster = keys.caster
	local ability = keys.ability
	local maxStack = ability:GetLevelSpecialValueFor("sheer_wind_max_stacks", (ability:GetLevel() - 1))
	local modifierCount = caster:GetModifierCount()
	local currentStack = 0
	local modifierBuffName = "modifier_sheer_wind_buff"
	local modifierStackName = "modifier_sheer_wind_buff_stack"
	local modifierName

	-- Always remove the stack modifier
	caster:RemoveModifierByName(modifierStackName) 

	-- Counts the current stacks
	for i = 0, modifierCount do
		modifierName = caster:GetModifierNameByIndex(i)

		if modifierName == modifierBuffName then
			currentStack = currentStack + 1
		end
	end

	-- Remove all the old buff modifiers
	for i = 0, currentStack do
		caster:RemoveModifierByName(modifierBuffName)
	end

	-- Always apply the stack modifier 
	ability:ApplyDataDrivenModifier(caster, caster, modifierStackName, {})

	-- Reapply the maximum number of stacks
	if currentStack >= maxStack then
		caster:SetModifierStackCount(modifierStackName, ability, maxStack)

		-- Apply the new refreshed stack
		for i = 1, maxStack do
			ability:ApplyDataDrivenModifier(caster, caster, modifierBuffName, {})
		end
	else
		-- Increase the number of stacks
		currentStack = currentStack + 1

		caster:SetModifierStackCount(modifierStackName, ability, currentStack)

		-- Apply the new increased stack
		for i = 1, currentStack do
			ability:ApplyDataDrivenModifier(caster, caster, modifierBuffName, {})
		end
	end
end