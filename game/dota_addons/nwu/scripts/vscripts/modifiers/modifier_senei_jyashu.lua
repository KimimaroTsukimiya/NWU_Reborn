modifier_senei_jyashu = class({})

function modifier_senei_jyashu:DeclareFunctions()
	local funcs_array = {
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
	}

	return funcs_array
end

function modifier_senei_jyashu:OnCreated( kv )
	print ("Anko Senei Ability created.", self:GetAbility():GetLevelSpecialValueFor("senei_jyashu_magic_resist", ability:GetLevel()-1))
	self.magic_resist = self:GetAbility():GetLevelSpecialValueFor("senei_jyashu_magic_resist", ability:GetLevel()-1) 
end

function modifier_senei_jyashu:GetModifierMagicalResistanceBonus()
	print ("Applied Magic Resist=",self.magic_resist)
	return self.magic_resist
end