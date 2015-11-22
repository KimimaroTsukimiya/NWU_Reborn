   function applyPoisonModifier( keys )
 	if not keys.target:IsBuilding() then
 		keys.ability:ApplyDataDrivenModifier(keys.caster, keys.target, keys.modifier_name, {})
 	end
 end

