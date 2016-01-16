yondaime_hiraishin_jump = class({})
LinkLuaModifier( "modifier_hiraishin_armor_debuff", "heroes/yondaime/modifiers/modifier_hiraishin_armor_debuff.lua" ,LUA_MODIFIER_MOTION_NONE )


function yondaime_hiraishin_jump:OnSpellStart( keys )

	local ability = self
	local caster = ability:GetCaster()
	local target = ability:GetCursorPosition()
	caster.ulti = ability

	PrintTable(caster.daggers)
	--Find the closest seal	
	local placed_seals = caster.daggers
	
	local closest_seal = nil
	local min_dist = 1000 --Maximum allowed distance
	
	for k,v in pairs(placed_seals) do
		print("yo")
		if not v:IsNull() then
			if(	(target - v:GetAbsOrigin()):Length2D() < 1000 )then
					
				local dist = target - v:GetAbsOrigin()
				
				if dist:Length2D() < min_dist then
					min_dist = dist:Length2D()
					closest_seal = v
				end
			
			end
		end
	end
	
	print("closest_seal",closest_seal)
	
	if ( not closest_seal ) then
		ability:EndCooldown()
		caster:SetMana(caster:GetMana() + ability:GetManaCost(ability:GetLevel()))
		return
	end



	local hiraishinFacs = hiraishin_getFacs( caster , closest_seal , ability )

	hiraishin_dash(caster,closest_seal,ability, hiraishinFacs)

end


function yondaime_hiraishin_jump:CastFilterResultTarget( target )
	local ability = self
	local caster = ability:GetCaster()


	print(target:GetUnitName())



	if target:GetUnitName() == "npc_marked_kunai" then 
		return UF_SUCCESS
	else
		return UF_FAIL_CUSTOM
	end
	return ""
end
  
function yondaime_hiraishin_jump:GetCustomCastErrorTarget( target )
	local ability = self
	local caster = ability:GetCaster()


	if target:GetUnitName() == "npc_marked_kunai" then 
		return ""
	else
		return "#error_must_target_owner_illusion"
	end
	return ""
end


function hiraishin_dash( caster, closest_seal, ability, hiraishinFacs )
	
	local mid = ( caster:GetAbsOrigin() + closest_seal:GetAbsOrigin() ) / 2
	local radius = ( caster:GetAbsOrigin() - closest_seal:GetAbsOrigin() ):Length2D() + 20
	
	local targetEntities = FindUnitsInRadius(caster:GetTeamNumber(), mid, nil,
		radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_CREEP + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
	
	hiraishin_filter(targetEntities,hiraishinFacs)
	
	targetEntities = hiraishin_order(targetEntities,caster)
	
	local timer_tbl =
		{
			callback = hiraishin_dashDO,
			caster = caster,
			closest_seal = closest_seal,
			targetEntities = targetEntities,
			ability = ability
		}
	
	--Movement
	Timers:CreateTimer(timer_tbl)
end

function hiraishin_getFacs( caster, target, ability )
	local origin = caster:GetAbsOrigin()
	local destination = target:GetAbsOrigin()
	
	local vector = destination - origin
	vector = vector:Normalized()
	
	local normal = Vector(-vector.y,vector.x,0)
	normal = normal:Normalized()
	
	return {
		origin = origin,
		normal = normal
	}
end


function spairs(t, order)
    -- collect the keys
    local keys = {}
    for k in pairs(t) do keys[#keys+1] = k end

    -- if order function given, sort by it by passing the table and keys a, b,
    -- otherwise just sort the keys 
    if order then
        table.sort(keys, function(a,b) return order(t, a, b) end)
    else
        table.sort(keys)
    end

    -- return the iterator function
    local i = 0
    return function()
        i = i + 1
        if keys[i] then
            return keys[i], t[keys[i]]
        end
    end
end

function hiraishin_dashDO(gameEntity, keys)

	local targetEntities = keys.targetEntities
	local caster=keys.caster
	
	local particleSlashName = "particles/units/heroes/hero_juggernaut/juggernaut_omni_slash_tgt.vpcf"
	local particleTrailName = "particles/units/heroes/hero_juggernaut/juggernaut_omni_slash_trail.vpcf"
	local slashSound = "Hero_Juggernaut.OmniSlash.Damage"
	
	for k,target in spairs(targetEntities) do
		print(k)
	
		local trailFxIndex = ParticleManager:CreateParticle( particleTrailName, PATTACH_CUSTOMORIGIN, caster )
		ParticleManager:SetParticleControl( trailFxIndex, 0, target:GetAbsOrigin() )
		ParticleManager:SetParticleControl( trailFxIndex, 1, caster:GetAbsOrigin() )
		
		Timers:CreateTimer( 0.1, function()
				ParticleManager:DestroyParticle( trailFxIndex, false )
				ParticleManager:ReleaseParticleIndex( trailFxIndex )
				return nil
			end
		)


		target:AddNewModifier(caster, caster.ulti, "modifier_hiraishin_armor_debuff", {duration = caster.ulti:GetSpecialValueFor( "armor_duration")})
		
		
		local damage = caster:GetAverageTrueAttackDamage()
		print(damage)
		local extra_damage = caster.ulti:GetSpecialValueFor( "damage")
		print(extra_damage)
		local damage = damage / 100 * extra_damage
		print(damage)


		ApplyDamage({attacker = caster, victim = target, ability = keys.ability, damage = damage, damage_type = keys.ability:GetAbilityDamageType()})
		--caster:PerformAttack(target, true, false, true, false)
		
		-- Slash particles
		local slashFxIndex = ParticleManager:CreateParticle( particleSlashName, PATTACH_ABSORIGIN_FOLLOW, target )
		StartSoundEvent( slashSound , caster )

		Timers:CreateTimer( 0.1, function()
				ParticleManager:DestroyParticle( slashFxIndex, false )
				ParticleManager:ReleaseParticleIndex( slashFxIndex )
				StopSoundEvent( slashSound, caster )
				return nil
			end
		)	
	
		FindClearSpaceForUnit(caster,target:GetAbsOrigin(),false)
		
		targetEntities[ k ] = nil
		return 0.05
	end
	
	local closest_seal = keys.closest_seal
	
	local trailFxIndex = ParticleManager:CreateParticle( particleTrailName, PATTACH_CUSTOMORIGIN, caster )
	ParticleManager:SetParticleControl( trailFxIndex, 0, closest_seal:GetAbsOrigin() )
	ParticleManager:SetParticleControl( trailFxIndex, 1, caster:GetAbsOrigin() )
	
	Timers:CreateTimer( 0.1, function()
			ParticleManager:DestroyParticle( trailFxIndex, false )
			ParticleManager:ReleaseParticleIndex( trailFxIndex )
			return nil
		end
	)
	
	FindClearSpaceForUnit(caster,closest_seal:GetAbsOrigin(),false)

	return nil
end

function hiraishin_filter(targetEntities,hiraishinFacs)
	local normal = hiraishinFacs.normal
	local origin = hiraishinFacs.origin

	local pos = 0
	local dist = 0
	
	for k,target in pairs(targetEntities) do
		pos = target:GetAbsOrigin()
			
		dist = normal:Dot((pos - origin))
		
		if( dist> 100 ) then
			targetEntities[ k ] = nil
		end
	end
end

function hiraishin_order(targetEntities,caster)
	local ordered = {}
	local origin = caster:GetAbsOrigin()
	
	for k,target in pairs(targetEntities) do
		local dist = (target:GetAbsOrigin() - origin):Length2D()
		
		ordered[ dist ] = target
	end
	
	return ordered
end