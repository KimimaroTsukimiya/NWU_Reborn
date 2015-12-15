
function hiraishin_dash( caster, keys )
	local fac_x = keys.fac_x
	local fac_y = fac_y.fac_y
	local origin_dist = keys.origin_dist
end

function hiraishin_getFacs( caster, target, ability )
	local origin = caster:GetAbsOrigin()
	local destination = target:GetAbsOrigin()
	
	local vector = destination - origin
	vector = vector:Normalized()
	
	local normal_fac = 1/vector.x
	local normalized_v2 = Vector(vector.x , vector.y , 0 ) * normal_fac
	local vec_at_origin = origin - ( normalized_v2 * origin.x )
	
	local normal = Vector(-vector.y,vector.x,0)
	
	local fac_x = normal.x
	local fac_y = normal.y
	local origin_dist = vec_at_origin.y
	
	return {fac_x,fac_y,origin_dist}
end

function hiraishin( keys )
	local caster = keys.caster
	local target = keys.target	--location

	--Find the closest seal	
	local placed_seals = caster.placed_seals
	
	local closest_seal = nil
	local min_dist = 1000 --Maximum allowed distance

	for k,v in pairs(placed_seals) do
		local dist = target - v:GetAbsOrigin()
		
		if dist:Length2D < min_dist then
			min_dist = dist:Length2D
			closest_seal = v
		end
	end
	
	if ( not closest_seal ) then
		return
	end
	
	local hiraishinFacs = hiraishin_getFacs( caster , closest_seal , keys.ability )
	
end