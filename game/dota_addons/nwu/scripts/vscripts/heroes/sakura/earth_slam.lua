function playSound( keys )
	local random = math.random(1, 2)
	if random == 1 then
		EmitSoundOn("sakura_slam",keys.caster)
	elseif random == 2 then
		EmitSoundOn("sakura_slam_2",keys.caster)
	end
end