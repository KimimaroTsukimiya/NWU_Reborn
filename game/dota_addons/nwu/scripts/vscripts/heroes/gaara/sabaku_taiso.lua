--[[
	Author: LearningDave
	Date: October, 11th 2015.
	Launch the earthquake
]]
function launch_earthquake( event )
	local caster = event.caster
	local ability = event.ability
		local q_ability = caster:GetAbilityByIndex(1)
	local casterOrigin = caster:GetAbsOrigin()
	local targetPos = event.target_points[1]
	local direction = targetPos - casterOrigin
	direction = direction / direction:Length2D()

	ProjectileManager:CreateLinearProjectile( {
		Ability				= ability,
	--	EffectName			= "",
		vSpawnOrigin		= casterOrigin,
		fDistance			= event.distance,
		fStartRadius		= event.start_radius,
		fEndRadius			= event.end_radius,
		Source				= caster,
		bHasFrontalCone		= true,
		bReplaceExisting	= false,
		iUnitTargetTeam		= DOTA_UNIT_TARGET_TEAM_ENEMY,
		iUnitTargetType		= DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_CREEP + DOTA_UNIT_TARGET_MECHANICAL,
	--	fExpireTime			= ,
		bDeleteOnHit		= false,
		vVelocity			= direction * event.speed,
		bProvidesVision		= false,
	--	iVisionRadius		= ,
	--	iVisionTeamNumber	= caster:GetTeamNumber(),
	} )

	local particleName = "particles/units/heroes/hero_jakiro/jakiro_dual_breath_ice.vpcf"
	local pfx = ParticleManager:CreateParticle( particleName, PATTACH_ABSORIGIN, caster )
	ParticleManager:SetParticleControl( pfx, 0, casterOrigin )
	ParticleManager:SetParticleControl( pfx, 1, direction * event.speed * 1.333 )
	ParticleManager:SetParticleControl( pfx, 3, Vector(0,0,0) )
	ParticleManager:SetParticleControl( pfx, 9, casterOrigin )

	caster:SetContextThink( DoUniqueString( "destroy_particle" ), function ()
		ParticleManager:DestroyParticle( pfx, false )
	end, event.distance / event.speed )
end
