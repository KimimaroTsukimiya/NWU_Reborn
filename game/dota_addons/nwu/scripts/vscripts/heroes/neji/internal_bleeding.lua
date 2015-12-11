--[[ ============================================================================================================
	Author: Dave
	Date: October 23, 2015
	 -- Applies a DOT(damage over time) to the target and popups the damage amount
================================================================================================================= ]]
function internal_bleeding( keys )
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	local bleeding_damage = ability:GetLevelSpecialValueFor("damage_per_tick", (ability:GetLevel() - 1))
	local damageType = ability:GetAbilityDamageType()
	local damageTable = {
						victim = target,
						attacker = caster,
						damage = bleeding_damage,
						damage_type = damageType
					}
	ApplyDamage( damageTable )
	PopupDamage(target, bleeding_damage)
end