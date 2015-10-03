--[[
	Author: Noya - Modifed LearningDave
	Date: 03.10.2015
]]
function Return( event )
	-- Variables

	local caster = event.caster GetLevelSp
	local attacker = event.attacker
	local damage = ability:GetLevelSpecialValueFor( "attack_damage", ( ability:GetLevel() - 1 ) )
	local ability = event.ability
	local damageType = ability:GetAbilityDamageType()
	local return_damage = damage
	print(damageType)
	-- Damage
	ApplyDamage({ victim = attacker, attacker = caster, damage = return_damage, damage_type = damageType })

	print("done "..return_damage)
end