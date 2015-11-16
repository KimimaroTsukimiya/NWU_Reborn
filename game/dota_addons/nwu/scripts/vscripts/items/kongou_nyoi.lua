function passiveAOE( keys )
	if keys.caster:IsRealHero() then

		keys.caster:EmitSound("Hero_Brewmaster.ThunderClap")

		local particle = ParticleManager:CreateParticle( "particles/units/heroes/hero_brewmaster/brewmaster_thunder_clap.vpcf", PATTACH_POINT_FOLLOW, keys.target )
    	
    	local targetEntities = FindUnitsInRadius(keys.caster:GetTeamNumber(), keys.target:GetAbsOrigin(), nil, keys.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, FIND_ANY_ORDER, false)

    	if targetEntities then
			for _,target in pairs(targetEntities) do
				local damageTable = {
						victim = target,
						attacker = keys.caster,
						damage = keys.damage,
						damage_type = keys.ability:GetAbilityDamageType()
					}
				ApplyDamage( damageTable )
			end
		end
	end
end