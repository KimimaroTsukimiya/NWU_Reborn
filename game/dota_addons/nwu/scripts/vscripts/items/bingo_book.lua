function pingEnemies(keys)
	local caster = keys.caster
	local aura_radius = keys.ability:GetSpecialValueFor("aura_radius")
 
	local targetEntities = FindUnitsInRadius(caster:GetTeamNumber(), caster:GetAbsOrigin(), nil, aura_radius, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)

  
	ping_duration = keys.ability:GetSpecialValueFor("ping_duration")

if targetEntities then
	for _,target in pairs(targetEntities) do
		local origin = target:GetAbsOrigin()
		xcoord = origin.x
		ycoord = origin.y
		print(ycoord)
		print(xcoord)
		print(target:GetTeamNumber())
		print(DOTA_MINIMAP_EVENT_HINT_LOCATION)
		print(target)
		MinimapEvent(target:GetTeamNumber(), target, xcoord, ycoord, DOTA_MINIMAP_EVENT_HINT_LOCATION, ping_duration)
	end
end
end