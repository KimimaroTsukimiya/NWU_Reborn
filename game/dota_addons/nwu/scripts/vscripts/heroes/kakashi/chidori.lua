--[[
	Author: LearningDave
	Date: october, 5th 2015.
	Teleport raikage
]]
function raikage_teleport( keys )
	local point = keys.target_points[1]
	local caster = keys.caster
	print(point)
	PrintTable(point)
	FindClearSpaceForUnit( caster, point, false )
end
function ChannelChidori( keys )
		local particle = ParticleManager:CreateParticle(keys.particle_name, PATTACH_ABSORIGIN, keys.caster) 
		ParticleManager:SetParticleControlEnt(particle, 0, keys.caster, PATTACH_ABSORIGIN, "attach_chidori", keys.caster:GetAbsOrigin(), true)
		keys.ability.chidori_cast_particle = particle
end

function RemoveChannelChidori(keys)
	ParticleManager:DestroyParticle(keys.ability.chidori_cast_particle, true)
end


function StormBoltLaunch( keys )
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	local ability_level = ability:GetLevel() - 1
	local modifier_caster = keys.modifier_caster
	local particle_bolt = keys.particle_bolt
	local sound_cast = keys.sound_cast

	-- Parameters
	local speed = ability:GetLevelSpecialValueFor("speed", ability_level)
	local vision_radius = ability:GetLevelSpecialValueFor("vision_radius", ability_level)

	-- Play sound
	caster:EmitSound(sound_cast)

	-- Randomly play a cast line
	if RandomInt(1, 100) <= 50 then
		caster:EmitSound("sven_sven_ability_stormbolt_0"..RandomInt(1,9))
	end

	-- Return caster to the world
	ability:ApplyDataDrivenModifier(caster, caster,modifier_caster, {})
	caster:AddNoDraw()
	
	-- Create tracking projectile
	local bolt_projectile = {
		Target = target,
		Source = caster,
		Ability = ability,
		EffectName = particle_bolt,
		bDodgeable = false,
		bProvidesVision = true,
		iMoveSpeed = speed,
		iVisionRadius = vision_radius,
		iVisionTeamNumber = caster:GetTeamNumber(),
		iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_1
	}

	local test = ProjectileManager:CreateTrackingProjectile(bolt_projectile)

	PrintTable(test)

end

function StormBoltEnd( keys )
	local caster = keys.caster
	local modifier_caster = keys.modifier_caster

	-- Return caster to the world
	caster:RemoveModifierByName(modifier_caster)
	caster:RemoveNoDraw()
end

function StormBoltHit( keys )
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	local ability_level = ability:GetLevel() - 1
	local modifier_caster = keys.modifier_caster
	local sound_impact = keys.sound_impact
	local particle_impact = keys.particle_impact

	-- Parameters
	local damage = ability:GetLevelSpecialValueFor("damage", ability_level)
	local radius = ability:GetLevelSpecialValueFor("radius", ability_level)
	local duration = ability:GetLevelSpecialValueFor("duration", ability_level)

	-- Play sound
	target:EmitSound(sound_impact)

	-- Return caster to the world
	caster:RemoveModifierByName(modifier_caster)
	caster:RemoveNoDraw()

	-- Teleport the caster to the target
	local target_pos = target:GetAbsOrigin()
	local caster_pos = caster:GetAbsOrigin()
	local blink_pos = target_pos + ( caster_pos - target_pos ):Normalized() * 100
	FindClearSpaceForUnit(caster, blink_pos, true)

	-- Randomly play a cast line
	if ( target_pos - caster_pos ):Length2D() > 600 and RandomInt(1, 100) <= 20 then
		caster:EmitSound("sven_sven_ability_teleport_0"..RandomInt(1,3))
	end

	-- Start attacking the target
	caster:SetAttacking(target)
	--caster:SetBaseMoveSpeed(caster.normalMS)
	-- Fire impact particle
	local enemy_loc = target:GetAbsOrigin()
	local impact_pfx = ParticleManager:CreateParticle(particle_impact, PATTACH_ABSORIGIN, enemy)
	ParticleManager:SetParticleControl(impact_pfx, 0, enemy_loc)
	ParticleManager:SetParticleControlEnt(impact_pfx, 3, enemy, PATTACH_ABSORIGIN, "attach_origin", enemy_loc, true)

	 -- Apply damage
	ApplyDamage({attacker = caster, victim = target, ability = ability, damage = damage, damage_type = ability:GetAbilityDamageType()})
end