--[[
	Author: LearningDave
	Date: october, 5th 2015.
	Cleave Damage based on caster str and reduces enemy damage
]]
function ReleaseAoeDamage( event )
	-- Variables
	local caster = event.caster
	local ability = event.ability
	local ability_level = ability:GetLevel() - 1
	local aoe = event.ability:GetLevelSpecialValueFor("aoe", ability_level )

	-- Find Enemy Targets in AOE
	local targetEntities = FindUnitsInRadius(caster:GetTeamNumber(), caster:GetAbsOrigin(), nil, aoe, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, FIND_ANY_ORDER, false)

    --If there are targets do something
	if targetEntities then
		--Loop each target / Apply damage to each target and add modfier
		local strength = caster:GetStrength()
		local str_ratio = event.ability:GetLevelSpecialValueFor("str_ratio_damage", ability_level )
		local spell_damage = strength * str_ratio
		
		local damage_table = {
			attacker = caster,
			victim = nil,
			ability = ability,
			damage_type = ability:GetAbilityDamageType(),
			damage = spell_damage
		}
	
		for _,target in pairs(targetEntities) do
			damage_table.victim = target
			ApplyDamage(damage_table)
			ability:ApplyDataDrivenModifier(caster, target, "modifier_raigyaku_debuff",{})
		end
	end

end

--[[
	Author: LearningDave
	Date: october, 5th 2015.
	Reset Cooldown after attack islanded
]]
function SuiheiResetCooldown( keys )
	-- Variables
	local caster = keys.caster
	local ability = keys.ability
	local cooldown = ability:GetCooldown( ability:GetLevel() -1)
	local modifierName = "modifier_raigyaku"
	
	-- Remove cooldown
	caster:RemoveModifierByName( modifierName )
	ability:StartCooldown( cooldown )
	Timers:CreateTimer( cooldown, function()
			ability:ApplyDataDrivenModifier( caster, caster, modifierName, {} )
			return nil
		end
	)
end


function attachEffect( keys )

	-- Fire particle
	local fxIndex = ParticleManager:CreateParticle( "particles/econ/items/spirit_breaker/spirit_breaker_thundering_flail/spirit_breaker_thundering_flail.vpcf", PATTACH_CUSTOMORIGIN, keys.caster )
	ParticleManager:SetParticleControlEnt( fxIndex, 0, keys.caster, PATTACH_POINT_FOLLOW, "attach_lefthand", keys.target:GetAbsOrigin(), true)
	keys.ability.left = fxIndex
-- Fire particle
	local fxIndex = ParticleManager:CreateParticle( "particles/econ/items/spirit_breaker/spirit_breaker_thundering_flail/spirit_breaker_thundering_flail.vpcf", PATTACH_CUSTOMORIGIN, keys.caster )
	ParticleManager:SetParticleControlEnt( fxIndex, 0, keys.caster, PATTACH_POINT_FOLLOW, "attach_righthand", keys.target:GetAbsOrigin(), true)
	keys.ability.right = fxIndex
end


function removeEffect( keys )
	ParticleManager:DestroyParticle( keys.ability.right, true )
	ParticleManager:DestroyParticle( keys.ability.left, true )
end