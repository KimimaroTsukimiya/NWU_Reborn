function upgrade( keys )
	local jump_ability = keys.caster:FindAbilityByName( "yondaime_hiraishin_jump" )
	
	if( jump_ability ) then
		jump_ability:SetLevel( keys.ability:GetLevel() )
	end
end

function create_seal( keys )
	local caster = keys.caster
	local target = keys.target_points[1]
	local ability = keys.ability
	local modifier = keys.modifier
	
	if not caster.placed_seals then
		caster.placed_seals = {}
	end
	
	local placed_seals = caster.placed_seals
	
	local seal = CreateUnitByName( keys.seal , target , false, caster, nil, caster:GetTeamNumber() )
	
	ability:ApplyDataDrivenModifier( caster, seal, modifier, {} )
	
	placed_seals[ seal:entindex() ] = seal
end

function remove_seal( keys )
	keys.caster.placed_seals[ keys.target:entindex() ] = nil
	keys.target:ForceKill(false)
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
		
		local damage = caster:GetAverageTrueAttackDamage()
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
	closest_seal:RemoveModifierByName("modifier_hiraishin_seal")
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

function hiraishin_dash( caster, closest_seal, keys, hiraishinFacs )
	local fac_x = 0
	local fac_y = 0
	local origin_dist = keys.origin_dist
	
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
			ability = keys.ability
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

function hiraishin( keys )
	local caster = keys.caster
	local target = keys.target_points[1]

	--Find the closest seal	
	local placed_seals = caster.placed_seals
	
	local closest_seal = nil
	local min_dist = 1000 --Maximum allowed distance
	
	for k,v in pairs(placed_seals) do
		if(	(caster:GetAbsOrigin() - v:GetAbsOrigin()):Length2D() < 1000 )then
				
			local dist = target - v:GetAbsOrigin()
			
			if dist:Length2D() < min_dist then
				min_dist = dist:Length2D()
				closest_seal = v
			end
		
		end
	end
	
	print("closest_seal",closest_seal)
	
	if ( not closest_seal ) then
		return
	end
	
	local hiraishinFacs = hiraishin_getFacs( caster , closest_seal , keys.ability )
	
	hiraishin_dash(caster,closest_seal,keys,hiraishinFacs)
	
end