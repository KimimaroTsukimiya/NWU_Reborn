--[[
	Author: LearningDave
	Date: october, 12th 2015.
	Checks if the ms of the caster has changed and provies bonus damage based on the ms
]]
function apply_bonus_damage( data )
	if data.ability.ms == data.caster:GetIdealSpeed() then
		print('nothing should happend, cause ms didnt change')
	else 
		local caster = data.caster
		local ms = data.caster:GetIdealSpeed()
		local ms_bonus_percent_damage = data.ability:GetLevelSpecialValueFor("bonus_damage_ms_percent", data.ability:GetLevel() - 1 )
		local average_damage = caster:GetAverageTrueAttackDamage()
		local agility_bonus = caster:GetAgility()
		local add_damage = ms / 100 * ms_bonus_percent_damage
		local modifierName = "modifier_agile_speed"
	
		data.ability:ApplyDataDrivenModifier( caster, caster, modifierName, { } )
		caster:SetModifierStackCount( modifierName, data.ability, add_damage )
	end 	
	
end
--[[
	Author: LearningDave
	Date: october, 12th 2015.
	Initiates the current ms for 'apply_bonus_damage'
]]
function init_agile_speed( data )
	data.ability.ms = data.caster:GetIdealSpeed()
end