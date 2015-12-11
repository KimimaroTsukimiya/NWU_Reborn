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
	local dayTime = caster:GetDayTimeVisionRange()
	local night = caster:GetNightTimeVisionRange()
	keys.caster:SetDayTimeVisionRange(radius)
	keys.caster:SetNightTimeVisionRange(radius)
	Timers:CreateTimer( duration, function()
		print(dayTime)
		print(night)
    	keys.caster:SetDayTimeVisionRange(dayTime)
		keys.caster:SetNightTimeVisionRange(night)
		return nil
	end
	)
end
