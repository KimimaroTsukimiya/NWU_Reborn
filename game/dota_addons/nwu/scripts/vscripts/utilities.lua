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
--[[Author: LearningDave
  Date: october, 19th 2015.
  Kills a given unit, if its 'NeutralUnitType'
]]
function GameMode:KillUnit( unit )
  if unit:IsNeutralUnitType() then
    unit:ForceKill(false)

  else
    print("Given unit is not a neutral unit type, didn't kill it.")
  end
end
--[[Author: LearningDave
  Date: october, 19th 2015.
  Recursive function, starts a timer which changing stacks of a item/ability until the max stacks are reached
]]
function GameMode:StackItem( cd, max_stacks, modifier_name, ability, caster)
  if not ability.shortCD then
  ability.shortCD = true
  --show the player the cooldown
  ability:StartCooldown(cd)
  --start a timer once its reached do something
  Timers:CreateTimer( cd, function()
    print("timer started")
    --if the current stack didnt reach its max limit repeat the former steps (didnt know how to include recursion with timers)
    if ability.current_stacks < max_stacks then
      ability.shortCD = false
      ability.current_stacks = ability.current_stacks + 1
      ability:StartCooldown(cd)
      caster:SetModifierStackCount( modifier_name, ability, ability.current_stacks)
      -- calls a function which basicly does the same until max stacks are reached. 
      if ability.current_stacks < max_stacks then
        GameMode:StackItem(cd, max_stacks, modifier_name, ability, caster)
      end
    end
  return nil
  end
  )
end
end