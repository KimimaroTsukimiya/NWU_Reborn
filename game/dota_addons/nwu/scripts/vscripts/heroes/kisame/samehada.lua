--[[
	Author: LearningDave
	Date: october, 9th 2015.
	Steals mana from target and gives it to the caster
]]
function StealMana( event )
	-- Variables
	local caster = event.caster
	local ability = event.ability
	local target = event.target
	local manasteal_percentage = event.ability:GetLevelSpecialValueFor("manasteal_percentage", event.ability:GetLevel() - 1 )
	local mana = target:GetMana()
	print("steal percentage: "..manasteal_percentage)
	print("start mana: "..mana)
	local reduce_mana_amount = target:GetMaxMana() / 100 * manasteal_percentage
	local new_mana = mana - reduce_mana_amount
	target:SetMana(new_mana)
	local new_caster_mana = caster:GetMana() + reduce_mana_amount;
	caster:SetMana(new_caster_mana)
end
--[[
	Author: LearningDave
	Date: october, 9th 2015.
	Resets Cooldown after attack is landed
]]
function SamehadaResetCooldown( keys )
	-- Variables
	local caster = keys.caster
	local ability = keys.ability
	local cooldown = ability:GetCooldown( ability:GetLevel() )
	local modifierName = "modifier_samehada"
	
	if keys.target:GetMaxMana() > 0 then
        EmitSoundOn("Hero_Antimage.ManaBreak", keys.target)
		-- Remove cooldown
		caster:RemoveModifierByName( modifierName )
		ability:StartCooldown( cooldown )
		Timers:CreateTimer( cooldown, function()
				ability:ApplyDataDrivenModifier( caster, caster, modifierName, {} )
				return nil
			end
		)
	end
	
end
--[[
	Author: LearningDave
	Date: december, 6th 2015.
	Steals mana from target
]]
function StealManaBunshin( event )
	-- Variables
	local caster = event.caster
	local ability = event.ability
	local target = event.target
	local manasteal_percentage = event.ability:GetLevelSpecialValueFor("manasteal_percentage", event.ability:GetLevel() - 1 )
	local mana = target:GetMana()
	print("steal percentage: "..manasteal_percentage)
	print("start mana: "..mana)
	local reduce_mana_amount = target:GetMana() / 100 * manasteal_percentage
	local new_mana = mana - reduce_mana_amount
	target:SetMana(new_mana)
end

