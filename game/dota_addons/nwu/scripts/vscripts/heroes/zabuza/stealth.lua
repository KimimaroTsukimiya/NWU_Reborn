function stealth( keys )
	local target = keys.target
	local caster = keys.caster
	FindClearSpaceForUnit( caster, target:GetAbsOrigin(), false )
	local order = 
		{
			UnitIndex = target:entindex(),
			OrderType = DOTA_UNIT_ORDER_ATTACK_TARGET,
			TargetIndex = caster:entindex()
		}
	
	Timers:CreateTimer( 0.1, function()
   		ExecuteOrderFromTable(order)
	  return nil
	  end
	  )
end


function attackAfterBlink( keys )
		keys.caster:Stop()
		local order = 
		{
			UnitIndex = keys.target:entindex(),
			OrderType = DOTA_UNIT_ORDER_ATTACK_TARGET,
			TargetIndex = keys.caster:entindex()
		}
		ExecuteOrderFromTable(order)
end