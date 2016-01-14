--[[
	Author: LearningDave
	Date: november, 2th 2015.
	Resets Hidan's hp if he would die by the received damage
]]
function ResetHp( keys )

	if keys.caster:IsRealHero() then

	-- Variables
	local caster = keys.caster
	local ability = keys.ability
	local cooldown = ability:GetCooldown( ability:GetLevel() )
	local reset_hp_percentage = keys.ability:GetLevelSpecialValueFor("reset_hp_percentage", keys.ability:GetLevel() - 1 )
	local cooldown = ability:GetCooldown( ability:GetLevel() )
	local modifierName = "modifier_jashins_blessing"
	if not keys.caster:IsAlive() then


	local particle = ParticleManager:CreateParticle("particles/units/heroes/hidan/hidan_passive_a.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
	ParticleManager:SetParticleControl(particle, 0, caster:GetAbsOrigin())
	ParticleManager:SetParticleControl(particle, 1, caster:GetAbsOrigin()) 
	ParticleManager:SetParticleControl(particle, 3, caster:GetAbsOrigin()) 
	ParticleManager:DestroyParticle(keys.ability.buffeffect, true)
	

		EmitSoundOn("Hero_Omniknight.Purification", caster) 



		local hp = keys.caster:GetMaxHealth() / 100 * reset_hp_percentage
		keys.caster:SetHealth(hp)
		-- Remove cooldown
		caster:RemoveModifierByName( modifierName )
		ability:StartCooldown( cooldown )
		Timers:CreateTimer( cooldown, function()
				ability:ApplyDataDrivenModifier( caster, caster, modifierName, {} )
				return nil
			end
		)
		end

	end
end


function BuffEffect( keys)

		-- Variables
	local caster = keys.caster
	local ability = keys.ability
	local cooldown = ability:GetCooldown( ability:GetLevel() )
	local reset_hp_percentage = keys.ability:GetLevelSpecialValueFor("reset_hp_percentage", keys.ability:GetLevel() - 1 )
	local cooldown = ability:GetCooldown( ability:GetLevel() )
	local modifierName = "modifier_jashins_blessing"

	local particle = ParticleManager:CreateParticle("particles/units/heroes/hidan/hidan_passive_ready_a.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
	ParticleManager:SetParticleControlEnt(particle, 3, caster, PATTACH_POINT_FOLLOW, "attach_origin", caster:GetAbsOrigin(), true)
	keys.ability.buffeffect = particle 

end