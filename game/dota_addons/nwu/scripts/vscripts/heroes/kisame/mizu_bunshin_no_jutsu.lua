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
 illusion:SetOwner(caster)
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
illusion:AddNoDraw()
table.insert(event.ability.bunshins, illusion)


--local bonus_damage_preattack = caster:GetBonusDamageFromPrimaryStat() / 100 * damage_percentage
--caster:SetModifierStackCount( "modifier_water_bunshin_bonus_damage", ability, bonus_damage_preattack)

end
function NoDraw( keys )
  keys.caster:AddNoDraw()
  keys.ability.bunshins = {}
  keys.caster:Stop()


 local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_siren/naga_siren_mirror_image.vpcf", PATTACH_ABSORIGIN_FOLLOW, keys.caster)
ParticleManager:SetParticleControl(particle, 0, keys.caster:GetAbsOrigin()) -- Origin

  keys.ability.bunshinParticle = particle
end


function draw( keys )
  local locationTable = {}
  local first = false
  local second = false
  local third = false
  local finished = false
  table.insert(locationTable, keys.caster:GetAbsOrigin())
  keys.caster:RemoveNoDraw()
  for key,oneBunshin in pairs(keys.ability.bunshins) do 
  	table.insert(locationTable, oneBunshin:GetAbsOrigin())
  	FindClearSpaceForUnit(oneBunshin, oneBunshin:GetAbsOrigin() + Vector(100, 100, 0), true)
  end
  local random = math.random()
  print("1")
    while not finished do
     	random = math.random()
     	print(random)
     	if random < 0.331 then
     		if not first then
     			FindClearSpaceForUnit(caster, locationTable[1], true)
     			finished = true
     			first = true
     		end
     	elseif random < 0.661 then
     		if not second then
	     		FindClearSpaceForUnit(caster, locationTable[2], true)
	     		finished = true
	     		second = true
     		end
     	elseif random < 1.01 then
     		if not third then
	     		FindClearSpaceForUnit(caster, locationTable[3], true)
	     		finished = true
	     		third = true
     		end
     	end
    end
    finished = false
    print("2")
     while not finished do
     	random = math.random()
     	print(random)
     	if random < 0.331 then
     		if not first then
     			FindClearSpaceForUnit(keys.ability.bunshins[1], locationTable[1], true)
     			finished = true
     			first = true
     		end
     	
     	elseif random < 0.661 then
     		if not second then
	     		FindClearSpaceForUnit(keys.ability.bunshins[1], locationTable[2], true)
	     		finished = true
	     		second = true
     		end
     	elseif random < 1.01 then
     		if not third then
	     		FindClearSpaceForUnit(keys.ability.bunshins[1], locationTable[3], true)
	     		finished = true
	     		third = true
	     	end
     	end
    end
    finished = false;
    print("3")

    while not finished do
     	random = math.random()
     	print(random)
     	print(first)
     	print(second)
     	print(third)
     	if random < 0.331 then
     		if not first then
     			FindClearSpaceForUnit(keys.ability.bunshins[2], locationTable[1], true)
     			finished = true
     			first = true
     		end
     	elseif random < 0.661 then
     		if not second then
	     		FindClearSpaceForUnit(keys.ability.bunshins[2], locationTable[2], true)
	     		finished = true
	     		second = true
     		end
     	
     	elseif random < 1.01 then
     		if not third then
	     		FindClearSpaceForUnit(keys.ability.bunshins[2], locationTable[3], true)
	     		finished = true
	     		third = true
	     	end
     	end
    end
    print("4")
 	keys.caster:RemoveNoDraw()
 	 for key,oneBunshin in pairs(keys.ability.bunshins) do 
 	 	oneBunshin:RemoveNoDraw()
  	end
    ParticleManager:DestroyParticle(keys.ability.bunshinParticle, true)
end

function RemoveBunshin( keys )
  keys.target:Destroy()
end

