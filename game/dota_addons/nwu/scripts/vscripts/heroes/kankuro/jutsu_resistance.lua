--[[Author: Zenicus
	Date: December 10, 2015
	Dismantle Part's justsu resistance.  Magic Resist = 50%]]
function jutsu_resistance( keys )

	local caster = keys.caster
	local player = caster:GetPlayerOwnerID()
	local ability = keys.ability
	local resist = ability:GetSpecialValueFor("bonus_magic_resist_percentage")

	print ("Magic Resist",caster.GetBaseMagicalResistanceValue())
	caster.SetBaseMagicalResistanceValue(resist)

end