function power_of_youth( keys )
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	local ability_level = ability:GetLevel() - 1
	local modifier = keys.modifier
	local max_stacks = ability:GetLevelSpecialValueFor("max_stacks", ability_level)

	--Prevent Sharingan
	if(not caster:HasAbility("guy_power_of_youth") )then
		caster:RemoveModifierByName("modifier_guy_power_of_youth")
		caster:RemoveModifierByName(modifier)
	end
	
	-- Check if we have an old target
	if caster.POY_target == nil then
		caster.POY_target = target
		return
	end
	
	-- Check if the caster has the attack speed modifier
	if not caster:HasModifier(modifier) then
		-- Apply the attack speed modifier and set the starting stack number
		ability:ApplyDataDrivenModifier(caster, caster, modifier, {})
		caster:SetModifierStackCount(modifier, ability, 1)
		return
	end
	
	-- Get the current stacks
	local stack_count = caster:GetModifierStackCount(modifier, ability)
	
	-- Check if that old target is the same as the attacked target
	if caster.POY_target ~= target then
		-- If its not the same target then set it as the new target and remove the modifier
		caster:SetModifierStackCount(modifier, ability, 1)
		caster.POY_target = target
		return
	end
	
	-- Check if the current stacks are lower than the maximum allowed
	if stack_count < max_stacks then
		-- Increase the count if they are
		caster:SetModifierStackCount(modifier, ability, stack_count + 1)
	end
	
end