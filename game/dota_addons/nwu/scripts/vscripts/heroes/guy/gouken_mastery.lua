--[[
	Author: LearningDave
	Date: October, 28th 2015
	Does apply and popup damage to the target (doubled damage of the current attack damage)
]]
function ApplyDoubleDamage( keys )
	local target = keys.target
	local caster = keys.caster
	local ability = keys.ability
	local abilityDamageType = ability:GetAbilityDamageType()
	local damage = keys.caster:GetAverageTrueAttackDamage() 
	PopupDamage(target, damage * 2)
	local damageTable = {
			victim = target,
			attacker = caster,
			damage = damage,
			damage_type = abilityDamageType
		}
	ApplyDamage( damageTable )

end