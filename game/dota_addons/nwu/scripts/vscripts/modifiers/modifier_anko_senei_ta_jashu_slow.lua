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
    Author: Dave
    Date: October 24, 2015
    -- adds a modifier which slows the target on x percent
================================================================================================================= ]]
function modifier_anko_senei_ta_jashu_ms_slow:GetModifierMoveSpeedOverride(keys)

   print ("Current ms", self:GetCaster():GetIdealSpeed())
   print ("Ability Slow", keys.ability:GetLevelSpecialValueFor("move_slow", (keys.ability:GetLevel() - 1)))
   local new_ms = self:GetCaster():GetIdealSpeed() 

    return new_ms
end
