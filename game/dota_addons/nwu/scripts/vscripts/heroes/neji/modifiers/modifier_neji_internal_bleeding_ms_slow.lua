if modifier_neji_internal_bleeding_ms_slow == nil then
    modifier_neji_internal_bleeding_ms_slow = class({})
end

--[[
    Author: Bude
    Date: 30.09.2015.
    Checks target health every interval and adjusts health regen accordingly
]]--

function modifier_neji_internal_bleeding_ms_slow:IsDebuff()
    return 1
end

function modifier_neji_internal_bleeding_ms_slow:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT
    }

    return funcs
end

function modifier_neji_internal_bleeding_ms_slow:GetModifierMoveSpeedBonus_Constant(keys)
	return keys.ms_slow_given
end
