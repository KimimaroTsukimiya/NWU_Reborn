--- Itachi amateratsu
-- @author	muZk
-- @brief	Itachi amateratsu ability functions

--- Initialize ability variables
function initialize(event)
	event.ability.saved_damage = 0
end

--- Save damage taken by target
function save_damage(event)
	local ability = event.ability
	ability.saved_damage = ability.saved_damage + ability:GetLevelSpecialValueFor( "attack_damage", ( ability:GetLevel() - 1 ) )
end

--- Deals DPS damage
function deal_dps_damage(event)
	local ability    = event.ability
	local target     = event.target
	local damage     = ability:GetLevelSpecialValueFor( "damage", ( ability:GetLevel() - 1 ) )
	local factor     = ability:GetLevelSpecialValueFor( "damage_factor", ( ability:GetLevel() - 1 ) )
	local dps_damage = damage + ability.saved_damage * factor
	ApplyDamage({victim = target, attacker = event.caster, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL})
end