function playSound( keys )
	local random = math.random(1, 2)
	if random == 1 then
		EmitSoundOn("sakura_ulti", keys.caster)
	elseif random == 2 then
		EmitSoundOn("sakura_ulti_2", keys.caster)
	end
end