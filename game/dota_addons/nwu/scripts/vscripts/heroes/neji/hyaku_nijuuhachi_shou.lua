--[[Author: LearningDave
	Date: October, 9th 2015
	Reveals the target if its invisible]]
function hyaku_nijuuhachi_shou_invis_check( keys )
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	local modifier = keys.modifier

	if target:IsInvisible() then
		ability:ApplyDataDrivenModifier(caster, target, modifier, {})
	end
end