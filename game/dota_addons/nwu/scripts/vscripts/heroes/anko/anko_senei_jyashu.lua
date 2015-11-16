anko_senei_jyashu = class({})
--LinkLuaModifier( "modifier_senei_jyashu", "modifiers/modifier_senei_jyashu.lua",LUA_MODIFIER_MOTION_NONE )

--[[Author: Zenicus
	Modified from Bristleback's bristleback ability
	Date: 11.05.2015.]]
--------------------------------------------------------------------------------
function anko_senei_jyashu(params)

	local parent = params.target
	local ability = params.ability
	local radius = ability:GetSpecialValueFor("seek_radius")
	local duration =  ability:GetSpecialValueFor("snake_damage_interval")
	local final_damage = ability:GetSpecialValueFor("snake_damage")
	local caster = params.caster

	local team = caster:GetTeamNumber()
	local origin = caster:GetAbsOrigin()
	local iTeam = DOTA_UNIT_TARGET_TEAM_ENEMY
	local iType = DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO
	local iFlag = DOTA_UNIT_TARGET_FLAG_NONE
	local iOrder = FIND_ANY_ORDER

	--Sounds
	local sound_enemy = params.sound_enemy
	--Animations
	local mystic_snake_projectile = params.mystic_snake_projectile
	local particle_impact_enemy = params.particle_impact_enemy
	

	print ("Seeking Opponent")

	-- Search for Targets based on range
	local full_enemies = FindUnitsInRadius(team, origin, nil, radius, iTeam, iType, iFlag, iOrder, false)
	-- Randomly Pick one from all targets
	print ("Found Enemies", full_enemies, #full_enemies)

	--local target_enemy = 0
	local rnd = 0

	if (#full_enemies > 0) then
		print ("Found One", target_enemy)
		rnd = RandomInt(0, #full_enemies)

		print ("Rnd = ", rnd)

		local target_enemy = full_enemies[rnd]

		-- Apply Damage
		print ("Applying Dmg", final_damage, target_enemy)
		-- The table containing the information needed for ApplyDamage.
		local damage_table = {}

		damage_table.attacker = caster
		damage_table.damage_type = DAMAGE_TYPE_PHYSICAL
		damage_table.ability = ability
		damage_table.victim = target_enemy

		damage_table.damage = final_damage

		ApplyDamage(damage_table)

	end

	


	-- (animation) Shoot Out Snakes






end
