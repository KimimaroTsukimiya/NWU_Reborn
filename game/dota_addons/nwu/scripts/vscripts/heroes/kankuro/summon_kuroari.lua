--[[Author: Zenicus
	Date: December 5, 2015
	Creates a puppet that holds the enemy in place]]
function summon_kuroari( keys )
	local target = keys.target
	local caster = keys.caster
	local caster_location = caster:GetAbsOrigin() 
	local target_location = target:GetAbsOrigin()
	local player = caster:GetPlayerOwnerID()
	local ability = keys.ability

	-- Ability variables
	local puppet_duration = ability:GetLevelSpecialValueFor("puppet_duration", ability:GetLevel() - 1) 

	-- Modifiers
	-- Apply the stun duration
	target:AddNewModifier(caster, ability, "modifier_stunned", {duration = puppet_duration})

	--Creates the Puppet next to the Target
	local kuroari = CreateUnitByName("npc_kuroari", target_location + RandomVector(100), true, caster, caster, caster:GetTeamNumber())


	--TODO: Make puppet invulnerable
	kuroari:SetMaxHealth(10000)
	kuroari:SetHealth(10000)

	--Remove Puppet
	Timers:CreateTimer(puppet_duration,function()
		kuroari:RemoveSelf()
	end)
end