function resetCooldown( keys )
	keys.ability:StartCooldown(keys.ability:GetCooldown(keys.ability:GetLevel() - 1))
end