--[[
	Author: LearningDave
	Date: october, 5th 2015.
	Absorbs damage up to the max absorb, substracting from the shield until removed.
]]
function Shield( event )
	-- Variables
	local caster = event.caster
	local max_damage_absorb = event.ability:GetLevelSpecialValueFor("charge_damage_amount", event.ability:GetLevel() - 1 )
	print(max_damage_absorb)
	-- Reset the shield
	caster.RaitonShield = max_damage_absorb
end

function ShieldAbsorb( event )
	-- Variables

	
	local damage = event.DamageTaken --Check if it only takes physical damage as it should
	local damageReductionPercent = event.ability:GetLevelSpecialValueFor("physical_damage_reduce_percent", event.ability:GetLevel() - 1 )
	local reducedDamage = damage / 100 * damageReductionPercent
	local unit = event.unit
	local ability = event.ability
	print("Damagetype "..damage:GetAbilityDamageType())
	-- Track how much damage was already absorbed by the shield
	local shield_remaining = unit.RaitonShield
	print("Shield Remaining: "..shield_remaining)
	print("Damage Taken pre Absorb: "..damage)

		-- TODO ONLY REDUCE PHYSICAL DAMAGE!!!
		-- If the damage is bigger than what the shield can absorb, heal a portion
		if damage > shield_remaining then
			local reducedDamageRemainingShield = shield_remaining / 100 * damageReductionPercent
			local reducedDamageIncome = shield_remaining - reducedDamageRemainingShield
			local noReducedDamage = damage - shield_remaining
			local newHealth = unit.OldHealth - reducedDamageIncome - noReducedDamage
			print("Old Health: "..unit.OldHealth.." - New Health: "..newHealth.." - Absorbed: "..shield_remaining.." - DamageTakenReduced: "..reducedDamageIncome)
			unit:SetHealth(newHealth)
		else
			local damageIncome = damage - reducedDamage
			local newHealth = unit.OldHealth - damageIncome
			unit:SetHealth(newHealth)
			print("Old Health: "..unit.OldHealth.." - New Health: "..newHealth.." - Absorbed: "..damage.." - DamageTaken: "..damageIncome)
		end

		-- Reduce the shield remaining and remove
		unit.RaitonShield = unit.RaitonShield-damage
		if unit.RaitonShield <= 0 then
			unit.RaitonShield = nil
			unit:RemoveModifierByName("modifier_raiton_no_yoroi_charge")
			print("--Shield removed--")
		end

		if unit.RaitonShield then
			print("Shield Remaining after Absorb: "..unit.RaitonShield)
			print("---------------")
		end


end

-- Destroys the particle when the modifier is destroyed. Also plays the sound
function EndShieldParticle( event )
	local target = event.target
	--target:EmitSound("Hero_Abaddon.AphoticShield.Destroy") TODO sound on removing shield
	--ParticleManager:DestroyParticle(target.ShieldParticle,false) TODO remove lighting particle
end


-- Keeps track of the targets health
function ShieldHealth( event )
	local target = event.target
	target.OldHealth = target:GetHealth()
end