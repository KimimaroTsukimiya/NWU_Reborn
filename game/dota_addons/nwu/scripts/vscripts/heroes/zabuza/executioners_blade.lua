function execute( keys )
	local target = keys.target
	local caster = keys.caster
	local target_hp_percent = target:GetHealth() / (target:GetMaxHealth() / 100) 
	if target_hp_percent <= 35 or target:HasModifier("modifier_demon_mark") then
		if not target:IsBuilding() then
			keys.ability:ApplyDataDrivenModifier(caster, caster, "modifier_executioners_blade_crit", {duration = 0.3})
		end
	end
end