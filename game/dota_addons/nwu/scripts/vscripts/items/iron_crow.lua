function iron_crow( keys )
	if not keys.target:IsBuilding() and keys.ability:IsCooldownReady() and keys.caster:IsRealHero() then
		keys.ability:ApplyDataDrivenModifier(keys.caster, keys.target, keys.modifier_name, {})
		keys.ability:StartCooldown(keys.ability:GetCooldown(keys.ability:GetLevel()))
	end
end