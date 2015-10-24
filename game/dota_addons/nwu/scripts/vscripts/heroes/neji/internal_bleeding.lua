LinkLuaModifier( "modifier_neji_internal_bleeding_ms_slow" , "heroes/neji/modifiers/modifier_neji_internal_bleeding_ms_slow.lua" , LUA_MODIFIER_MOTION_NONE )

function internal_bleeding( keys )
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	local bleeding_damage = ability:GetLevelSpecialValueFor("damage_per_tick", (ability:GetLevel() - 1))
	local damageType = ability:GetAbilityDamageType() -- DAMAGE_TYPE_MAGICAL
	local damageTable = {
						victim = target,
						attacker = caster,
						damage = bleeding_damage,
						damage_type = damageType
					}
	ApplyDamage( damageTable )
	PopupDamage(target, bleeding_damage)
end
--[[ ============================================================================================================
	Author: Dave
	Date: October 15, 2015
	-- Initiates the values for 'internal_bleeding'
================================================================================================================= ]]
function init_internal_bleeding( keys )
	local ms_slow = keys.ability:GetLevelSpecialValueFor("ms_slow", (keys.ability:GetLevel() - 1))
	keys.ability.ms_slow = ms_slow
	local ability = keys.caster:FindAbilityByName("neji_byakugan")
	local ability_level = ability:GetLevel()
	print(ability_level)
end

function apply_ms_slow( keys )

	local ms_slow_given = -15
	local ability = keys.caster:FindAbilityByName("neji_byakugan")
	local ability_level = ability:GetLevel()
	local ms = keys.caster:GetIdealSpeed()

	local new_ms = ms

	if ability_level == 0 then
		ms_slow_given = -15
		new_ms = -1 * ((ms / 100) * 15)
	elseif ability_level == 1 then
		ms_slow_given = -30
		new_ms = -1 * ((ms / 100) * 30)
	elseif ability_level == 2 then
		ms_slow_given = -45
		new_ms = -1 * ((ms / 100) * 45)
	elseif ability_level == 3 then
		ms_slow_given = -60
		new_ms = -1 * ((ms / 100) * 60)
	elseif ability_level == 4 then
		ms_slow_given = -70
		new_ms = -1 * ((ms / 100) * 70)
	end	

	keys.target:AddNewModifier(keys.caster, keys.target, "modifier_neji_internal_bleeding_ms_slow", {ms_slow_given = ms_slow_given})
end