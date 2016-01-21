function StopSound( event )
	local target = event.target
	target:StopSound("Hero_ShadowShaman.Shackles")
end
 
function addEffect( keys )
	local pid = ParticleManager:CreateParticle("particles/units/heroes/shikamaru/shikamaru_spectral_test_tracking.vpcf", PATTACH_ABSORIGIN_FOLLOW, keys.caster)
	ParticleManager:SetParticleControlEnt(pid, 0, keys.caster, PATTACH_POINT_FOLLOW, "attach_hitloc", keys.caster:GetAbsOrigin(), false)
   	ParticleManager:SetParticleControlEnt(pid, 1, keys.target, PATTACH_POINT_FOLLOW, "attach_hitloc", keys.target:GetAbsOrigin(), false)
   	ParticleManager:SetParticleControlEnt(pid, 2, keys.target, PATTACH_POINT_FOLLOW, "attach_hitloc", keys.target:GetAbsOrigin(), false)
   	ParticleManager:SetParticleControlEnt(pid, 3, keys.target, PATTACH_POINT_FOLLOW, "attach_hitloc", keys.target:GetAbsOrigin(), false)
   	ParticleManager:SetParticleControlEnt(pid, 5, keys.target, PATTACH_POINT_FOLLOW, "attach_hitloc", keys.target:GetAbsOrigin(), false)
   	ParticleManager:SetParticleControlEnt(pid, 6, keys.caster, PATTACH_POINT_FOLLOW, "attach_hitloc", keys.caster:GetAbsOrigin(), false)
end