
--[[ ============================================================================================================
	Author: Rook
	Date: February 2, 2015
	Called when a Battle Fury is acquired.  Grants the cleave modifier if the caster is a melee hero.
================================================================================================================= ]]
function modifier_hardened_skin_on_created(keys)
	if not keys.caster:IsRangedAttacker() then
		keys.caster:RemoveModifierByName("shin_guards_block_range")
	else
		keys.caster:RemoveModifierByName("shin_guards_block_melee")
	end
end


--[[ ============================================================================================================
	Author: Rook
	Date: February 2, 2015
	Called when a Battle Fury is removed from the caster's inventory.  Removes a cleave modifier if they are a melee hero.
================================================================================================================= ]]
function modifier_hardened_skin_on_destroy(keys)
	if not keys.caster:IsRangedAttacker() then
		keys.caster:RemoveModifierByName("shin_guards_block_melee")
	else
		keys.caster:RemoveModifierByName("shin_guards_block_range")
	end
end




