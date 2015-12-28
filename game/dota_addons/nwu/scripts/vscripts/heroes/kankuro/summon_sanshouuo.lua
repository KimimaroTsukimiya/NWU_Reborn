
function summon_sanshouuo( keys )
	local caster = keys.caster
	local duration = keys.Duration
	local health = keys.Health
	local puppet = keys.Puppet
	
	local sanshouuo  = CreateUnitByName("npc_karasu", keys.caster:GetAbsOrigin(), true, caster, caster, caster:GetTeamNumber())
	sanshouuo:AddNewModifier(caster, nil, "modifier_phased", { duration = (duration+0.5) } )
	
	sanshouuo:SetMaxHealth(health)
	sanshouuo:SetHealth(health)
	
	keys.ability:ApplyDataDrivenModifier( sanshouuo, sanshouuo, keys.Modifier, {} )
	
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