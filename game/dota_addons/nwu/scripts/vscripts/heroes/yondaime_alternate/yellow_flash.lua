function yellow_flash(keys)
	local ability = keys.ability
	local modifier = keys.modifier
	local duration = keys.duration
	local caster = keys.caster
	local origin = caster.origin
	local bonus_dmg_percent=keys.BonusDmg
	local distance_cap = keys.DistanceCap
	
	if ( not caster.yf_stacks ) then
		caster.yf_stacks = 0
	end
	
	if ( not origin ) then
		caster.origin = caster:GetAbsOrigin()
		caster:RemoveModifierByName(modifier)
		return
	end
	
	local dist = caster:GetAbsOrigin() - origin
	dist = dist:Length2D()
	
	caster.origin = caster:GetAbsOrigin()
	
	if dist > distance_cap then
		dist=distance_cap
	end
	
	local bonus_dmg = (dist * bonus_dmg_percent)/100
	caster.yf_stacks = bonus_dmg + caster.yf_stacks
	
	if not caster:HasModifier(modifier) and (caster.yf_stacks >= 1) then
		ability:ApplyDataDrivenModifier(caster, caster, modifier, {})
	end
	
	caster:SetModifierStackCount(modifier, ability, caster.yf_stacks)
	
	-- Movement
	Timers:CreateTimer(duration, function()
		caster.yf_stacks = caster.yf_stacks - bonus_dmg
		
		if( caster.yf_stacks >= 1 ) then
			caster:SetModifierStackCount( modifier, ability, caster.yf_stacks )
		else
			caster:RemoveModifierByName(modifier)
		end
		
		return nil
	end)
	
end