 --[[
  Author: LearningDave
  Date: 25.10.2015.
  Checks if enemy targets are in a given aoe and apply the 'burning_tree_dot' modifier if they dont have them yet
]]
 function burning_tree( keys )
  local ability_level = keys.ability:GetLevel() - 1
  local duration  = keys.ability:GetLevelSpecialValueFor("duration", ability_level)
  local radius  = keys.ability:GetLevelSpecialValueFor("radius", ability_level)
  local targetEntities = FindUnitsInRadius(keys.caster:GetTeamNumber(), keys.caster:GetAbsOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
    if targetEntities then
      for _,oneTarget in pairs(targetEntities) do
        local modfifier = oneTarget:FindModifierByName("burning_tree_dot")
        if modifier == nil then
          keys.ability:ApplyDataDrivenModifier(keys.caster, oneTarget, "burning_tree_dot", {Duration = duration})
          local particle = ParticleManager:CreateParticle("particles/dire_fx/fire_barracks_glow_b.vpcf", PATTACH_ABSORIGIN_FOLLOW, nil) 
          ParticleManager:SetParticleControl(particle , 0, oneTarget:GetAbsOrigin())
        end
      end
    end
 end
