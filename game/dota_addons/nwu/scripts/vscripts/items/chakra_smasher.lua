--[[Mana drain and damage part of Mana Break
	Author: Pizzalol
	Date: 16.12.2014.
	NOTE: Currently works on magic immune enemies, can be fixed by checking for magic immunity before draining mana and dealing damage]]
function ManaBreak( keys )

	if not keys.target:IsBuilding() and keys.target:GetMaxMana() > 0 then

		EmitSoundOn("Hero_Antimage.ManaBreak", keys.target)

		local particle = ParticleManager:CreateParticle("particles/generic_gameplay/generic_manaburn.vpcf",  PATTACH_ABSORIGIN_FOLLOW, keys.target)
		ParticleManager:SetParticleControlEnt(particle, 1, keys.target, PATTACH_POINT_FOLLOW, "attach_hitloc", keys.target:GetAbsOrigin(), false)


		local target = keys.target
		local caster = keys.caster
		local ability = keys.ability
		local manaBurn = ability:GetLevelSpecialValueFor("mana_per_hit", (ability:GetLevel() - 1))
		local manaDamage = ability:GetLevelSpecialValueFor("damage_per_burn", (ability:GetLevel() - 1))

		local damageTable = {}
		damageTable.attacker = caster
		damageTable.victim = target
		damageTable.damage_type = ability:GetAbilityDamageType()
		damageTable.ability = ability
		damageTable.damage_flags = DOTA_UNIT_TARGET_FLAG_NONE -- Doesnt seem to work?

		-- Checking the mana of the target and calculating the damage
		if(target:GetMana() >= manaBurn) then
			damageTable.damage = manaBurn * manaDamage
			target:ReduceMana(manaBurn)
		else
			damageTable.damage = target:GetMana() * manaDamage
			target:ReduceMana(manaBurn)
		end

		ApplyDamage(damageTable)

	end
end


function Purge( event )
	local target = event.target
	
	-- Purge Enemy
	local RemovePositiveBuffs = true
	local RemoveDebuffs = false
	local BuffsCreatedThisFrameOnly = false
	local RemoveStuns = false
	local RemoveExceptions = false
	target:Purge( RemovePositiveBuffs, RemoveDebuffs, BuffsCreatedThisFrameOnly, RemoveStuns, RemoveExceptions)
end

function SummonDamage( event )
	local caster = event.caster
	local target = event.target
	local ability = event.ability
	local damage_to_summons = ability:GetLevelSpecialValueFor("damage_to_summons", (ability:GetLevel() - 1))

	if target:IsSummoned() or target:IsDominated() then
		ApplyDamage({ victim = target, attacker = caster, damage = damage_to_summons, damage_type = DAMAGE_TYPE_MAGICAL })
	end
end