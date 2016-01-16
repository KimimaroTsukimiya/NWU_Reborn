--[[ ============================================================================================================
	Author: Zenicus
	Date: December 13, 2015
	Called when the dismantle part attacks on a target.
================================================================================================================= ]]

function parts_poison(keys)

	print("Poisoned")
	local damage_to_deal = keys.PoisonDamagePerSecond * keys.PoisonDamageInterval   --This gives us the damage per interval.
	local current_hp = keys.caster:GetHealth()
	print("Poisoned Damage", damage_to_deal)
	if damage_to_deal >= current_hp then  --Poison Attack damage over time is non-lethal, so deal less damage if needed.
		damage_to_deal = current_hp - 1
	end
	
	ApplyDamage({victim = keys.target, attacker = keys.caster, damage = damage_to_deal, damage_type = DAMAGE_TYPE_MAGICAL,})
end

function applyPoison( keys )

	if not keys.target:IsBuilding() then
		keys.ability:ApplyDataDrivenModifier(keys.caster, keys.target, "modifier_poison_dot", {Duration = keys.PoisonDuration})
	end

end