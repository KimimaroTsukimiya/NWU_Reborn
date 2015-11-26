-- Creates an Illusion, making use of the built in modifier_illusion
function ConjureImage( event )

 local caster = event.caster
 local player = caster:GetPlayerID()
 local ability = event.ability
 local unit_name = caster:GetUnitName()
 local origin = caster:GetAbsOrigin() + RandomVector(100)
 local duration = ability:GetLevelSpecialValueFor( "illusion_duration", ability:GetLevel() - 1 )
 local outgoingDamage = ability:GetLevelSpecialValueFor( "illusion_outgoing_damage_percent", ability:GetLevel()-1)
 local incomingDamage = ability:GetLevelSpecialValueFor( "illusion_incoming_damage_percent", ability:GetLevel()-1)

 -- handle_UnitOwner needs to be nil, else it will crash the game.
 local illusion = CreateUnitByName(unit_name, origin, true, caster, nil, caster:GetTeamNumber())
 PrintTable(illusion)
 illusion:SetPlayerID(caster:GetPlayerID())
 illusion:SetControllableByPlayer(player, true)
 
 --if kisame has his ulti activated, his bunshin should turn into the shark model and have the water prison modifier
 if caster:HasModifier("modifier_kisame_metamorphosis") then 
    illusion:SetOriginalModel("models/kisame_new/kisame_samehada.vmdl")
 end

 -- Level Up the unit to the casters level
 local casterLevel = caster:GetLevel()
 for i=1,casterLevel-1 do
  illusion:HeroLevelUp(false)
 end

 -- Set the skill points to 0 and learn the skills of the caster
 illusion:SetAbilityPoints(0)
 for abilitySlot=0,15 do
  local ability = caster:GetAbilityByIndex(abilitySlot)
  if ability ~= nil then 
   local abilityLevel = ability:GetLevel()
   local abilityName = ability:GetAbilityName()
   local illusionAbility = illusion:FindAbilityByName(abilityName)
   if illusionAbility ~= nil then
    illusionAbility:SetLevel(abilityLevel)
   end
  end
 end

 -- Recreate the items of the caster
 for itemSlot=0,5 do
  local item = caster:GetItemInSlot(itemSlot)
  if item ~= nil then
   local itemName = item:GetName()
   local newItem = CreateItem(itemName, illusion, illusion)
   illusion:AddItem(newItem)
  end
 end


 -- Set the unit as an illusion
 -- modifier_illusion controls many illusion properties like +Green damage not adding to the unit damage, not being able to cast spells and the team-only blue particle 
 illusion:AddNewModifier(caster, ability, "modifier_illusion", { duration = duration, outgoing_damage = outgoingDamage, incoming_damage = incomingDamage })
 illusion:SetHealth(caster:GetHealth())
 -- Without MakeIllusion the unit counts as a hero, e.g. if it dies to neutrals it says killed by neutrals, it respawns, etc.
 illusion:MakeIllusion()
 GameMode:RemoveWearables( illusion )
end
function NoDraw( keys )
  keys.caster:AddNoDraw()

end
function draw( keys )
  print("asb")
  keys.caster:RemoveNoDraw()
end