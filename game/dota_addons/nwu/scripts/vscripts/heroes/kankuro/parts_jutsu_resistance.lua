--[[Author: Zenicus
	Date: December 10, 2015
	Dismantle Part's justsu resistance.  Magic Resist = 50%]]
function jutsu_resistance( keys )

	local caster = keys.caster
	local player = caster:GetPlayerOwnerID()
	local ability = keys.ability

	ability:ApplyDataDrivenModifier(caster, caster, keys.modifier_name, {})
end

function modifier_jutsu_resistance(keys)

	local caster = keys.caster
	local player = caster:GetPlayerOwnerID()
	local resist = keys.ability:GetSpecialValueFor("magic_resist_bonus")

	caster:SetBaseMagicalResistanceValue(resist)

end