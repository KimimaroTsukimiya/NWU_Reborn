function releaseDragon( keys )
	local caster = keys.caster

	local duration = keys.ability:GetLevelSpecialValueFor( "duration", keys.ability:GetLevel() - 1 )
	local particleName = "particles/units/heroes/hero_kunkka/kunkka_spell_torrent_bubbles.vpcf"
	local target = keys.target_points[1]
	local ability = keys.ability

	local caster_location = caster:GetAbsOrigin()
	local target_point = keys.ability.water:GetAbsOrigin()
	local forwardVec = (target_point - caster_location):Normalized()

	-- Projectile variables
	local wave_speed = ability:GetLevelSpecialValueFor("dragon_speed", (ability:GetLevel() - 1))
	local wave_width = 450
	local wave_range = (target_point - caster_location):Length2D()
	local wave_location = caster_location
	local dragon_particle = keys.dragon_particle
	print(wave_range)
	keys.ability.dragonRange = wave_range
	-- Creating the projectile
	local projectileTable =
	{
		EffectName = dragon_particle,
		Ability = ability,
		vSpawnOrigin = caster_location,
		vVelocity = Vector( forwardVec.x * wave_speed, forwardVec.y * wave_speed, 0 ),
		fDistance = wave_range,
		fStartRadius = wave_width,
		fEndRadius = wave_width,
		Source = caster,
		bHasFrontalCone = false,
		bReplaceExisting = false,
		iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
		iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
		iUnitTargetType = DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO
	}
	-- Saving the projectile ID so that we can destroy it later
	projectile_id = ProjectileManager:CreateLinearProjectile( projectileTable )



end

function releaseDragonPreWater( keys )
	local caster = keys.caster

	local duration = keys.ability:GetLevelSpecialValueFor( "duration", keys.ability:GetLevel() - 1 )
	local particleName = "particles/units/heroes/hero_kunkka/kunkka_spell_torrent_bubbles.vpcf"
	local target = keys.target_points[1]
	local ability = keys.ability
			
	-- Dummy
	local dummy_modifier = keys.dummy_aura
	local dummy = CreateUnitByName("npc_dummy_unit", target, false, caster, caster, caster:GetTeam())
	dummy:AddNewModifier(caster, nil, "modifier_phased", {})
	ability:ApplyDataDrivenModifier(caster, dummy, "modifier_dragon_dummy", {duration = duration})

	EmitSoundOn("Ability.pre.Torrent",dummy)
	
	local fxIndex = ParticleManager:CreateParticle( particleName, PATTACH_ABSORIGIN, dummy)
	ParticleManager:SetParticleControl( fxIndex, 0, dummy:GetAbsOrigin() )

	keys.ability.water = dummy

end


function fireAbility( keys )
	local radius = keys.ability:GetLevelSpecialValueFor( "radius", keys.ability:GetLevel() - 1 )
	local slow_base = keys.ability:GetLevelSpecialValueFor( "ms_slow", keys.ability:GetLevel() - 1 )
	local duration = keys.ability:GetLevelSpecialValueFor( "duration", keys.ability:GetLevel() - 1 )
	local slow_base_per_distance = keys.ability:GetLevelSpecialValueFor( "ms_slow_per_distance", keys.ability:GetLevel() - 1 )
	local distance_stack_count = keys.ability.dragonRange / 150
	local targetEntities = FindUnitsInRadius(keys.caster:GetTeamNumber(), keys.ability.water:GetAbsOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, 0, FIND_ANY_ORDER, false)
	print(slow_base)
	print(slow_base_per_distance)
	print(distance_stack_count)
	local stackcount = slow_base + (distance_stack_count * slow_base_per_distance)
	stackcount = stackcount * -1
	print(stackcount)
	if targetEntities then
		for _,target in pairs(targetEntities) do
			keys.ability:ApplyDataDrivenModifier(keys.caster, target, keys.slow_modifier, {duration = duration})
			target:SetModifierStackCount(keys.slow_modifier, keys.ability, stackcount)
		end
	end

	EmitSoundOn( "Ability.Torrent", keys.ability.water )
	keys.ability.water:Destroy()
end