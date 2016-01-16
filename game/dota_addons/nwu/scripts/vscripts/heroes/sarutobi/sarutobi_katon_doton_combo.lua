--[[
	Author: Zenicus
	Date: January 1st, 2016
	Applies Damage over time after the initial damage
]]
function burn_dot( keys )
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	local poison_damage = ability:GetLevelSpecialValueFor("burn_damage", (ability:GetLevel() - 1))

	local damageType = ability:GetAbilityDamageType()
	local damageTable = {
						victim = target,
						attacker = caster,
						damage = poison_damage,
						damage_type = damageType
					}
	ApplyDamage( damageTable )
	PopupDamage(target, poison_damage)

end