--[[Author: Zenicus
	Date: December 5, 2015
	Creates a puppet that grows in level and has 4 different skills]]
function summon_karasu( keys )

	local caster = keys.caster
	local caster_location = caster:GetAbsOrigin() 
	local player = caster:GetPlayerOwnerID()
	local ability = keys.ability
	local hp_gain = ability:GetSpecialValueFor("hp_gain")
	local mana_gain = ability:GetSpecialValueFor("mana_gain")
	local damage_gain = ability:GetSpecialValueFor("damage_gain")

	-- Ability variables
	local puppet_duration = ability:GetSpecialValueFor("puppet_duration") 

	-- Clear any previous Karasu in case of WTF Mode
	if IsValidEntity(ability.karasu) then 
		ability.karasu:ForceKill(false)
	end

	--Creates the Puppet next to the Caster
	local karasu_unit  = CreateUnitByName("npc_karasu", caster_location + RandomVector(100), true, caster, caster, caster:GetTeamNumber())
	--Stores the unit for tracking
	ability.karasu = karasu_unit
	karasu_unit:AddNewModifier(caster, ability, "modifier_phased", {duration = 0.03})

	--Sets the stats gain per level
	karasu_unit:SetHPGain(hp_gain)
	karasu_unit:SetManaGain(mana_gain)
	karasu_unit:SetDamageGain(damage_gain)

	--Determine Karasu's Skills
	if (ability:GetLevel() == 1) then
		karasu_unit:CreatureLevelUp(1)
		karasu_unit:FindAbilityByName("karasu_critical_strike"):SetLevel(1)
	elseif (ability:GetLevel() == 2) then
		karasu_unit:CreatureLevelUp(2)
		karasu_unit:FindAbilityByName("karasu_daggers"):SetLevel(1)
		karasu_unit:FindAbilityByName("karasu_critical_strike"):SetLevel(1)
	elseif (ability:GetLevel() == 3) then
		karasu_unit:CreatureLevelUp(3)
		karasu_unit:FindAbilityByName("karasu_daggers"):SetLevel(1)
		karasu_unit:FindAbilityByName("karasu_poison_gas"):SetLevel(1)
		karasu_unit:FindAbilityByName("karasu_critical_strike"):SetLevel(1)
	elseif (ability:GetLevel() == 4) then
		karasu_unit:CreatureLevelUp(4)
		karasu_unit:FindAbilityByName("karasu_daggers"):SetLevel(1)
		karasu_unit:FindAbilityByName("karasu_poison_gas"):SetLevel(1)
		karasu_unit:FindAbilityByName("karasu_critical_strike"):SetLevel(1)
		karasu_unit:FindAbilityByName("karasu_dismantle_parts"):SetLevel(1)
	end

	karasu_unit:SetControllableByPlayer(player, true)

	--Kills Puppet after timer
	Timers:CreateTimer(puppet_duration,function()
		if karasu_unit ~= nil and karasu_unit:IsAlive() then
			karasu_unit:ForceKill(false)
		end
	end)
end

