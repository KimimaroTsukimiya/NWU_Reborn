--[[
	Author: LearningDave
	Date: november, 2th 2015.
	Reset Hidan's hp if he would die by the received damage
]]
function ResetHp( keys )
	-- Variables
	local caster = keys.caster
	local ability = keys.ability
	local cooldown = ability:GetCooldown( ability:GetLevel() )
	local reset_hp_percentage = keys.ability:GetLevelSpecialValueFor("reset_hp_percentage", keys.ability:GetLevel() - 1 )
	local cooldown = ability:GetCooldown( ability:GetLevel() )
	local modifierName = "modifier_jashins_blessing"
	if not keys.caster:IsAlive() then
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
