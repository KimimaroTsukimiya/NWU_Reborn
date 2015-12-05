--[[Author LearningDave
	Date october, 9th 2015
	Swaps caster model
]]
function ModelSwapStart( keys )
	local caster = keys.caster
	local model = keys.model
	local projectile_model = keys.projectile_model

	-- Saves the original model and attack capability
	if caster.caster_model == nil then 
		caster.caster_model = caster:GetModelName()
	end
	caster.caster_attack = caster:GetAttackCapability()

	-- Sets the new model and projectile
	caster:SetOriginalModel(model)
end
--[[Author LearningDave
	Date october, 9th 2015
	Reverts back to the original model
]]
function ModelSwapEnd( keys )
	local caster = keys.caster
	caster:SetModel(caster.caster_model)
	caster:SetOriginalModel(caster.caster_model)
end
--[[
	Author LearningDave
	Date october, 9th 2015.
	Reduces the mana of the caster and swap the model if zero mana is reached
]]
function ManaCost( keys )
	-- Variables
	local caster = keys.caster
	local ability = keys.ability
	local manacost_percentage = keys.ability:GetLevelSpecialValueFor("mana_cost_per_second_percentage", keys.ability:GetLevel() - 1 )
	local max_mana = caster:GetMaxMana()
	local mana_reduce = max_mana / 100 * manacost_percentage / 10
	local current_mana = caster:GetMana()
	local new_mana = current_mana - mana_reduce
	local modifer = keys.modifierRemove
	if (current_mana - mana_reduce) <= 0 then
		caster:SetMana(1)
		caster:SetModel(caster.caster_model)
		caster:SetOriginalModel(caster.caster_model)
		caster:RemoveModifierByName("modifier_kisame_metamorphosis")
		ability:ToggleAbility()
		ability:StartCooldown(ability:GetCooldown(ability:GetLevel()))
	else
		caster:SetMana(new_mana)
	end
end
--[[Author: LearningDave
	Date: 04.11.2015
	Creates a dummy at the target location that acts as the Water prison
]]
function createWaterPrisonDome( keys )
	-- Variables
	keys.caster:Interrupt()
	local caster = keys.caster
	local ability = keys.ability
	local target_point = caster:GetAbsOrigin()

	-- Dummy
	local dummy_modifier = keys.dummy_aura
	local dummy = CreateUnitByName("npc_dummy_unit", target_point, false, caster, caster, caster:GetTeam())
	dummy:AddNewModifier(caster, nil, "modifier_phased", {})
	ability:ApplyDataDrivenModifier(caster, dummy, dummy_modifier, {duration = duration})
	keys.ability.domeDummy = dummy
	print(dummy:GetAbsOrigin())
	print(caster:GetAbsOrigin())
end
--[[Author: LearningDave
	Date: 04.11.2015
	Makes sure the dummy with the attached water prison effect follows the caster
]]
function domeFollowHero( keys )
	if keys.ability.domeDummy ~= nil and not keys.ability.domeDummy:IsNull() then
		if keys.ability.domeDummy:GetAbsOrigin() ~= keys.caster:GetAbsOrigin() then
			FindClearSpaceForUnit(keys.ability.domeDummy, keys.caster:GetAbsOrigin(), true)
		end
	end
end


function AddHPReg( keys )
	local hp_reg_percentage = keys.ability:GetLevelSpecialValueFor("hp_reg_per_second_percentage", keys.ability:GetLevel() - 1 )

	local hp_reg_bonus = keys.caster:GetMaxHealth() / 100 * 2
	local new_reg = keys.caster:GetHealthRegen() + hp_reg_bonus
	keys.ability.bonus_reg = hp_reg_bonus
	print(hp_reg_bonus)
	print(keys.caster:GetHealthRegen())
	print(new_reg)
	keys.caster:SetBaseHealthRegen(new_reg - 1.05)
	print(keys.caster:GetHealthRegen())
end

function RemoveHPReg( keys )
	print(keys.caster:GetHealthRegen())
	print(keys.ability.bonus_reg)
	print(keys.caster:GetHealthRegen() - keys.ability.bonus_reg)
	keys.caster:SetBaseHealthRegen(keys.caster:GetHealthRegen() - keys.ability.bonus_reg - 1.05)
	print(keys.caster:GetHealthRegen())
end