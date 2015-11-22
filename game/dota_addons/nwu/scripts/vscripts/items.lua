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
	Author: Rook
	Date: January 30, 2015
	This function should be called from targeted datadriven abilities that can be blocked by Linken's Sphere.  
	Checks to see if the inputted unit has modifier_item_sphere_target on them.  If they do, the sphere is popped,
	the animation and sound plays, and true is returned.  If they do not, false is returned.
================================================================================================================= ]]
function GameMode:is_spell_blocked_by_linkens_sphere(target)
	if target:HasModifier("modifier_item_sphere_target") then
		target:RemoveModifierByName("modifier_item_sphere_target")  --The particle effect is played automatically when this modifier is removed (but the sound isn't).
		target:EmitSound("DOTA_Item.LinkensSphere.Activate")
		return true
	end
	if target:HasModifier("modifier_roshan_spell_block") then
--		target:RemoveModifierByName("modifier_roshan_spell_block")  --The particle effect is played automatically when this modifier is removed (but the sound isn't).
		print("TODO: fix rosh spellblock cd")
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
	
	if( GameMode:is_spell_blocked_by_linkens_sphere(event.target) )then
		print("spellblocked")
		return
	end
	
	print("path "..filePath)
	print("function "..functionName)
	require(filePath)
	
	_G[functionName](event);

	print("success")
end