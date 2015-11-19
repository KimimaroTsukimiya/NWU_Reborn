--[[
	Author: Noya - Modifed LearningDave
	Date: 03.10.2015
]]
function Return( event )
	-- Variables

	local caster = event.caster
	local attacker = event.attacker
	print(attacker:GetName())
	local damage = event.Damage
	local abilityDamageType = event.ability:GetAbilityDamageType()
	local ability = event.ability
	print(damage)
	print(abilityDamageType)
	print(caster)
	print(event.attacker)
	-- Damage
	local damageTable = {
				victim = attacker,
				attacker = caster,
				damage = damage,
				damage_type = abilityDamageType
			}
	ApplyDamage( damageTable )


end