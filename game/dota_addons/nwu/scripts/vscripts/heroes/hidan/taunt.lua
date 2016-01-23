--[[Author: Pizzalol
	Date: 09.02.2015.
	Forces the target to attack the caster
]]
function taunt( keys )
	local caster = keys.caster
	local target = keys.target

	-- Clear the force attack target
	target:SetForceAttackTarget(nil)

	-- Give the attack order if the caster is alive
	-- otherwise forces the target to sit and do nothing
	if caster:IsAlive() then
		local order = 
		{
			UnitIndex = target:entindex(),
			OrderType = DOTA_UNIT_ORDER_ATTACK_TARGET,
			TargetIndex = caster:entindex()
		}

		ExecuteOrderFromTable(order)
	else
		target:Stop()
	end

	-- Set the force attack target to be the caster
	target:SetForceAttackTarget(caster)
end

-- Clears the force attack target upon expiration
function tauntEnd( keys )
	local target = keys.target

	target:SetForceAttackTarget(nil)
end
--[[Author: LearningDave
	Date: November, 2th 2015.
	Increases the Str of the caster for each attack received.
]]
function growStrength( keys )
	local caster = keys.caster
	local attacker = keys.attacker
	local str_duration = keys.ability:GetLevelSpecialValueFor( "str_duration", ( keys.ability:GetLevel() - 1 ) )
	keys.ability.removeIt = true
	if attacker:IsHero() then
		keys.ability.bonusStr = keys.ability.bonusStr + 3
		keys.ability.removeIt = false
		Timers:CreateTimer( str_duration, function()
          	keys.ability.bonusStr = keys.ability.bonusStr - 3
          	if keys.ability.removeIt then 
          		keys.caster:RemoveModifierByName(keys.modifier_name)
          	end
			return nil
		end
		)
	else 
		keys.ability.bonusStr = keys.ability.bonusStr + 2
		keys.ability.removeIt = true
		Timers:CreateTimer( str_duration, function()
          	keys.ability.bonusStr = keys.ability.bonusStr - 2
          	if keys.ability.removeIt then 
          		keys.caster:RemoveModifierByName(keys.modifier_name)
          	end
			return nil
		end
		)
	end

	keys.ability:ApplyDataDrivenModifier(keys.caster, keys.caster, keys.modifier_name, {Duration = str_duration})
	keys.caster:SetModifierStackCount(keys.modifier_name, caster, keys.ability.bonusStr)
end
--[[Author: LearningDave
	Date: November, 2th 2015.
	Initates the variables for growStrength
]]
function initiateTaunt( keys )
	keys.ability.bonusStr = 0
	keys.ability.removeIt = false
end

function playSound( keys )
	local random = math.random(1, 5)
		print(random)
	if random == 1 then

		EmitSoundOn("hidan_taunt",keys.caster)
	elseif random == 2 then
		EmitSoundOn("hidan_taunt_2",keys.caster)
	elseif random == 3 then
		EmitSoundOn("hidan_taunt_3",keys.caster)
	elseif random == 4 then
		EmitSoundOn("hidan_taunt_4",keys.caster)
	elseif random == 5 then
		EmitSoundOn("hidan_taunt_5",keys.caster)
	end
end