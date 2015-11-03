


function placeWard( keys )
		-- Variables
	local caster = keys.caster
	local ability = keys.ability
	local target_point = keys.target_points[1]

	-- Special Variables
	local max_wards_placed = ability:GetLevelSpecialValueFor("max_wards_placed", (ability:GetLevel() - 1))
	local duration = ability:GetLevelSpecialValueFor("duration", (ability:GetLevel() - 1))

	-- Dummy
	local dummy_modifier = keys.third_eye_vision

	local dummy = CreateUnitByName("npc_third_eye", target_point, false, caster, caster, caster:GetTeam())
	--dummy:AddNewModifier(caster, nil, "modifier_phased", {})
	ability:ApplyDataDrivenModifier(caster, dummy, dummy_modifier, {duration = duration})

	if keys.ability.wards == nil then 
		keys.ability.wards = {}
	end
	table.insert(keys.ability.wards, dummy)

	if  GameMode:tablelength(keys.ability.wards) > max_wards_placed then
		for key,oneWard in pairs(keys.ability.wards) do 
			if key == 1 then 
				oneWard:RemoveSelf()
			end
		end
		table.remove(keys.ability.wards, 1)
	end

	-- Timer to remove the dummy
	Timers:CreateTimer(duration, function() dummy:RemoveSelf() end)
end
function rechargeThirdEye( keys )
	local ability = keys.ability
	local caster = keys.caster
	--print(buildingEntities)
	local max_charges = ability:GetLevelSpecialValueFor("max_charges", (ability:GetLevel() - 1))
	local distance_to_shop_for_recharge = ability:GetLevelSpecialValueFor("distance_to_shop_for_recharge", (ability:GetLevel() - 1))
	local shop_position = nil
	--TODO FIND A WAY TO GET THE SHOPS POSITION BY NAME
	if caster:GetTeamNumber() == 1 then
		 shop_position = SHOP_TEAM_1
	else 
		 shop_position = SHOP_TEAM_2
	end 
	
	local distance = (caster:GetAbsOrigin() - shop_position):Length2D()
	if distance < distance_to_shop_for_recharge then 
		if keys.ability:GetCurrentCharges() ~= max_charges then
			keys.ability:SetCurrentCharges(max_charges)
		end
	end

end