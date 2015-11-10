--[[Author: Amused/D3luxe
	Used by: Pizzalol
	Date: 11.07.2015.
	Blinks the target to the target point, if the point is beyond max blink range then blink the maximum range]]
function Blink(keys)
	local point = keys.target_points[1]
	local caster = keys.caster
	local casterPos = caster:GetAbsOrigin()
	local pid = caster:GetPlayerID()
	local difference = point - casterPos
	local ability = keys.ability
	local range = ability:GetLevelSpecialValueFor("blink_range", (ability:GetLevel() - 1))

	if difference:Length2D() > range then
		point = casterPos + (point - casterPos):Normalized() * range
	end

	FindClearSpaceForUnit(caster, point, false)
	ProjectileManager:ProjectileDodge(caster)
	
	local blinkStart = ParticleManager:CreateParticle("particles/world_creature_fx/crows.vpcf", PATTACH_ABSORIGIN, caster)
	Timers:CreateTimer( 4, function()
			ParticleManager:DestroyParticle(blinkStart, false)
			return nil
		end
	)

	Timers:CreateTimer( 0.05, function()
			local blinkEnd = ParticleManager:CreateParticle("particles/world_creature_fx/crows.vpcf", PATTACH_ABSORIGIN, caster)
			Timers:CreateTimer( 4, function()
					ParticleManager:DestroyParticle(blinkEnd, false)
					return nil
				end
			)
			return nil
		end
	)


end