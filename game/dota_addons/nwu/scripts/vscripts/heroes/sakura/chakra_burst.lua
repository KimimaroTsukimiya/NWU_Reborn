function gainMaxMoveSpeed( keys )
	local caster = keys.caster
	local ability = keys.ability
	local duration =  ability:GetLevelSpecialValueFor("duration", ability:GetLevel() - 1)

	local speed = caster:GetIdealSpeed()
	caster:SetBaseMoveSpeed(1000)

	Timers:CreateTimer( duration, function()
        caster:SetBaseMoveSpeed(speed)
		return nil
	end
	)

end