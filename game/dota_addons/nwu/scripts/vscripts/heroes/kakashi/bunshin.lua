-- Creates an Illusion, making use of the built in modifier_illusion
function ConjureImage( event )
	print("Conjure Image")
	local caster = event.caster
	local player = caster:GetPlayerID()
	local ability = event.ability
	local unit_name = caster:GetUnitName()
	local origin = caster:GetAbsOrigin()	-- + RandomVector(100)
	local duration = ability:GetLevelSpecialValueFor( "illusion_duration", ability:GetLevel() - 1 )
	local run_to_position = caster:GetAbsOrigin() + 400 * caster:GetForwardVector():Normalized() 
	local outgoingDamage = ability:GetLevelSpecialValueFor( "illusion_outgoing_damage_percent", ability:GetLevel()-1)
	local incomingDamage = ability:GetLevelSpecialValueFor( "illusion_incoming_damage_percent", ability:GetLevel()-1)

	print(outgoingDamage)
	print(incomingDamage)
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

	illusion:SetHealth(caster:GetHealth())
	-- Set the unit as an illusion
	-- modifier_illusion controls many illusion properties like +Green damage not adding to the unit damage, not being able to cast spells and the team-only blue particle 
	illusion:AddNewModifier(caster, ability, "modifier_illusion", { duration = duration, outgoing_damage = outgoingDamage, incoming_damage = incomingDamage })
	ability:ApplyDataDrivenModifier(caster, illusion, "modifier_kakashi_bunshin_charge", {duration = duration})   
	-- Without MakeIllusion the unit counts as a hero, e.g. if it dies to neutrals it says killed by neutrals, it respawns, etc.
	illusion:MakeIllusion()
	event.caster.bunshin = illusion
	GameMode:RemoveWearables( illusion )
	-- Move to the same direction as the caster
	Timers:CreateTimer(0.05,
		function() 
			FindClearSpaceForUnit(illusion, caster:GetAbsOrigin(), false)
			illusion:MoveToPosition(run_to_position)
		end
	)

end


function lighting_charge( keys )
	local duration = keys.ability:GetLevelSpecialValueFor( "lighting_charge_duration", keys.ability:GetLevel() - 1 )
	if keys.attacker:IsRealHero() then
		
		keys.ability:ApplyDataDrivenModifier(keys.caster, keys.attacker, "modifier_kakashi_lighting_charge", {duration = duration})

		local dummy = CreateUnitByName("npc_dummy_unit", keys.caster.bunshin:GetAbsOrigin(), false, keys.caster, keys.caster, keys.caster:GetTeam())
		local lightningChain = ParticleManager:CreateParticle("particles/items_fx/chain_lightning.vpcf", PATTACH_WORLDORIGIN, dummy)
		ParticleManager:SetParticleControl(lightningChain,0,Vector(dummy:GetAbsOrigin().x,dummy:GetAbsOrigin().y,dummy:GetAbsOrigin().z + dummy:GetBoundingMaxs().z ))	
		EmitSoundOn("Hero_Zuus.ArcLightning.Target",target)
		ParticleManager:SetParticleControl(lightningChain,1,Vector(keys.attacker:GetAbsOrigin().x,keys.attacker:GetAbsOrigin().y,keys.attacker:GetAbsOrigin().z + keys.attacker:GetBoundingMaxs().z ))
		dummy:RemoveSelf()
		keys.caster.bunshin:Destroy()

	end
end