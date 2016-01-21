--[[Author LearningDave
	Date november, 2nd 2015
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
--[[Author: LearningDave
	Date: 22.10.2015
	Creates a dummy at the target location that acts as the Jashin Circle
	]]
function createJashinCirlce( keys )
	-- Variables
	local caster = keys.caster
	local ability = keys.ability
	local target_point = keys.caster:GetAbsOrigin()

	-- Special Variables
	local duration = ability:GetLevelSpecialValueFor("duration", (ability:GetLevel() - 1))

	-- Dummy
	local dummy_modifier = keys.dummy_aura
	local dummy = CreateUnitByName("npc_dummy_unit", target_point, false, caster, caster, caster:GetTeam())
	dummy:AddNewModifier(caster, nil, "modifier_phased", {})
	ability:ApplyDataDrivenModifier(caster, dummy, dummy_modifier, {duration = duration})


	-- Timer to remove the dummy
	Timers:CreateTimer(duration, function() dummy:RemoveSelf() end)
end
--[[Author LearningDave
	Date november, 2th 2015
	Sets the target for this ability
]]
function setTarget( keys )
	if keys.target:IsRealHero() then
		keys.ability.bloodTarget = keys.target
		keys.ability:ApplyDataDrivenModifier(keys.caster,keys.target,"modifier_hidan_ulti_debuff",{duration = 20})
		
		keys.ability.targetTime = Time()
		local targetTime = Time()

		Timers:CreateTimer(20, function() 
			if keys.ability.targetTime == targetTime then 

				keys.ability.bloodTarget = nil 
				end 
		end)
	end
end
--[[Author LearningDave
	Date november, 2th 2015
	Initiates the variables for this ability
]]
function initiateTarget( keys )
	keys.ability.bloodTarget = nil
end
--[[Author LearningDave
	Date november, 2th 2015
	Applies damage to the marked target
]]
function apply_damage( keys )
	if keys.ability.bloodTarget ~= nil then 
		local target = keys.ability.bloodTarget
		local abilityDamageType = keys.ability:GetAbilityDamageType()
		local damage = keys.Damage
		local displayDamage = tonumber(string.format("%." ..  0 .. "f", damage))
		print(displayDamage)
		PopupDamage(target, displayDamage)

		local damageTable = {
			victim = target,
			attacker = keys.caster,
			damage = damage,
			damage_type = abilityDamageType
		}
		ApplyDamage( damageTable )
	end
end
--[[Author LearningDave
	Date november, 2th 2015
	Applies the modifier_hidan_in_circle modifier to hidan if he is inside the jashin circle
]]
function apply_circle_modifier( keys )
	if keys.target == keys.caster then
		keys.ability:ApplyDataDrivenModifier(keys.caster, keys.caster, "modifier_hidan_in_circle", {Duration = 1})
	end
end
--[[Author LearningDave
	Date november, 2th 2015
	Adds Self Pain to Hidan'S abilities
]]
function addSelfPainAbility( keys )
	selfPain = keys.caster:FindAbilityByName("hidan_self_pain")
    selfPain:SetLevel(keys.ability:GetLevel())
end
--[[Author LearningDave
	Date november, 2th 2015
	Removes Self Pain from Hidan'S abilities
]]
function removeSelfPain( keys )
	selfPain = keys.caster:FindAbilityByName("hidan_self_pain")
    selfPain:SetLevel(0)
end