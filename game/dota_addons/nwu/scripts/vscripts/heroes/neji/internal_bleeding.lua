LinkLuaModifier( "modifier_neji_internal_bleeding_ms_slow" , "heroes/neji/modifiers/modifier_neji_internal_bleeding_ms_slow.lua" , LUA_MODIFIER_MOTION_NONE )
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
--[[ ============================================================================================================
	Author: Dave
	Date: October 23, 2015
	-- Initiates the values for 'internal_bleeding'
================================================================================================================= ]]
function init_internal_bleeding( keys )
	local ms_slow = keys.ability:GetLevelSpecialValueFor("ms_slow", (keys.ability:GetLevel() - 1))
	keys.ability.ms_slow = ms_slow
	local ability = keys.caster:FindAbilityByName("neji_byakugan")
	local ability_level = ability:GetLevel()
	print(ability_level)
end
--[[ ============================================================================================================
	Author: Dave
	Date: October 24, 2015
	 -- adds a modifier which slows the target on x percent(depening on the 'neji_byakugan' level) 
	 -- modifier_neji_internal_bleeding_ms_slow.lua is required
================================================================================================================= ]]
function apply_ms_slow( keys )
	local duration = keys.ability:GetLevelSpecialValueFor("ms_slow_duration", (keys.ability:GetLevel() - 1))
	keys.target:AddNewModifier(keys.caster, keys.target, "modifier_neji_internal_bleeding_ms_slow", {Duration = duration})
end