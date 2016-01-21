function add_physics(caster)
	Physics:Unit(caster)
	caster:PreventDI(true)
	caster:SetAutoUnstuck(false)
	caster:SetNavCollisionType(PHYSICS_NAV_NOTHING)
	caster:FollowNavMesh(false)	
end

function remove_physics(caster)
	caster:SetPhysicsAcceleration(Vector(0,0,0))
	caster:SetPhysicsVelocity(Vector(0,0,0))
	caster:OnPhysicsFrame(nil)
	caster:PreventDI(false)
	--caster:SetNavCollisionType(PHYSICS_NAV_SLIDE)
	caster:SetAutoUnstuck(true)
	caster:FollowNavMesh(true)
	caster:RemoveModifierByName("modifier_dynamic_entry_stunned")
end

function dynamic_entry_hit(keys)
	local target = keys.target
	local caster = keys.caster
	local ability = keys.ability
	local damage = ability:GetAbilityDamage()
	local particle_impact = "particles/units/heroes/hero_brewmaster/brewmaster_thunder_clap.vpcf"
	
	print(damage)

	ability:ApplyDataDrivenModifier(
			caster,
			target,
			keys.EntryModifier,
			{}
		)
		
	ApplyDamage({attacker = caster, victim = target, ability = ability, damage = damage, damage_type = ability:GetAbilityDamageType()})		

	EmitSoundOn("Hero_Brewmaster.ThunderClap",caster)
	EmitSoundOn("Hero_Brewmaster.ThunderClap.Target",target)


	local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_brewmaster/brewmaster_thunder_clap.vpcf", PATTACH_ABSORIGIN_FOLLOW, target) 
		  ParticleManager:SetParticleControlEnt(particle, 0, target, PATTACH_ABSORIGIN_FOLLOW, "follow_origin", target:GetAbsOrigin(), true)
		  ParticleManager:SetParticleControlEnt(particle, 1, target, PATTACH_ABSORIGIN_FOLLOW, "follow_origin", target:GetAbsOrigin(), true)
		  
end

function dynamic_entry_periodic(gameEntity, keys)
	local l_keys = keys.keys
	local target = l_keys.target
	local caster = l_keys.caster

	local velocity = 2500

	local vector = target:GetAbsOrigin() - caster:GetAbsOrigin()
	local direction = vector:Normalized()
	
	caster:SetPhysicsVelocity(direction * velocity)
	
	--Target reached
	if vector:Length2D() <= 2*caster:GetPaddedCollisionRadius() then
		dynamic_entry_hit(l_keys)
	
		remove_physics(caster)
		return nil
	end
	
	local dist = caster:GetAbsOrigin() - keys.point
	keys.distance = keys.distance + dist:Length2D()
	
	--Abort Distance / caster died / target died
	if ( keys.distance >= 1000 ) or (not caster:IsAlive()) or (not target:IsAlive()) or (target:IsNull()) then
		remove_physics(caster)
		return nil
	end
	

	return 0.03
end

function dynamic_entry_start(keys)	
	local caster = keys.caster
	local target = keys.target
	
	add_physics(caster)
	keys.ability:ApplyDataDrivenModifier(caster, caster, "modifier_dynamic_entry_stunned", {duration = 3})
	
	local timer_tbl =
		{
			callback = dynamic_entry_periodic,
			keys = keys,
			distance = 0,
			point = caster:GetAbsOrigin()
		}
	
	--Movement
	Timers:CreateTimer(timer_tbl)
end