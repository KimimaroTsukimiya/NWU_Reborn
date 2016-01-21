function do_damage(event)
	local ability = event.ability
	local caster = event.caster
	local target = event.target
	local max_life = target:GetMaxHealth() 
	local threshold = max_life * ability:GetLevelSpecialValueFor("threshold_factor", ability:GetLevel()-1)
	local current_life = target:GetHealth()
	local damage = threshold -- assume the target is below threshold (use threshold instead of max_life to prevent bugs)
	local damage_type = ability:GetAbilityDamageType()

	if current_life > threshold then
		damage = target:GetMaxHealth() * ability:GetLevelSpecialValueFor("damage_factor", ability:GetLevel() - 1)
	end
	local currenthppercent = target:GetHealth() / (target:GetMaxHealth() / 100)
	print(currenthppercent)

	--ParticleManager:CreateParticle("particles/blood_impact/blood_advisor_pierce_spray.vpcf", PATTACH_POINT, target)
	ApplyDamage({ victim = target, attacker = caster, damage = damage, damage_type = damage_type })
end