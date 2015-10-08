--[[Author: LearningDave
	Date: october, 8th 2015.
	Adds a modifier to neji and switches nejis ability to neji_kaiten_release
	)]]
function kaiten_launch( keys )
	local caster = keys.caster	
	local ability = keys.ability
	local ability_level = ability:GetLevel()

	local main_ability_name = keys.main_ability_name
	local sub_ability_name = keys.sub_ability_name
	print(main_ability_name)
	print(sub_ability_name)
	-- Ability swap
	caster:RemoveAbility(main_ability_name)
		
	Ability = caster:AddAbility(sub_ability_name)
	Ability:SetAbilityIndex(1)
	Ability:SetLevel(ability_level)

end

--[[
	Author: LearningDave
	Date: october, 8th 2015.
	Swaps given abilites
]]
function kaiten_release( keys )
	local caster = keys.caster
	local ability_level = keys.ability:GetLevel()
	local main_ability_name = keys.main_ability_name
	local sub_ability_name = keys.sub_ability_name

	caster:RemoveAbility(main_ability_name)
	Ability = caster:AddAbility(sub_ability_name)
	Ability:SetAbilityIndex(1)
	Ability:SetLevel(ability_level)

end


--[[
	Author: LearningDave
	Date: october, 8th 2015.
	Knocks back enemy target in a given aoe
]]
function SwitchAbilities( caster, main_ability_name, sub_ability_name )
	-- Swap sub_ability
	caster:SwapAbilities(main_ability_name, sub_ability_name, false, true)
	print("Swapped "..main_ability_name.." with " ..sub_ability_name)
end

