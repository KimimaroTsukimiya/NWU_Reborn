--[[ ============================================================================================================
	Author: Rook
	Date: January 25, 2015
	A helper method that switches the keys.ability item to one with the inputted name.
================================================================================================================= ]]
function swap_to_item(keys, ItemName)
	for i=0, 5, 1 do  --Fill all empty slots in the player's inventory with "dummy" items.
		local current_item = keys.caster:GetItemInSlot(i)
		if current_item == nil then
			keys.caster:AddItem(CreateItem("item_dummy_datadriven", keys.caster, keys.caster))
		end
	end
	
	keys.caster:RemoveItem(keys.ability)
	local trends = CreateItem(ItemName, keys.caster, keys.caster)  --This should be put into the same slot that the removed item was in.
	keys.caster:AddItem(trends)
	
	for i=0, 5, 1 do  --Remove all dummy items from the player's inventory.
		local current_item = keys.caster:GetItemInSlot(i)
		if current_item ~= nil then
			if current_item:GetName() == "item_dummy_datadriven" then
				keys.caster:RemoveItem(current_item)
			end
		end
	end
end


--[[ ============================================================================================================
	Author: Rook
	Date: January 25, 2015
	Called when Power Treads (Strength) is cast.  Swaps the item to Power Treads (Intelligence).
================================================================================================================= ]]
function strength_on_spell_start(keys)
	swap_to_item(keys, "item_shinobi_trends_int")
end


--[[ ============================================================================================================
	Author: Rook
	Date: January 25, 2015
	Called when Power Treads (Agility) is cast.  Swaps the item to Power Treads (Strength).
================================================================================================================= ]]
function agi_on_spell_start(keys)
	swap_to_item(keys, "item_shinobi_trends_str")
end


--[[ ============================================================================================================
	Author: Rook
	Date: January 25, 2015
	Called when Power Treads (Intelligence) is cast.  Swaps the item to Power Treads (Agility).
================================================================================================================= ]]
function int_on_spell_start(keys)
	swap_to_item(keys, "item_shinobi_trends_agi")
end