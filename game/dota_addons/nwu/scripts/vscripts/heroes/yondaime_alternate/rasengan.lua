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
end

function rasengan(keys)
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	
	if target:IsBuilding() then
		return
	end
	
	keys.caster:RemoveModifierByName(keys.modifier)
	
	local damage = ability:GetAbilityDamage()
	local damage_type = ability:GetAbilityDamageType()
	
	ApplyDamage({attacker = caster, victim = target, ability = ability, damage = damage, damage_type = damage_type})

	if target:IsMagicImmune() then
		return
	end
	
	add_physics(target)
	
	local velocity = keys.pushback_speed

	local vector = target:GetAbsOrigin() - caster:GetAbsOrigin()
	local direction = vector:Normalized()
	
	target:SetPhysicsVelocity(direction * velocity)
	
	
	Timers:CreateTimer(keys.pushback_duration, function()
		remove_physics(target)
	end)
	
end