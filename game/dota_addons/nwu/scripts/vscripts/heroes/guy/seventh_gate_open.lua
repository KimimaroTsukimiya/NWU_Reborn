function hpDrain( keys )
	local drain_hp_percent = keys.ability:GetLevelSpecialValueFor("hp_drain",keys.ability:GetLevel())
	drain_hp_percent = drain_hp_percent / 10
	local drain_hp = (keys.caster:GetMaxHealth() / 100) * drain_hp_percent
	if keys.caster:GetHealth() - drain_hp > 0 then
		keys.caster:SetHealth(keys.caster:GetHealth() - drain_hp)
	else
		keys.ability:ToggleAbility()
	end	

end

function changeAbilities( keys )
	local caster = keys.caster
	local ability = keys.ability

	print("test")
	ability0_level = caster:GetAbilityByIndex(0):GetLevel()
	ability0_cooldown = caster:GetAbilityByIndex(0):GetCooldownTimeRemaining()
	caster:AddAbility("guy_dynamic_entry_new_ult")
	caster:SwapAbilities("guy_dynamic_entry_new", "guy_dynamic_entry_new_ult", false, true)
	caster:RemoveAbility("guy_dynamic_entry_new")
	caster:GetAbilityByIndex(0):SetLevel(ability0_level)
	caster:GetAbilityByIndex(0):StartCooldown(ability0_cooldown)
	
	ability1_level = caster:GetAbilityByIndex(1):GetLevel()
	ability1_cooldown = caster:GetAbilityByIndex(1):GetCooldownTimeRemaining()
	caster:AddAbility("guy_leaf_strong_whirlwind_ult")
	caster:SwapAbilities("guy_leaf_strong_whirlwind", "guy_leaf_strong_whirlwind_ult", false, true)
	caster:RemoveAbility("guy_leaf_strong_whirlwind")
	caster:GetAbilityByIndex(1):SetLevel(ability1_level)
	caster:GetAbilityByIndex(1):StartCooldown(ability1_cooldown)

	ability2_level = caster:GetAbilityByIndex(2):GetLevel()
	ability2_cooldown = caster:GetAbilityByIndex(2):GetCooldownTimeRemaining()
	caster:AddAbility("guy_strong_fist_ult")
	caster:SwapAbilities("guy_strong_fist", "guy_strong_fist_ult", false, true)
	caster:RemoveAbility("guy_strong_fist")
	caster:GetAbilityByIndex(2):SetLevel(ability2_level)
	caster:GetAbilityByIndex(2):StartCooldown(ability2_cooldown)
end

function changeAbilitiesBack( keys )
	local caster = keys.caster
	local ability = keys.ability
	local ability1_name = caster:GetAbilityByIndex(0)
	local ability2_name = caster:GetAbilityByIndex(1)
	local ability3_name = caster:GetAbilityByIndex(2)
	ability0_level = caster:GetAbilityByIndex(0):GetLevel()
	ility0_cooldown = caster:GetAbilityByIndex(0):GetCooldownTimeRemaining()
	caster:AddAbility("guy_dynamic_entry_new")
	caster:SwapAbilities("guy_dynamic_entry_new", "guy_dynamic_entry_new_ult", true, false)
	caster:RemoveAbility("guy_dynamic_entry_new_ult")
	caster:GetAbilityByIndex(0):SetLevel(ability0_level)
	caster:GetAbilityByIndex(0):StartCooldown(ability0_cooldown)

	ability1_cooldown = caster:GetAbilityByIndex(1):GetCooldownTimeRemaining()
	ability1_level = caster:GetAbilityByIndex(1):GetLevel()
	caster:AddAbility("guy_leaf_strong_whirlwind")
	caster:SwapAbilities("guy_leaf_strong_whirlwind", "guy_leaf_strong_whirlwind_ult", true, false)
	caster:RemoveAbility("guy_leaf_strong_whirlwind_ult")
	caster:GetAbilityByIndex(1):SetLevel(ability1_level)
	caster:GetAbilityByIndex(1):StartCooldown(ability1_cooldown)

	ability2_cooldown = caster:GetAbilityByIndex(2):GetCooldownTimeRemaining()
	ability2_level = caster:GetAbilityByIndex(2):GetLevel()
	caster:AddAbility("guy_strong_fist")
	caster:SwapAbilities("guy_strong_fist", "guy_strong_fist_ult", true, false)
	caster:RemoveAbility("guy_strong_fist_ult")
	caster:GetAbilityByIndex(2):SetLevel(ability2_level)
	caster:GetAbilityByIndex(2):StartCooldown(ability2_cooldown)
end