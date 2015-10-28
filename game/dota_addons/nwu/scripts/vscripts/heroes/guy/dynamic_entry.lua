--[[
  Author: LearningDave
  Date: October, 28th 2015
  Dashes/Teleports Guy to the target
]]
function dynamic_entry( keys )
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	--TODO CLEANER DASH(longer duration)
	FindClearSpaceForUnit(caster, target:GetAbsOrigin(), false)
end