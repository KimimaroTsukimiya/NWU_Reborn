--[[ ============================================================================================================
	Author: Dave
	Date: October 23, 2015
	 -- Applies a DOT(damage over time) to the target and popups the damage amount
================================================================================================================= ]]
function internal_bleeding( keys )
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	local bleeding_damage = ability:GetLevelSpecialValueFor("damage_per_tick", (ability:GetLevel() - 1))
	local damageType = ability:GetAbilityDamageType()
	local damageTable = {
						victim = target,
						attacker = caster,
						damage = bleeding_damage,
						damage_type = damageType
					}
	ApplyDamage( damageTable )
	PopupDamage(target, bleeding_damage)
end


function startEffect( keys )
	local particle = ParticleManager:CreateParticle("particles/units/heroes/neji/neji_w_debuff_a.vpcf", PATTACH_ABSORIGIN_FOLLOW, keys.target)
	ParticleManager:SetParticleControl(particle, 0, keys.target:GetAbsOrigin()) -- Origin
	ParticleManager:SetParticleControlEnt(particle, 3, keys.target, PATTACH_POINT_FOLLOW, "attach_hitloc", keys.target:GetAbsOrigin(), true)
	keys.ability.dotParticle = particle
end

function endEffect( keys )
	ParticleManager:DestroyParticle(keys.ability.dotParticle, true) 
end