yondaime_body_flicker = class({})

function yondaime_body_flicker:OnSpellStart( event )

	local ability = self
	local caster = ability:GetCaster()
	local target = ability:GetCursorPosition()
	local hero_position = caster:GetAbsOrigin()

	local placed_seals = caster.daggers
	
	local closest_seal = nil
	local min_dist = 1000 --Maximum allowed distance
	
	for k,v in pairs(placed_seals) do
		if not v:IsNull() then
			if(	(target - v:GetAbsOrigin()):Length2D() < 1000 )then
					
				local dist = target - v:GetAbsOrigin()
				
				if dist:Length2D() < min_dist then
					min_dist = dist:Length2D()
					closest_seal = v
				end
			
			end
		end
	end

	if ( not closest_seal ) then
		ability:EndCooldown()
		caster:SetMana(caster:GetMana() + ability:GetManaCost(ability:GetLevel()))
		return
	end

	local particle = ParticleManager:CreateParticle("particles/units/heroes/yondaime/blink_core_alt.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
	ParticleManager:SetParticleControl(particle, 0, caster:GetAbsOrigin()) -- Origin
	ParticleManager:SetParticleControl(particle, 3, caster:GetAbsOrigin()) -- Origin

-- Fire particle
	local fxIndex = ParticleManager:CreateParticle( "particles/units/heroes/yondaime/blink_end_core.vpcf", PATTACH_CUSTOMORIGIN, caster )
	ParticleManager:SetParticleControl( fxIndex, 0, caster:GetAbsOrigin() )
	ParticleManager:SetParticleControl( fxIndex, 3, caster:GetAbsOrigin() )
	
	caster:AddNoDraw()
	FindClearSpaceForUnit( caster, closest_seal:GetAbsOrigin(), true )
	caster:Stop()
	caster:RemoveNoDraw()

end


function yondaime_body_flicker:CastFilterResultTarget( target )
	local ability = self
	local caster = ability:GetCaster()


	print(target:GetUnitName())


	-- Check illusion target
	if target:GetUnitName() == "npc_marked_kunai" then 
		return UF_SUCCESS
	else
		return UF_FAIL_CUSTOM
	end
	return ""
end
  
function yondaime_body_flicker:GetCustomCastErrorTarget( target )
	local ability = self
	local caster = ability:GetCaster()

	-- Check illusion target
	if target:GetUnitName() == "npc_marked_kunai" then 
		return ""
	else
		return "#error_must_target_owner_illusion"
	end
	return ""
end