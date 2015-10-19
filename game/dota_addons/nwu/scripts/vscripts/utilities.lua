--[[Author: LearningDave
  Date: october, 19th 2015.
  returns the index of a item from a given UnitEntity and itemname
]]
function GameMode:GetItemIndex(itemnName, unitEntity)
  local itemIndex = 0
  local counter = 0
  if unitEntity:HasItemInInventory(itemnName) then
        for i=0,5 do 
         if unitEntity:GetItemInSlot(i) ~= nil then
           if unitEntity:GetItemInSlot(i):GetName() == itemnName then
             itemIndex = counter
            end 
          end 
        counter = counter + 1
       end
  else
    return nil
  end
  return itemIndex
end