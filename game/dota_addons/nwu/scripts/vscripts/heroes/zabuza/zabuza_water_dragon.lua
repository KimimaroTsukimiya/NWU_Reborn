--[[
	Author: kritth
	Date: 5.1.2015.
	Init: Register units to become target
]]
function register_unit( keys )
	-- Variables
	local caster  = keys.caster
	local ability = keys.ability
	local target  = keys.target
	local index   = keys.target:entindex()
	-- Register
	if ability.units_hit[index] == nil then
		ability.units_hit[index] = true
		local damage = ability:GetAbilityDamage()
		if ability.first_target == nil then
			damage = damage / 2
		end
		local damage_table = {
			victim = target,
			attacker = caster,
			damage = damage,
			damage_type = ability:GetAbilityDamageType()
		}
		ApplyDamage(damage_table)
		if ability.first_target == nil then
			ability.first_target = target
			ability:ApplyDataDrivenModifier(caster, target, "modifier_zabuza_water_dragon_slow_debuf", {})
			print("first target")
		else
			ability:ApplyDataDrivenModifier(caster, target, "modifier_zabuza_water_dragon_half_slow_debuf", {})
			print("other targets")
		end
	end
end

--[[
	Author: kritth, Pizzalol
	Date: 01.10.2015.
	Main: Start traversing upon timer while providing vision, reducing damage and speed per units hit, and also destroy trees
]]
function start_traverse( keys )
	-- Variables
	local caster = keys.caster
	local ability = keys.ability
	local startAttackSound = "Ability.PowershotPull"
	local startTraverseSound = "Ability.Powershot"
	local projectileName = "particles/units/heroes/hero_windrunner/windrunner_spell_powershot.vpcf"
	local caster_location = caster:GetAbsOrigin()
	local point = keys.target_points[1]
	local ability_level = ability:GetLevel() - 1
	
	-- Stop sound event and fire new one, can do this in datadriven but for continuous purpose, let's put it here
	-- StopSoundEvent( startAttackSound, caster )
	-- StartSoundEvent( startTraverseSound, caster )

	-- Ability variables
	local direction = (point - caster_location):Normalized()
	local max_movespeed = ability:GetLevelSpecialValueFor( "arrow_speed", ability_level )
	ability.units_hit = {}
	ability.first_target = nil

	-- Create projectile
	local projectileTable =
	{
		EffectName = projectileName,
		Ability = ability,
		vSpawnOrigin = caster_location,
		vVelocity = Vector(direction.x * max_movespeed, direction.y * max_movespeed, 0),
		fDistance = ability:GetLevelSpecialValueFor( "arrow_range", ability_level ),
		fStartRadius = ability:GetLevelSpecialValueFor( "arrow_width", ability_level ),
		fEndRadius = ability:GetLevelSpecialValueFor( "arrow_width", ability_level ),
		Source = caster,
		bHasFrontalCone = false,
		bReplaceExisting = true,
		iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
		iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
		iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		iVisionRadius = ability:GetLevelSpecialValueFor( "vision_radius", ability_level ),
		iVisionTeamNumber = caster:GetTeamNumber()
	}
	ProjectileManager:CreateLinearProjectile( projectileTable )
end

--[[
	Author: muzk
	Date: 4.10.2015
	Helper: DPS damage
]]
function zabuza_water_dragon_damage_on_interval_think(keys)
	local ability      = keys.ability	
	local index_level  = ability:GetLevel() - 1
	local damage       = ability:GetLevelSpecialValueFor("dps_damage", index_level)
	if keys.target ~= ability.first_target then
		damage = damage / 2
	end
	ApplyDamage({victim=keys.target, attacker=keys.caster, damage=damage, damage_type=ability:GetAbilityDamageType()})
end