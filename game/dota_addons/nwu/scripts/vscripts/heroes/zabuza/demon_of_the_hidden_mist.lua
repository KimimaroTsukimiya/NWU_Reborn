function markEnemy( keys )
	local duration = keys.ability:GetLevelSpecialValueFor("duration", (keys.ability:GetLevel() - 1))
	keys.ability:ApplyDataDrivenModifier(keys.caster,keys.target,"modifier_demon_mark",{duration = duration})
	keys.ability.markedEnemy = keys.target
end

function checkDistance( keys )
	local distance = (keys.ability.markedEnemy:GetAbsOrigin() - keys.caster:GetAbsOrigin()):Length2D()
	print(distance)


	if distance >= 1500 then
		keys.caster:RemoveModifierByName("modifier_demon_unkillable")
		keys.ability.markedEnemy:RemoveModifierByName("modifier_demon_mark")
	end
end


