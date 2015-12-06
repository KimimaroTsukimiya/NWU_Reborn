--[[Author: Amused/D3luxe
	Used by: Pizzalol
	Date: 11.07.2015.
	Blinks the target to the target point, if the point is beyond max blink range then blink the maximum range]]
function Blink(keys)

	local point = keys.target_points[1]
	local caster = keys.caster
	keys.ability.old_position = caster:GetAbsOrigin()
	local casterPos = caster:GetAbsOrigin()
	local pid = caster:GetPlayerID()
	local difference = point - casterPos
	local ability = keys.ability
	local range = ability:GetLevelSpecialValueFor("blink_range", (ability:GetLevel() - 1))
	caster:AddNoDraw()
	if difference:Length2D() > range then
		point = casterPos + (point - casterPos):Normalized() * range
	end

	FindClearSpaceForUnit(caster, point, false)
	ProjectileManager:ProjectileDodge(caster)
	caster:RemoveNoDraw()

end


-- Creates an Illusion, making use of the built in modifier_illusion
function createBunshin( event )

 local caster = event.caster
 local player = caster:GetPlayerID()
 local ability = event.ability
 local unit_name = caster:GetUnitName()
 local origin = caster:GetAbsOrigin() + RandomVector(100)
 local duration = ability:GetLevelSpecialValueFor( "illusion_duration", ability:GetLevel() - 1 )
 local outgoingDamage = 0
 local incomingDamage = 100

 -- handle_UnitOwner needs to be nil, else it will crash the game.
 local illusion = CreateUnitByName(unit_name, origin, true, caster, nil, caster:GetTeamNumber())
 illusion:SetPlayerID(caster:GetPlayerID())
 illusion:SetControllableByPlayer(player, true)
 

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
 illusion:SetForwardVector(caster:GetForwardVector())


 -- Set the unit as an illusion

 event.ability:ApplyDataDrivenModifier(caster, illusion, "itachi_crow_bunshin", { duration = duration})
 -- Without MakeIllusion the unit counts as a hero, e.g. if it dies to neutrals it says killed by neutrals, it respawns, etc.
 illusion:MakeIllusion()
 illusion:SetHealth(caster:GetHealth())
 FindClearSpaceForUnit(illusion, event.ability.old_position, false)
 event.ability.bunshin = illusion
 GameMode:RemoveWearables( illusion )

end

function killBunshin( keys )
	if keys.ability.bunshin:IsAlive() then
		local position  = keys.ability.bunshin:GetAbsOrigin()
		keys.ability.bunshin:Destroy()
		local duration = keys.ability:GetLevelSpecialValueFor( "illusion_duration", keys.ability:GetLevel() - 1 )
		-- Dummy
		local dummy_modifier = keys.dummy_particle
		local dummy = CreateUnitByName("npc_dummy_unit", position, false, keys.caster, keys.caster, keys.caster:GetTeam())
		dummy:AddNewModifier(caster, nil, "modifier_phased", {})
		keys.ability:ApplyDataDrivenModifier(keys.caster, dummy, dummy_modifier, {duration = duration})
		EmitSoundOn("itachi_crows", dummy)

		-- Timer to remove the dummy
		Timers:CreateTimer(duration, function() dummy:RemoveSelf() end)
		
		local crows = ParticleManager:CreateParticle("particles/world_creature_fx/crows.vpcf", PATTACH_ABSORIGIN, dummy)
		Timers:CreateTimer( 4, function()
				ParticleManager:DestroyParticle(crows, false)
				return nil
			end
		)
	end
end

function destroyBunshin( keys )
	print("test")
	local duration = keys.ability:GetLevelSpecialValueFor( "illusion_duration", keys.ability:GetLevel() - 1 )
		-- Dummy
	local dummy_modifier = keys.dummy_particle
	local dummy = CreateUnitByName("npc_dummy_unit", keys.ability.bunshin:GetAbsOrigin(), false, keys.caster, keys.caster, keys.caster:GetTeam())
	dummy:AddNewModifier(caster, nil, "modifier_phased", {})
	keys.ability:ApplyDataDrivenModifier(keys.caster, dummy, "modifier_itachi_crows", {duration = duration})
	
	EmitSoundOn("itachi_crows", dummy)
		-- Timer to remove the dummy
	Timers:CreateTimer(duration, function() dummy:RemoveSelf() end)
		
	local crows = ParticleManager:CreateParticle("particles/world_creature_fx/crows.vpcf", PATTACH_ABSORIGIN, dummy)
	Timers:CreateTimer( 4, function()
		ParticleManager:DestroyParticle(crows, false)
				return nil
			end
		)
	keys.ability.bunshin:Destroy()
end