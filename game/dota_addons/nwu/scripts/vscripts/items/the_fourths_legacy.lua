function ChannelTeleport( event )
	local caster = event.caster
	local target = event.target

		-- Start teleport
	local ability = event.ability
	local teleport_delay = ability:GetSpecialValueFor("teleport_delay")
	local radius = ability:GetSpecialValueFor("radius")
	ability:ApplyDataDrivenModifier(caster, caster, "modifier_scroll_of_town_portal_caster", {duration=teleport_delay})

	caster:EmitSound("Hero_KeeperOfTheLight.Recall.Cast")

	if not target:IsBuilding() then 
		target:AddNewModifier(caster, ability, "modifier_stunned", {})
	end

	event.ability.particle_caster = ParticleManager:CreateParticle("particles/items2_fx/teleport_end.vpcf", PATTACH_ABSORIGIN, caster)
	local particle_caster = event.ability.particle_caster
	ParticleManager:SetParticleControl(particle_caster, 0, caster:GetAbsOrigin())
	ParticleManager:SetParticleControl(particle_caster, 1, caster:GetAbsOrigin())
	ParticleManager:SetParticleControl(particle_caster, 2, Vector(255, 255, 255))
	ParticleManager:SetParticleControl(particle_caster, 4, caster:GetAbsOrigin())
	event.ability.particle_target = ParticleManager:CreateParticle("particles/items2_fx/teleport_end.vpcf", PATTACH_ABSORIGIN, target)
	local particle_target = event.ability.particle_target
	ParticleManager:SetParticleControl(particle_target, 0, target:GetAbsOrigin())
	ParticleManager:SetParticleControl(particle_target, 1, target:GetAbsOrigin())
	ParticleManager:SetParticleControl(particle_target, 2, Vector(255, 255, 255))
	ParticleManager:SetParticleControl(particle_target, 4, target:GetAbsOrigin())

	ability:StartCooldown(ability:GetCooldown(ability:GetLevel()))	
end

function FinishTeleport(keys)
	local caster = keys.caster
	local target = keys.target
	local player = caster:GetPlayerOwner()
	FindClearSpaceForUnit(caster, target:GetAbsOrigin(), true)
	caster:StopSound("Hero_KeeperOfTheLight.Recall.Cast")
	ParticleManager:DestroyParticle(keys.ability.particle_caster, false)
	ParticleManager:DestroyParticle(keys.ability.particle_target, false)
end