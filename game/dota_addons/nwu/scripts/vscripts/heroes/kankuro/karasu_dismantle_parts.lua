--[[Author: Zenicus
	Date: December 5, 2015
	Creates a puppet that grows in level and has 4 different skills]]
function dismantle_parts( keys )

	local caster = keys.caster
	local caster_location = caster:GetAbsOrigin() 
	local player = caster:GetPlayerOwnerID()
	local ability = keys.ability

	-- Ability variables
	local parts_duration = ability:GetSpecialValueFor("parts_duration") 

	-- Kills Karasu
	-- caster:ForceKill(false)

	-- Creates 6 dagger parts
	for i = 0, 5 do

		--Creates the Puppet next to the Caster
		local parts_unit  = CreateUnitByName("npc_dismantle_parts", caster_location+RandomVector(100), true, caster, caster, caster:GetTeamNumber())
		
		--parts_unit:AddNewModifier(caster, ability, "modifier_phased", {duration = 0.03})
		parts_unit:CreatureLevelUp(1)
		parts_unit:FindAbilityByName("parts_jutsu_resistance"):SetLevel(1)
		parts_unit:FindAbilityByName("parts_poison"):SetLevel(1)
		parts_unit:SetOwner(keys.caster:GetOwner())
		--Stores the unit for tracking
		parts_unit:SetControllableByPlayer(player, true)

		--Kills Dagger after timer
		Timers:CreateTimer(parts_duration,function()
			if parts_unit ~= nil and parts_unit:IsAlive() then
				parts_unit:ForceKill(false)
			end
		end)

	end
	

end

