--[[Author: LearningDave
	Date: october, 8th 2015.
	Shoots a wave of terror]]
function hakke_kuuhekishou( keys )
	local caster = keys.caster
	local caster_location = caster:GetAbsOrigin()
	local ability = keys.ability
	local target_point = keys.target_points[1]
	local forwardVec = (target_point - caster_location):Normalized()

	-- Projectile variables
	local wave_speed = ability:GetLevelSpecialValueFor("wave_speed", (ability:GetLevel() - 1))
	local wave_width = ability:GetLevelSpecialValueFor("wave_width", (ability:GetLevel() - 1))
	local wave_range = ability:GetLevelSpecialValueFor("wave_range", (ability:GetLevel() - 1))
	local wave_location = caster_location
	local wave_particle = keys.wave_particle

	-- Creating the projectile
	local projectileTable =
	{
		EffectName = wave_particle,
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

	-- Timer to provide vision
	Timers:CreateTimer( function()
		-- Calculating the distance traveled
		wave_location = wave_location + forwardVec * (wave_speed * 1/30)

		-- Reveal the area after the projectile passes through it


		local distance = (wave_location - caster_location):Length2D()

		-- Checking if we traveled far enough, if yes then destroy the timer
		if distance >= wave_range then
			return nil
		else
			return 1/30
		end
	end)
end