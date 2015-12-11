function parts_poison(keys)

	local caster = keys.caster
	local caster_location = caster:GetAbsOrigin() 
	local player = caster:GetPlayerOwnerID()
	local ability = keys.ability

	print("Parts Poison")
	ability:ApplyDataDrivenModifier(caster, caster, keys.modifier_name, {})
end

--[[ ============================================================================================================
	Author: Zenicus
	Date: February 4, 2015
	Called regularly while Poison Attack is affecting a unit.  Damages them.
	Additional parameters: keys.PoisonDamagePerSecond and keys.PoisonDamageInterval
================================================================================================================= ]]
function modifier_parts_poison_attack_on_interval_think(keys)	

	print("Poisoned")
	local damage_to_deal = keys.PoisonDamagePerSecond * keys.PoisonDamageInterval   --This gives us the damage per interval.
	local current_hp = keys.caster:GetHealth()
	
	if damage_to_deal >= current_hp then  --Poison Attack damage over time is non-lethal, so deal less damage if needed.
		damage_to_deal = current_hp - 1
	end
	
	ApplyDamage({victim = keys.target, attacker = keys.caster, damage = damage_to_deal, damage_type = DAMAGE_TYPE_MAGICAL,})
end