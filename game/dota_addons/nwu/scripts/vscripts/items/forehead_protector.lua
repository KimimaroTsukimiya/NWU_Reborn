require('utilities')
--[[Author: LearningDave
  Date: october, 19th 2015.
  Changes the displayed icon of a item depending on the hero's origin(village)
]]
function foreheadProtectorChangeIcon(player, itemName)
	local hero = player:GetAssignedHero()
    local village = GameRules.heroKV[hero:GetName()]["Village"] 
    local itemIndex = GameMode:GetItemIndex(itemName, hero)
	local newItemName = "item_forehead_protector_" .. village
	hero:RemoveItem(hero:GetItemInSlot(itemIndex))
    hero:AddItem(CreateItem(newItemName, hero, hero))
end
