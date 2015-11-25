require('items/spellthiefs_edge')
require('items/ninja_info_cards')
require('items/chakra_armor')
require('items/forehead_protector')

--[[Author: LearningDave
  Date: october, 19th 2015.
  Fires all functions from SpellThiefsEdge listening to OnEntityKilled
]]
function   GameMode:SupportItemCooldownReset(killedUnit, killerEntity)
  ninjaInfoCardsSetCD(killedUnit, killerEntity)
  ninjaInfoCardsDeny(killedUnit, killerEntity)
 -- spellThiefsEdgeDeny(killedUnit, killerEntity)
  --spellThiefsEdgeCarryLastHit(killedUnit, killerEntity)
end
--[[Author: LearningDave
  Date: october, 19th 2015.
  Fires all functions from Forehead Protector
]]
function   GameMode:ForeheadProtectorOnItemPickedUp(player, itemName)
  foreheadProtectorChangeIcon(player, itemName)

end


function GameMode:ChakraArmorOnItemPickedUp( player, itemName )
	chakraArmorChangeIcon(player, itemName)
end


--[[ ============================================================================================================
	Author: LearningDave
	Date: November, 25th 2015
================================================================================================================= ]]
function GameMode:is_spell_blocked_by_chakra_armor(target)
	if  target:HasModifier("modifier_chakra_armor") then
		target:RemoveModifierByName("modifier_chakra_armor")
		target:RemoveModifierByName("modifier_item_sphere_target")
		local ca = nil
		for i=0, 5, 1 do  --Remove all dummy items from the player's inventory.
				local current_item = target:GetItemInSlot(i)
				if current_item ~= nil then
					if current_item:GetName() == "item_chakra_armor_male" or current_item:GetName() == "item_chakra_armor_female" then
						ca = current_item
					end
			end
		end
		ca:StartCooldown(ca:GetCooldown(1))
		target:EmitSound("DOTA_Item.LinkensSphere.Activate")
		return true
	end
	return false
end

--[[
	Author: Mognakor
	Test function for simple Linkens
]]--
function CheckForSpellBlock(event)
	local filePath = event.filePath
	local functionName = event.functionName
	
	if( GameMode:is_spell_blocked_by_chakra_armor(event.target) )then
		print("spellblocked")
		return
	end
	
	print("path "..filePath)
	print("function "..functionName)
	require(filePath)
	
	_G[functionName](event);

	print("success")
end