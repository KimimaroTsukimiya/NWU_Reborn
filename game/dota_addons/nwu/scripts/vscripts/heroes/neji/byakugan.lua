 --[[Author: LearningDave
	Date: october, 8th 2015.
	Gives vision around the caster
	)]]
function vision( keys )
	local caster = keys.caster	
	local ability = keys.ability
	local ability_level = ability:GetLevel() - 1
	local radius = ability:GetLevelSpecialValueFor("vision_aoe", ability_level)
	local duration = ability:GetLevelSpecialValueFor("duration", ability_level)
	--Add temporary vision for a given team ( nTeamID, vLocation, flRadius, flDuration, bObstructedVision)
	AddFOWViewer(caster:GetTeamNumber(), caster:GetAbsOrigin(), radius, duration, true) 

end
