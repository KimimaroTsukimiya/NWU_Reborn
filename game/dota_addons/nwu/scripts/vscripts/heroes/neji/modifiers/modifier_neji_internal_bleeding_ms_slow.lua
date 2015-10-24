modifier_neji_internal_bleeding_ms_slow = class({})

function modifier_neji_internal_bleeding_ms_slow:IsDebuff()
    return 1
end

function modifier_neji_internal_bleeding_ms_slow:IsHidden()
    return 0
end

function modifier_neji_internal_bleeding_ms_slow:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_MOVESPEED_BASE_OVERRIDE
    }
    return funcs
end
--[[ ============================================================================================================
    Author: Dave
    Date: October 24, 2015
    -- adds a modifier which slows the target on x percent(depening on the 'neji_byakugan' level)
================================================================================================================= ]]
function modifier_neji_internal_bleeding_ms_slow:GetModifierMoveSpeedOverride(keys)
    local ability_index = self:GetCaster():FindAbilityByName("neji_byakugan"):GetAbilityIndex()
    local ability = self:GetCaster():GetAbilityByIndex(ability_index)
    local ability_level = ability:GetLevel()
    local ms = self:GetCaster():GetIdealSpeed()
    local new_ms = ms
    if ability_level == 0 then
        new_ms = ms - ((ms / 100) * 15)
    elseif ability_level == 1 then
        new_ms = ms - ((ms / 100) * 30)
    elseif ability_level == 2 then
        new_ms = ms - ((ms / 100) * 45)
    elseif ability_level == 3 then
        new_ms = ms - ((ms / 100) * 60)
    elseif ability_level == 4 then
        new_ms =ms - ((ms / 100) * 70)
    end 
    return new_ms
end
