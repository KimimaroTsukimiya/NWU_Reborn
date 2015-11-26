--- Itachi amateratsu
-- @author	muZk
-- @brief	Itachi amateratsu ability functions

--- Initialize ability variables
function initialize(event)
	local duration = event.ability:GetLevelSpecialValueFor("duration", event.ability:GetLevel() - 1)
	event.ability.saved_damage = 0
	event.ability:ApplyDataDrivenModifier(event.caster, event.target, "modifier_itachi_amateratsu", {duration = duration})
end

--- Save damage taken by target
function save_damage(event)
	local ability = event.ability
	ability.saved_damage = ability.saved_damage + event.Damage
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

-- Spreads the amaterasu dot to nearby units
function spread_fire( event )
	local target = event.target
	local spread_aoe = event.ability:GetLevelSpecialValueFor( "spread_aoe", ( event.ability:GetLevel() - 1 ) )
	local duration     = event.ability:GetLevelSpecialValueFor( "duration", ( event.ability:GetLevel() - 1 ) )
	local allyEntities = FindUnitsInRadius(event.caster:GetTeamNumber(), target:GetAbsOrigin(), nil, spread_aoe, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, FIND_ANY_ORDER, false)
  
	if allyEntities then
		for _,ally in pairs(allyEntities) do
			print(ally)
			if not ally:HasModifier("modifier_itachi_amateratsu_spread_fire") and not ally:HasModifier("modifier_itachi_amateratsu_spread_fire_cd") then
				event.ability:ApplyDataDrivenModifier(event.caster, ally, "modifier_itachi_amateratsu_spread_fire", {Duration = duration})
				event.ability:ApplyDataDrivenModifier(event.caster, ally, "modifier_itachi_amateratsu_spread_fire_cd", {Duration = 55})
			end
		end
	end
end