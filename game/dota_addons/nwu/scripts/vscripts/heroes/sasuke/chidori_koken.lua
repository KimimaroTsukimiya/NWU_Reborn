function chidori_koken_check( keys )
	local caster = keys.caster
	local ability = keys.ability
	ListenToGameEvent( "dota_player_used_ability", function( event )
			local player = PlayerResource:GetPlayer( event.PlayerID )
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
							ability:ApplyDataDrivenModifier( caster, caster, "modifier_overload_damage_datadriven", {} )
							break
						end
					end
				end
			end
	end, nil)
end