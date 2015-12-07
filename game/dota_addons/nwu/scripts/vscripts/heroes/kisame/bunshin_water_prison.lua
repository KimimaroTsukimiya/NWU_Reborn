function stopChannelOnDead( keys )
	if keys.caster == nil then
		keys.target:RemoveModifierByName("modifier_bunshin_water_prison_hold")
	end
end