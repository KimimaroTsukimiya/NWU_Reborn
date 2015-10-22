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
