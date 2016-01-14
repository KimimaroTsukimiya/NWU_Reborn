function applyDamage( keys )

  if keys.caster:IsRealHero() then
    local caster = keys.caster
    local ability = keys.ability
    local radius = ability:GetLevelSpecialValueFor("radius", ability:GetLevel() - 1 )
    local aoe_damage = ability:GetLevelSpecialValueFor("aoe_damage", ability:GetLevel() - 1 )
    local targetEntities = FindUnitsInRadius(caster:GetTeamNumber(), caster:GetAbsOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, FIND_ANY_ORDER, false)

    if targetEntities then
      for _,target in pairs(targetEntities) do
        ApplyDamage({ victim = target, attacker = caster, damage = aoe_damage, damage_type = DAMAGE_TYPE_MAGICAL })
        local fire = ParticleManager:CreateParticle("particles/dire_fx/fire_barracks_glow_b.vpcf",  PATTACH_ABSORIGIN_FOLLOW, keys.target)
        ParticleManager:SetParticleControlEnt(fire, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), false)
      end
    end

  end
end



--[[ ============================================================================================================
  Author: Rook
  Date: January 30, 2015
  Called regularly while Radiance's aura is affecting a unit.  Damages them.
  Additional parameters: keys.AuraDamageInterval and keys.AuraDamagePerSecond
================================================================================================================= ]]
function modifier_item_radiance_datadriven_aura_on_interval_think(keys)
  local damage_to_deal = keys.AuraDamagePerSecond * keys.AuraDamageInterval   --This gives us the damage per interval.
  ApplyDamage({victim = keys.target, attacker = keys.caster, damage = damage_to_deal, damage_type = DAMAGE_TYPE_MAGICAL,})
end