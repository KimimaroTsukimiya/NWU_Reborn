 function gale_blade( keys )
 	if not keys.target:IsBuilding() then
 		keys.ability:ApplyDataDrivenModifier(keys.caster, keys.caster, keys.modifier_name, {})
 	end
 end
