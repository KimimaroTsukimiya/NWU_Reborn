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

--[[Author: https://github.com/MNoya/DotaCraft/blob/01a29892b124f695cadd0a134afb8d056c83015a/game/dota_addons/dotacraft/scripts/vscripts/utilities.lua
]]
function tableContains(list, element)
    if list == nil then return false end
    for i=1,#list do
        if list[i] == element then
            return true
        end
    end
    return false
end
--[[Author: https://github.com/MNoya/DotaCraft/blob/01a29892b124f695cadd0a134afb8d056c83015a/game/dota_addons/dotacraft/scripts/vscripts/utilities.lua
]]
function getIndex(list, element)
    if list == nil then return false end
    for i=1,#list do
        if list[i] == element then
            return i
        end
    end
    return -1
end
--[[Author: https://github.com/MNoya/DotaCraft/blob/01a29892b124f695cadd0a134afb8d056c83015a/game/dota_addons/dotacraft/scripts/vscripts/utilities.lua
]]
function getUnitIndex(list, unitName)
    -- print("Given Table")
    --DeepPrintTable(list)
    if list == nil then return false end
    for k,v in pairs(list) do
        for key,value in pairs(list[k]) do
            -- print(key,value)
            if value == unitName then 
                return key
            end
        end        
    end
    return -1
end
--[[Author: https://github.com/MNoya/DotaCraft/blob/01a29892b124f695cadd0a134afb8d056c83015a/game/dota_addons/dotacraft/scripts/vscripts/utilities.lua
]]
function getIndexTable(list, element)
    if list == nil then return false end
    for k,v in pairs(list) do
        if v == element then
            return k
        end
    end
    return -1
end
--[[Author: https://github.com/MNoya/DotaCraft/blob/01a29892b124f695cadd0a134afb8d056c83015a/game/dota_addons/dotacraft/scripts/vscripts/utilities.lua
]]
function shallowcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in pairs(orig) do
            copy[orig_key] = orig_value
        end
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end
--[[Author: https://github.com/MNoya/DotaCraft/blob/01a29892b124f695cadd0a134afb8d056c83015a/game/dota_addons/dotacraft/scripts/vscripts/utilities.lua
]]
function ShuffledList( orig_list )
    local list = shallowcopy( orig_list )
    local result = {}
    local count = #list
    for i = 1, count do
        local pick = RandomInt( 1, #list )
        result[ #result + 1 ] = list[ pick ]
        table.remove( list, pick )
    end
    return result
end
--[[Author: https://github.com/MNoya/DotaCraft/blob/01a29892b124f695cadd0a134afb8d056c83015a/game/dota_addons/dotacraft/scripts/vscripts/utilities.lua
]]
function TableCount( t )
    local n = 0
    for _ in pairs( t ) do
        n = n + 1
    end
    return n
end
--[[Author: https://github.com/MNoya/DotaCraft/blob/01a29892b124f695cadd0a134afb8d056c83015a/game/dota_addons/dotacraft/scripts/vscripts/utilities.lua
]]
function TableFindKey( table, val )
    if table == nil then
        print( "nil" )
        return nil
    end

    for k, v in pairs( table ) do
        if v == val then
            return k
        end
    end
    return nil
end
--[[Author: https://github.com/MNoya/DotaCraft/blob/01a29892b124f695cadd0a134afb8d056c83015a/game/dota_addons/dotacraft/scripts/vscripts/utilities.lua
]]
function split(inputstr, sep)
    if sep == nil then
            sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
            t[i] = str
            i = i + 1
    end
    return t
end
--[[Author: https://github.com/MNoya/DotaCraft/blob/01a29892b124f695cadd0a134afb8d056c83015a/game/dota_addons/dotacraft/scripts/vscripts/utilities.lua
]]
function StringStartsWith( fullstring, substring )
    local strlen = string.len(substring)
    local first_characters = string.sub(fullstring, 1 , strlen)
    return (first_characters == substring)
end
--[[Author: https://github.com/MNoya/DotaCraft/blob/01a29892b124f695cadd0a134afb8d056c83015a/game/dota_addons/dotacraft/scripts/vscripts/utilities.lua
]]
function DebugPrint(...)
    local spew = Convars:GetInt('debug_spew') or -1
    if spew == -1 and DEBUG_SPEW then
        spew = 1
    end

    if spew == 1 then
        print(...)
    end
end
--[[Author: https://github.com/MNoya/DotaCraft/blob/01a29892b124f695cadd0a134afb8d056c83015a/game/dota_addons/dotacraft/scripts/vscripts/utilities.lua
]]
function VectorString(v)
    return '[' .. math.floor(v.x) .. ', ' .. math.floor(v.y) .. ', ' .. math.floor(v.z) .. ']'
end
--[[Author: https://github.com/MNoya/DotaCraft/blob/01a29892b124f695cadd0a134afb8d056c83015a/game/dota_addons/dotacraft/scripts/vscripts/utilities.lua
]]
function tobool(s)
    if s=="true" or s=="1" or s==1 then
        return true
    else --nil "false" "0"
        return false
    end
end