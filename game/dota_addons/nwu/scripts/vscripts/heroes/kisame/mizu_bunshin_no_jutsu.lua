-- Creates an Illusion, making use of the built in modifier_illusion
function ConjureImage( event )

 local caster = event.caster
 local player = caster:GetPlayerID()
 local ability = event.ability
 local unit_name = caster:GetUnitName()
 local origin = caster:GetAbsOrigin() + RandomVector(100)
 local duration = ability:GetLevelSpecialValueFor( "illusion_duration", ability:GetLevel() - 1 )
 local damage_percentage = ability:GetLevelSpecialValueFor( "damage_percentage", ability:GetLevel() - 1 )
local illusion_max_hp_percentage = ability:GetLevelSpecialValueFor( "illusion_max_hp_percentage", ability:GetLevel()-1)

 -- handle_UnitOwner needs to be nil, else it will crash the game.
 local illusion = CreateUnitByName("kisame_bunshin", origin, true, caster, nil, caster:GetTeamNumber())
 PrintTable(illusion)
 
 illusion:SetControllableByPlayer(player, true)
 
 --if kisame has his ulti activated, his bunshin should turn into the shark model and have the water prison modifier
 if caster:HasModifier("modifier_kisame_metamorphosis") then 
    illusion:SetOriginalModel("models/kisame_new/kisame_samehada.vmdl")
 end



 -- Set the unit as an illusion
 -- modifier_illusion controls many illusion properties like +Green damage not adding to the unit damage, not being able to cast spells and the team-only blue particle 
ability:ApplyDataDrivenModifier(caster, illusion, "modifier_water_bunshin",  {duration = duration})
ability:ApplyDataDrivenModifier(caster, illusion, "modifier_water_bunshin_bonus_damage",  {duration = duration})

 


 GameMode:RemoveWearables( illusion )

illusion:RemoveAbility(caster:GetAbilityByIndex(1):GetName())
illusion:SetForwardVector(caster:GetForwardVector())

-- add water prison (channeled hold) to bunshin
AbilityWater = illusion:FindAbilityByName("kisame_bunshin_water_prison")
AbilityWater:SetAbilityIndex(0)
AbilityWater:SetLevel(event.ability:GetLevel())

-- add water prison (channeled hold) to bunshin
AbilityWater = illusion:FindAbilityByName("kisame_samehada_bunshin")
AbilityWater:SetAbilityIndex(1)
AbilityWater:SetLevel(event.ability:GetLevel())


 print(illusion:GetMaxHealth())
 illusion:SetMaxHealth(caster:GetMaxHealth() / 100 * illusion_max_hp_percentage)
 print(illusion:GetMaxHealth())

 local hp_caster_percentage = caster:GetHealth() / (caster:GetMaxHealth() / 100)
 illusion:SetHealth(illusion:GetMaxHealth() / 100 * hp_caster_percentage)

illusion:SetBaseDamageMin(caster:GetAverageTrueAttackDamage() / 100 * damage_percentage)
illusion:SetBaseDamageMax(caster:GetAverageTrueAttackDamage() / 100 * damage_percentage)

illusion:SetOriginalModel(caster:GetModelName())




--local bonus_damage_preattack = caster:GetBonusDamageFromPrimaryStat() / 100 * damage_percentage
--caster:SetModifierStackCount( "modifier_water_bunshin_bonus_damage", ability, bonus_damage_preattack)

end
function NoDraw( keys )
  keys.caster:AddNoDraw()

end
function draw( keys )
  keys.caster:RemoveNoDraw()
end

function RemoveBunshin( keys )
  keys.target:Destroy()
end