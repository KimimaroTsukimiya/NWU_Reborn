LinkLuaModifier( "modifier_neji_kaiten_stun" , "heroes/neji/modifiers/modifier_neji_kaiten_stun.lua" , LUA_MODIFIER_MOTION_NONE )
--[[Author: LearningDave
	Date: october, 24th 2015.
	Applies a modifer (stun) on the target, depening on the level of 'neji_byakugan'
)]]
function apply_stun( keys )
	local duration = 0
	local aoe_target = keys.ability:GetLevelSpecialValueFor("aoe_target", (keys.ability:GetLevel() - 1))
	local ability_index = keys.caster:FindAbilityByName("neji_byakugan"):GetAbilityIndex()
    local ability = keys.caster:GetAbilityByIndex(ability_index)
    local ability_level = ability:GetLevel()
    local targetEntities = FindUnitsInRadius(keys.caster:GetTeamNumber(), keys.caster:GetAbsOrigin(), nil, aoe_target, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, FIND_ANY_ORDER, false)
    duration = 0.75 * ability_level
	if duration > 0 then
		Timers:CreateTimer( 1, function()
			if targetEntities then
				for _,target in pairs(targetEntities) do
					target:AddNewModifier(keys.caster, target, "modifier_neji_kaiten_stun", {Duration = duration})
				end
			end
		return nil
		end
		)
	end
end