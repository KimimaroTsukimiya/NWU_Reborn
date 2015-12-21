function chidori_koken_check( keys )
	local caster = keys.caster
	local ability = keys.ability
	ListenToGameEvent( "dota_player_used_ability", function( event )
			local player = PlayerResource:GetPlayer(event.PlayerID)
			-- Check if player existed
			if player then
				local hero = player:GetAssignedHero()
				-- Check if it is corrent hero
				if hero == caster then
					-- Check if ability on cast bar is casted
					local ability_count = caster:GetAbilityCount()
					for i = 0, (ability_count - 1) do
						local ability_at_slot = caster:GetAbilityByIndex( i )
						if ability_at_slot and ability_at_slot:GetAbilityName() == event.abilityname then
							ability:ApplyDataDrivenModifier( caster, caster, "modifier_chidori_koken_damage_datadriven", {} )
							break
						end
					end
				end
			end
	end, nil)
end

function releaseAoeDamage (keys)

if keys.target:GetTeamNumber() ~= keys.caster:GetTeamNumber() then

		local caster = keys.caster
		local aoe_radius = keys.ability:GetLevelSpecialValueFor("aoe_radius", keys.ability:GetLevel() - 1)
		local damage = keys.ability:GetAbilityDamage()
		local target = keys.target

		EmitSoundOn("Hero_StormSpirit.Overload", target)

		local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_stormspirit/stormspirit_overload_discharge.vpcf", PATTACH_ABSORIGIN, keys.target) 
		ParticleManager:SetParticleControlEnt(particle, 0, keys.caster, PATTACH_ABSORIGIN, "attach_hitloc", keys.caster:GetAbsOrigin(), true)
					
		
		caster:RemoveModifierByName("modifier_chidori_koken_damage_datadriven")


		local targetEntities = FindUnitsInRadius(caster:GetTeamNumber(), target:GetAbsOrigin(), nil, aoe_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_CREEP, 0, FIND_ANY_ORDER, false)
		
		if targetEntities then
			for _,target in pairs(targetEntities) do
				print(abilityDamageType)
				print(damage)
				print(target)
				print(caster)
				local damageTable = {
						victim = target,
						attacker = caster,
						damage = damage,
						damage_type = DAMAGE_TYPE_MAGICAL
					}
				ApplyDamage( damageTable )
				keys.ability:ApplyDataDrivenModifier(caster, target, "modifier_chidori_koken_debuff_datadriven", {})
			end
		end

end
end