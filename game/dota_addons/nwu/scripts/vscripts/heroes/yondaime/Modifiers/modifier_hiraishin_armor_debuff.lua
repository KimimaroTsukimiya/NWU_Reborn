modifier_hiraishin_armor_debuff = class({})

--------------------------------------------------------------------------------

function modifier_hiraishin_armor_debuff:IsDebuff()
	return true
end

--------------------------------------------------------------------------------

--------------------------------------------------------------------------------

function modifier_hiraishin_armor_debuff:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
    }
    return funcs
end
--[[ ============================================================================================================
    Author: Dave
    Date: October 24, 2015
    -- adds a modifier which slows the target on x percent(depening on the 'neji_byakugan' level)
================================================================================================================= ]]
function modifier_hiraishin_armor_debuff:GetModifierPhysicalArmorBonus(keys)
    return self:GetAbility():GetSpecialValueFor( "armor_reduction")
end