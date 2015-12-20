function AddPhysics(caster)
	Physics:Unit(caster)
	caster:PreventDI(true)
	caster:SetAutoUnstuck(false)
	caster:SetNavCollisionType(PHYSICS_NAV_NOTHING)
	caster:FollowNavMesh(false)	
end

function RemovePhysics(caster)
	caster:SetPhysicsAcceleration(Vector(0,0,0))
	caster:SetPhysicsVelocity(Vector(0,0,0))
	caster:OnPhysicsFrame(nil)
	caster:PreventDI(false)
	caster:SetAutoUnstuck(true)
	caster:FollowNavMesh(true)
end

function FinishChidori(keys)
	RemovePhysics(keys.caster)
	keys.caster:RemoveModifierByName(keys.modifier_caster)
	keys.caster:RemoveModifierByName("modifier_raikiri_stunned")
end

function Launch(keys)	
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	local ability_level = ability:GetLevel() - 1
	local velocity = ability:GetLevelSpecialValueFor("speed", ability_level)
	local sound_impact = keys.sound_impact
	local particle_impact = keys.particle_impact

	


	caster:EmitSound(keys.sound_cast)
	AddPhysics(caster)
	ability:ApplyDataDrivenModifier(caster, caster, "modifier_raikiri_stunned", {})
	-- Movement
	Timers:CreateTimer(0, function()
		local vector = target:GetAbsOrigin() - caster:GetAbsOrigin()
		local direction = vector:Normalized()
		caster:SetPhysicsVelocity(direction * velocity)
		caster:SetForwardVector(direction)
		if not target:IsAlive() then
			FinishChidori(keys)
			return nil
		elseif vector:Length2D() <= 2 * target:GetPaddedCollisionRadius() then
			local enemy_loc = target:GetAbsOrigin()
			local impact_pfx = ParticleManager:CreateParticle(particle_impact, PATTACH_POINT_FOLLOW, target)
			ParticleManager:SetParticleControl(impact_pfx, 0, enemy_loc)
			ParticleManager:SetParticleControlEnt(impact_pfx, 3, target, PATTACH_POINT_FOLLOW, "attach_origin", enemy_loc, true)
			FinishChidori(keys)
			CheckForSpellBlock(keys)
			target:EmitSound(sound_impact)
			return nil
		end
		return 0.03
	end)
end

function ChannelChidori( keys )
	keys.ability:ApplyDataDrivenModifier(keys.caster, keys.caster, keys.modifier_caster, {})
	keys.caster:EmitSound(keys.sound_cast)
end

function RemoveChannelChidori(keys)
	keys.caster:RemoveModifierByName(keys.modifier_caster)
end