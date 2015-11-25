require('utilities')


function createBlock( keys )
	if not keys.caster:HasModifier("modifier_chakra_armor") then
		keys.ability:ApplyDataDrivenModifier(keys.caster, keys.caster, "modifier_chakra_armor", nil)
	end
	if not keys.caster:HasModifier("modifier_item_sphere_target") then
		keys.target:AddNewModifier(keys.caster, keys.ability, "modifier_item_sphere_target", nil)
	end
end

function removeBlock( keys )
	keys.caster:RemoveModifierByName("modifier_chakra_armor")
	keys.caster:RemoveModifierByName("modifier_item_sphere_target")
end

function checkBlock( keys )
	if not keys.caster:HasModifier("modifier_chakra_armor") and keys.ability:IsCooldownReady() and not keys.caster:HasModifier("modifier_item_sphere_target") then
		keys.ability:ApplyDataDrivenModifier(keys.caster, keys.caster, "modifier_chakra_armor", nil)
		keys.target:AddNewModifier(keys.caster, keys.ability, "modifier_item_sphere_target", nil)
	end
end


--[[Author: LearningDave
  Date: november, 16th 2015.
  Changes the displayed icon of a item depending on the hero's gender
]]
function chakraArmorChangeIcon(player, itemName)
	local hero = player:GetAssignedHero()
    local gender = GameRules.heroKV[hero:GetName()]["Gender"] 
    local itemIndex = GameMode:GetItemIndex(itemName, hero)
	local newItemName = "item_chakra_armor_" .. gender
	hero:RemoveItem(hero:GetItemInSlot(itemIndex))
    hero:AddItem(CreateItem(newItemName, hero, hero))
end
