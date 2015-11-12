modifier_senei_jyashu = class({})

function modifier_senei_jyashu:DeclareFunctions()
	local funcs_array = {
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
	}

	return funcs_array
end

function modifier_senei_jyashu:OnCreated( kv )
	self.magic_resist = self:GetAbility():GetSpecialValueFor( "magic_resist" )
end

function modifier_senei_jyashu:GetModifierMagicalResistanceBonus()
	print ("Applied Magic Resist")
	return self:GetSpecialValueFor( "magic_resist" ) 
end