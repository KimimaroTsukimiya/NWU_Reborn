--[[Author: Zenicus
	Date: December 10, 2015
	Karasu's Critical Strike]]
function jutsu_resistance( keys )

	local caster = keys.caster
	local player = caster:GetPlayerOwnerID()
	local ability = keys.ability
	local crit_chance = ability:GetSpecialValueFor("crit_chance")
	local crit_mult = ability:GetSpecialValueFor("crit_mult")

end