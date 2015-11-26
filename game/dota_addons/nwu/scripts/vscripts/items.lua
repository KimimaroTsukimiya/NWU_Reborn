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

function GenericSpellFunction(event)
	local modifier1 = event.Modifier1
	local modifier2 = event.Modifier2
	local doDamage = event.doDamage
	local caster = event.caster
	local target = event.target
	local ability = event.ability
	local ability_level = ability:GetLevel() - 1
	
	if modifier1 then
		local duration1 = event.Duration1
	
		ability:ApplyDataDrivenModifier(
			caster,
			target,
			modifier1,
			{
				duration = duration1
			}
		)
	end
	
	if modifier2 then
		local duration2 = event.Duration2
	
		ability:ApplyDataDrivenModifier(
			caster,
			target,
			modifier2,
			{
				duration = duration2
			}
		)
	end
	
	if doDamage then
		local damage = ability:GetLevelSpecialValueFor("damage", ability_level)
		ApplyDamage({
			attacker = caster,
			victim = target,
			ability = ability,
			damage = damage,
			damage_type = ability:GetAbilityDamageType(),
			ability=ability
		})
	end
end

--[[
	Author: Mognakor
	Test function for simple Linkens
]]--
function CheckForSpellBlock(event)
	local filePath = event.filePath
	local functionName = event.functionName
	
	if( not(event.target:IsMagicImmune()) or event.PierceMagicImmune)then		
		if( GameMode:is_spell_blocked_by_chakra_armor(event.target) )then
			return
		end
	else
		return
	end
	
	if event.GenericFunction ~= nil then
		_G[event.GenericFunction](event);
		return;
	end
	
	if filePath and functionName then
		require(filePath)
		_G[functionName](event);
	end
end