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

function modifier_neji_internal_bleeding_ms_slow:GetModifierMoveSpeedOverride()

	local ms_slow_given = -15
	local ability = self:GetAbility():GetCaster():FindAbilityByName("neji_byakugan")
	local ability_level = ability:GetLevel()
	local ms = self:GetAbility():GetCaster():GetIdealSpeed()

	local new_ms = ms

	if ability_level == 0 then
		ms_slow_given = -15
		new_ms = (ms / 100) * (100 - 15)
	elseif ability_level == 1 then
		ms_slow_given = -30
		new_ms = (ms / 100) * (100 - 30)
	elseif ability_level == 2 then
		ms_slow_given = -45
		new_ms = (ms / 100) * (100 - 45)
	elseif ability_level == 3 then
		ms_slow_given = -60
		new_ms = (ms / 100) * (100 - 60)
	elseif ability_level == 4 then
		ms_slow_given = -70
		new_ms = (ms / 100) * (100 - 70)
	end

	return new_ms
end
