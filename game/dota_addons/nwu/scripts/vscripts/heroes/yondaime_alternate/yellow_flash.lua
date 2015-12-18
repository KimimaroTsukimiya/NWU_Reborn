function yellow_flash(keys)
	local ability = keys.ability
	local modifier = keys.modifier
	local duration = keys.duration
	local caster = keys.caster
	local origin = caster.origin
	local bonus_dmg_percent=keys.BonusDmg
	local distance_cap = keys.DistanceCap
	
	if ( not caster.yf_stacks_pos ) then
		caster.yf_stacks_pos = 0
		caster.yf_stacks_neg = 0
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
	caster.yf_stacks_pos = bonus_dmg + caster.yf_stacks_pos
	
	local cur_stack = caster.yf_stacks_pos-caster.yf_stacks_neg
	if not caster:HasModifier(modifier) and (cur_stack >= 1) then
		ability:ApplyDataDrivenModifier(caster, caster, modifier, {})
	end
	
	caster:SetModifierStackCount(modifier, ability, cur_stack)
	
	-- Movement
	Timers:CreateTimer(duration, function()
		--print(caster.yf_stacks_pos,caster.yf_stacks_neg,bonus_dmg)
		caster.yf_stacks_neg = caster.yf_stacks_neg + bonus_dmg
		
		cur_stack = caster.yf_stacks_pos-caster.yf_stacks_neg
		
		if( cur_stack >= 1 ) then
			caster:SetModifierStackCount( modifier, ability, cur_stack )
		else
			caster:RemoveModifierByName(modifier)
		end
		
		return nil
	end)
	
end