modifier_guy_power_of_youth = class({})

function modifier_guy_power_of_youth:IsBuff()
    return 1
end

function modifier_guy_power_of_youth:IsHidden()
    return 0
end

function modifier_guy_power_of_youth:IsPassive()
    return 1
end

function modifier_guy_power_of_youth:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
    }
    return funcs
end
--[[ ============================================================================================================
    Author: Dave
    Date: October 24, 2015
    
================================================================================================================= ]]
function modifier_guy_power_of_youth:GetModifierAttackSpeedBonus_Constant(keys)
    PrintTable(keys)
    local ability_index = self:GetCaster():FindAbilityByName("guy_power_of_youth"):GetAbilityIndex()
    local ability = self:GetCaster():GetAbilityByIndex(ability_index)
    print(ability.new_attack_speed)
    return ability.new_attack_speed
end
