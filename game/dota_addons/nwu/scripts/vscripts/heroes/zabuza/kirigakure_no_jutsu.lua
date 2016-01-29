LinkLuaModifier("modifier_chronosphere_speed_lua", "heroes/hero_faceless_void/modifiers/modifier_chronosphere_speed_lua.lua", LUA_MODIFIER_MOTION_NONE)

--[[Author: LearningDave
	Date: 22.10.2015
	Creates a dummy at the target location that acts as the Fog
	]]
function Chronosphere( keys )
	-- Variables
	local caster = keys.caster
	local ability = keys.ability
	local target_point = keys.target_points[1]

	-- Special Variables
	local duration = ability:GetLevelSpecialValueFor("duration", (ability:GetLevel() - 1))

	-- Dummy
	local dummy_modifier = keys.dummy_aura
	local dummy = CreateUnitByName("npc_dummy_unit", target_point, false, caster, caster, caster:GetTeam())
	dummy:AddNewModifier(caster, nil, "modifier_phased", {})
	ability:ApplyDataDrivenModifier(caster, dummy, dummy_modifier, {duration = duration})


	-- Timer to remove the dummy
	Timers:CreateTimer(duration, function() dummy:RemoveSelf() end)
end


function applyInvis( keys )
	local duration = keys.ability:GetLevelSpecialValueFor("duration", (keys.ability:GetLevel() - 1))
	if not keys.caster:HasModifier("modifier_zabuza_kirigakure_no_jutsu_ms_buff") then
		keys.ability:ApplyDataDrivenModifier(keys.caster,keys.target,"modifier_zabuza_kirigakure_no_jutsu_ms_buff",{duration = duration})
	end
end



--[[
	Author: kritth,Pizzalol
	Date: 18.01.2015.
	Main: Check/Reduce charge, spawn dummy and do web logic
]]
function spin_web( keys )

	local caster = keys.caster

		-- Variables
		local target = keys.target_points[1]
		local ability = keys.ability
		local player = caster:GetPlayerID()

		-- Modifiers and dummy abilities/modifiers
		local stack_modifier = keys.stack_modifier
		local dummy_modifier = keys.dummy_modifier

		-- AbilitySpecial variables
		local maximum_charges = ability:GetLevelSpecialValueFor( "max_charges", ( ability:GetLevel() - 1 ) )
		local duration = ability:GetLevelSpecialValueFor( "duration", ( ability:GetLevel() - 1 ) )
		local charge_replenish_time = ability:GetLevelSpecialValueFor( "charge_restore_time", ( ability:GetLevel() - 1 ) )

		-- Dummy
		local dummy = CreateUnitByName("npc_dummy_unit", target, false, caster, caster, caster:GetTeam())
		ability:ApplyDataDrivenModifier(caster, dummy, dummy_modifier, {})
		dummy:SetControllableByPlayer(player, true)
		


		-- Timer to remove the dummy
		Timers:CreateTimer(duration, function() dummy:RemoveSelf() end)
end


--[[Author: Pizzalol
	Date: 18.01.2015.
	Acts as an aura, applying the aura modifiers to the valid targets]]
function spin_web_aura( keys )
	local ability = keys.ability
	local caster = keys.caster	
	local target = keys.target

	-- Owner variables
	local caster_owner = caster:GetPlayerOwner()
	local target_owner = target:GetPlayerOwner()

	-- Units
	local unit_spiderling = keys.unit_spiderling
	local unit_spiderite = keys.unit_spiderite
	local all_units = ability:GetLevelSpecialValueFor("all_units", (ability:GetLevel() - 1))

	-- Modifiers
	local aura_modifier = keys.aura_modifier
	local pathing_modifier = keys.pathing_modifier
	local pathing_fade_modifier = keys.pathing_fade_modifier
	local invis_modifier = keys.invis_modifier
	local invis_fade_modifier = keys.invis_fade_modifier


	


	ability:ApplyDataDrivenModifier(caster, target, aura_modifier, {})

			-- If it doesnt have the fade pathing modifier or the pathing modifier then apply it
	if not target:HasModifier(pathing_fade_modifier) and not target:HasModifier(pathing_modifier) then
		ability:ApplyDataDrivenModifier(caster, target, pathing_modifier, {}) 
	end

			-- If it doesnt have the fade invis modifier or the invis modifier then apply it
	if not target:HasModifier(invis_modifier) and not target:HasModifier(invis_fade_modifier) then
		ability:ApplyDataDrivenModifier(caster, target, invis_fade_modifier, {})
	end

end

function appylMsBoost( keys )
	local ability = keys.ability
	local caster = keys.caster	
	local target = keys.target

	-- Owner variables
	local caster_owner = caster:GetPlayerOwner()
	local target_owner = target:GetPlayerOwner()
	print(caster_owner)
	print(target_owner)
	if caster_owner == target_owner then
		print("test")
		keys.ability:ApplyDataDrivenModifier(keys.caster, keys.target, keys.ms_modifier, {})
	end
end