anko_sojasosai_no_jutsu = class({})

--[[ ============================================================================================================
	Anko's Sojasosai No Jutsu
	Author: Zenicus
	Date: November 19, 2015
	 -- Applies damage based on target's missing HP to target and self
================================================================================================================= ]]
function anko_sojasosai_no_jutsu( keys )
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	local damage_percent = ability:GetLevelSpecialValueFor("damage_percent", (ability:GetLevel() - 1))

	--Get Target's Missing HP

	local target_missing_hp = target:GetMaxHealth() - target:GetHealth()

	--print ("Target Missing HP", target:GetMaxHealth(), target:GetHealth(), target_missing_hp)

	local final_damage = target_missing_hp * damage_percent/100

	--print ("Final damage", final_damage)
	-- Apply damage to Target
	local damageType = ability:GetAbilityDamageType()
	local damageTable = {
						victim = target,
						attacker = caster,
						damage = final_damage,
						damage_type = damageType
					}
	ApplyDamage( damageTable )

	-- Apply Animation to Target

	-- Apply damage to Self

	if (caster:GetHealth() - final_damage > 0) then
		caster:SetHealth(caster:GetHealth() - final_damage)
	elseif (caster:GetHealth() - final_damage <= 0) then
		caster:Kill(ability, caster)
	end

	-- Apply Animation to Self

end

