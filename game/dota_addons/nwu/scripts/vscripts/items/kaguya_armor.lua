--[[
	Author: Noya - Modifed LearningDave
	Date: 03.10.2015
]]
function Return( event )
	-- Variables

	local caster = event.caster
	local attacker = event.attacker
	local damage = event.Damage
	local abilityDamageType = event.ability:GetAbilityDamageType()
	print(abilityDamageType)
	
	if attacker:IsBuilding() or Kaguya_Skip then
		return
	end
	
	Kaguya_Skip = true
	
	-- Damage
	ApplyDamage({
		victim = attacker,
		attacker = caster,
		damage = damage,
		damage_type = DAMAGE_TYPE_PURE,
		damage_flags = DOTA_DAMAGE_FLAG_REFLECTION
	})

	
	Kaguya_Skip = false
end

function Init(keys)
	if Kaguya_Skip == nil then
		Kaguya_Skip = false
	end
end