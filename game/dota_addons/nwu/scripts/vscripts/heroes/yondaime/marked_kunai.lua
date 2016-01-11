function marked_kunai(keys)
	if keys.caster:HasModifier(keys.modifierCheck) then
		keys.ability:ApplyDataDrivenModifier(keys.caster, keys.caster, keys.modifier, {})
	else
		keys.caster:RemoveModifierByName(keys.modifier)
	end	
end

function createDaggerParticle( keys )

	if keys.caster.daggers == nil then
		keys.caster.daggers = {}
	end

	-- Variables
	local caster = keys.caster
	local ability = keys.ability
	local target_point = keys.target_points[1]

	-- Special Variables
	local duration = ability:GetLevelSpecialValueFor("dagger_duration", (ability:GetLevel() - 1))

	-- Dummy
	local dummy = CreateUnitByName("npc_marked_kunai", target_point, false, caster, caster, caster:GetTeam())
	dummy:SetOriginalModel("models/heroes/clinkz/clinkz_arrow.vmdl")
	dummy:AddNewModifier(caster, nil, "modifier_phased", {})
	dummy:SetModelScale(4.0)
	ability:ApplyDataDrivenModifier(caster, dummy, "modifier_yondaime_marked_kunai", {duration = duration})

	dummy:SetUnitName("npc_marked_kunai")

	table.insert(keys.caster.daggers, dummy)
	ability.kunai = dummy


	local kunai_duration = ability:GetLevelSpecialValueFor("dagger_duration", (ability:GetLevel() - 1))

	Timers:CreateTimer( kunai_duration, function()
				dummy:RemoveSelf()
				return nil
	end
	)

end


function damage_unit( keys )
	if keys.target:IsBuilding() then
		return
	end
	print("gotcha")
	-- Special Variables
	local ability = keys.ability
	local creep_damage = ability:GetLevelSpecialValueFor("creep_damage", (ability:GetLevel() - 1))
	local hero_damage = ability:GetLevelSpecialValueFor("hero_damage", (ability:GetLevel() - 1))

	if keys.target:IsRealHero() then
		ApplyDamage({ victim = keys.target, attacker = keys.caster, damage = hero_damage, damage_type = DAMAGE_TYPE_MAGICAL })
	else
		ApplyDamage({ victim = keys.target, attacker = keys.caster, damage = creep_damage, damage_type = DAMAGE_TYPE_MAGICAL })
	end

end


function startKunai( keys )

	local caster = keys.caster
	local ability = keys.ability
	local casterOrigin = caster:GetAbsOrigin()
	local targetPos = keys.target_points[1]
	local direction = targetPos - casterOrigin
	local dagger_radius = ability:GetLevelSpecialValueFor("dagger_radius", (ability:GetLevel() - 1))
	local distance = math.sqrt(direction.x * direction.x + direction.y * direction.y)



	direction = direction / direction:Length2D()

	ProjectileManager:CreateLinearProjectile( {
		Ability				= ability,
		EffectName			= "particles/units/heroes/yondaime/kunai_alt.vpcf",
		vSpawnOrigin		= casterOrigin,
		fDistance			= distance,
		fStartRadius		= dagger_radius,
		fEndRadius			= dagger_radius,
		Source				= caster,
		bHasFrontalCone		= false,
		bReplaceExisting	= false,
		iUnitTargetTeam		= DOTA_UNIT_TARGET_TEAM_ENEMY,
		iUnitTargetFlags	= DOTA_UNIT_TARGET_FLAG_NONE,
		iUnitTargetType		= DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_CREEP,
	--	fExpireTime			= ,
		bDeleteOnHit 		= false,
		vVelocity			= direction * keys.speed,
		bProvidesVision		= false,
		iVisionRadius		= 300,
		iVisionTeamNumber	= caster:GetTeamNumber(),
	} )

end

function learn_flicker( keys )
	local flicker = keys.caster:FindAbilityByName("yondaime_body_flicker")
	flicker:SetLevel(keys.ability:GetLevel())
end
