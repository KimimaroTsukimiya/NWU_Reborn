--[[
	Author: LearningDave
	Date: october, 5th 2015.
	Cleave Damage based on caster str and reduces enemy damage
]]
function ReleaseAoeDamage( event )
	-- Variables
	local caster = event.caster
	local ability = event.ability
	local str_ratio = event.ability:GetLevelSpecialValueFor("str_ratio_damage", event.ability:GetLevel() - 1 )
	local aoe = event.ability:GetLevelSpecialValueFor("aoe", event.ability:GetLevel() - 1 )
	local strength = caster:GetStrength()
	local spell_damage = strength * str_ratio
	print("Str Ratio: "..str_ratio)
	print("Aoe: "..aoe)
	print("Str: "..strength)
	print("spell damage: "..spell_damage)

	-- Find Enemy Targets in AOE
	local targetEntities = FindUnitsInRadius(caster:GetTeamNumber(), caster:GetAbsOrigin(), nil, aoe, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)

    --If there are targets do something
	if targetEntities then
		--Loop each target / Apply damage to each target and add modfier
		for _,target in pairs(targetEntities) do
			local damage_table = {}
			print("applying damage: "..spell_damage)
			damage_table.attacker = caster
			damage_table.victim = target
			damage_table.ability = ability
			damage_table.damage_type = ability:GetAbilityDamageType()
			damage_table.damage = spell_damage
			ApplyDamage(damage_table)

			ability:ApplyDataDrivenModifier(target, target, "modifier_raigyaku_debuff", {})
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
	local cooldown = ability:GetCooldown( ability:GetLevel() )
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

--[[
	Author: LearningDave
	Date: october, 5th 2015.
	Reset Cooldown after attack islanded
]]
function AddSuiheiDebuff( keys )
	-- Variables
	local caster = keys.caster
	local damage_reduction_percent = keys.ability:GetLevelSpecialValueFor("damage_reduction", keys.ability:GetLevel() - 1 )
	local ability = keys.ability
	local basedamage = caster:GetAttackDamage()
	local damage = basedamage / 100 * (100 - damage_reduction_percent)
	local damage_table = {}

	print("damage reduction: "..damage_reduction_percent)
	print("basedamage: "..basedamage)
	print("applying damage: "..damage)

	-- Apply reduced damage
	damage_table.attacker = caster
	damage_table.victim = target
	damage_table.ability = ability
	damage_table.damage_type = ability:GetAbilityDamageType()
	damage_table.damage = spell_damage
	ApplyDamage(damage_table)
end
