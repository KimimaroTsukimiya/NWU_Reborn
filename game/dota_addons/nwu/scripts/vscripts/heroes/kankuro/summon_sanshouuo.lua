
function summon_sanshouuo( keys )
	local caster = keys.caster
	local duration = keys.Duration
	local health = keys.Health
	local puppet = keys.Puppet
	
	local ability_index = keys.caster:FindAbilityByName("kankuro_kugusta_no_jutsu"):GetAbilityIndex()
    local kugusta_ability = keys.caster:GetAbilityByIndex(ability_index)
    local bonus_hp = 0
    if kugusta_ability:GetLevel() > 0 then
    	bonus_hp = kugusta_ability:GetLevelSpecialValueFor("extra_hp", kugusta_ability:GetLevel() - 1)
	end


	local sanshouuo  = CreateUnitByName("npc_sanshouuo", keys.caster:GetAbsOrigin(), true, caster, caster, caster:GetTeamNumber())
	sanshouuo:AddNewModifier(caster, nil, "modifier_phased", { duration = (duration+0.5) } )
	
	sanshouuo:SetMaxHealth(health)
	sanshouuo:SetHealth(health)
	sanshouuo:SetMaxHealth(sanshouuo:GetMaxHealth() + bonus_hp)
	sanshouuo:SetHealth(sanshouuo:GetMaxHealth() + bonus_hp)

	keys.ability:ApplyDataDrivenModifier( sanshouuo, sanshouuo, keys.Modifier, {} )
	

	Timers:CreateTimer( duration+1, function()
		if sanshouuo:IsAlive() then
			keys.target:ForceKill(false)
		end
		return nil
		end
	)

end

function end_summon( keys )
	keys.target:ForceKill(false)
end

function takeDamage( keys )
	local sanshouuo = keys.caster
	local target = keys.unit
	local attacker = keys.attacker
	local damage = keys.Damage
	
	local max_absorb = sanshouuo:GetHealth()
	if( max_absorb < damage )then
		damage = max_absorb
		sanshouuo:RemoveModifierByName("modifier_sanshouuo")
	else
		sanshouuo:SetHealth(max_absorb-damage)
	end
	
	target:SetHealth( target:GetHealth() + damage )
end