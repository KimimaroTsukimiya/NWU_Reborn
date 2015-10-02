--[[ ============================================================================================================
	Author: Rook - Modified LearningDave
	Date: October, 10th 2015
	Called when a Shin Guards is acquired.  Grants the melee block modifier if the caster is a melee hero and the
	range block modifer if the caster is a range hero.
================================================================================================================= ]]
function modifier_item_remi_datadriven_on_created(keys)
	if not keys.caster:IsRangedAttacker() then
		keys.ability:ApplyDataDrivenModifier(keys.caster, keys.caster, "modifier_item_remi_block", {duration = -1})
	else 
		keys.ability:ApplyDataDrivenModifier(keys.caster, keys.caster, "modifier_item_remi_block_range", {duration = -1})
	end
end


--[[ ============================================================================================================
	Author: Rook - Modified LearningDave
	Date: October, 10th 2015
	Called when a Shin guards is removed from the caster's inventory.  Removes the block modifier.
================================================================================================================= ]]
function modifier_item_remi_datadriven_on_destroy(keys)
	if not keys.caster:IsRangedAttacker() then
		keys.caster:RemoveModifierByName("modifier_item_remi_block")
	else 
		keys.caster:RemoveModifierByName("modifier_item_remi_block_range")
	end
end


--[[ ============================================================================================================
	Author: Rook
	Date: February 2, 2015
	Called regularly while the caster has a Battle Fury in their inventory.  If the caster has switched from ranged
	to melee, give them cleave modifier(s).
================================================================================================================= ]]
function modifier_item_remi_datadriven_on_interval_think(keys)
	if not keys.caster:IsRangedAttacker() and not keys.caster:HasModifier("modifier_item_remi_block") then
		for i=0, 5, 1 do
			local current_item = keys.caster:GetItemInSlot(i)
			if current_item ~= nil then
				if current_item:GetName() == "item_remi" then
					keys.ability:ApplyDataDrivenModifier(keys.caster, keys.caster, "modifier_item_remi_block", {duration = -1})
				end
				if keys.caster:HasModifier("modifier_item_remi_block_range") then
					keys.caster:RemoveModifierByName("modifier_item_remi_block_range")
				end
			end
		end
	end

	if keys.caster:IsRangedAttacker() and not keys.caster:HasModifier("modifier_item_remi_block_range") then
		for i=0, 5, 1 do
			local current_item = keys.caster:GetItemInSlot(i)
			if current_item ~= nil then
				if current_item:GetName() == "item_remi" then
					keys.ability:ApplyDataDrivenModifier(keys.caster, keys.caster, "modifier_item_remi_block_range", {duration = -1})
				end
				if keys.caster:HasModifier("modifier_item_remi_block") then
					keys.caster:RemoveModifierByName("modifier_item_remi_block")
				end
			end
		end
	end

end


--[[ ============================================================================================================
	Author: Rook
	Date: February 2, 2015
	Called regularly while the caster has at least one cleave modifier from Battle Fury.  If the caster is no longer
	melee (which would be the case on, for example, Troll Warlord), remove the cleave modifiers from the caster.
================================================================================================================= ]]
function modifier_item_remi_block_on_interval_think(keys)
	if keys.caster:IsRangedAttacker() then
		while keys.caster:HasModifier("modifier_item_remi_block") do
			keys.caster:RemoveModifierByName("modifier_item_remi_block")
		end
	else 
		while keys.caster:HasModifier("modifier_item_remi_block_range") do
			keys.caster:RemoveModifierByName("modifier_item_remi_block_range")
		end
	end
end
