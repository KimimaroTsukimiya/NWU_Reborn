modifier_anko_senei_ta_jashu_ms_slow = class({})

function modifier_anko_senei_ta_jashu_ms_slow:IsDebuff()
    return 1
end

function modifier_anko_senei_ta_jashu_ms_slow:IsHidden()
    return 0
end

function modifier_anko_senei_ta_jashu_ms_slow:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_MOVESPEED_BASE_OVERRIDE
    }
    return funcs
end
--[[ ============================================================================================================
    Author: Zenicus
    Date: November 11, 2015
    -- adds a modifier which slows the target on x percent
================================================================================================================= ]]
function modifier_anko_senei_ta_jashu_ms_slow:GetModifierMoveSpeedOverride(keys)

    print ("Current ms", self:GetIdealSpeed())

    local ability_index = self:GetCaster():FindAbilityByName("anko_senei_ta_jashu"):GetAbilityIndex()
    local ability = self:GetCaster():GetAbilityByIndex(ability_index)

    print ("Ability", ability)
    local ms_slow = ability:GetLevelSpecialValueFor("move_slow", (ability:GetLevel() - 1))

    local current_ms = self:GetIdealSpeed()

    print ("MS_slow =", ms_slow)
    local new_ms = current_ms + current_ms*(ms_slow/100)

    print ("Final ms=", new_ms)
    
    return new_ms
end
