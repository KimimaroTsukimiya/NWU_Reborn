anko_senei_jyashu = class({})
LinkLuaModifier( "modifier_senei_jyashu", "modifiers/modifier_senei_jyashu.lua",LUA_MODIFIER_MOTION_NONE )

--[[Author: Zenicus
	Modified from Bristleback's bristleback ability
	Date: 11.05.2015.]]
--------------------------------------------------------------------------------

function anko_senei_jyashu(param)

	local parent = param.target

	local caster = self.caster

	-- Search for Targets based on range
	-- Randomly Pick one from all targets
	-- (animation) Shoot Out Snakes
	-- Apply Damage

	print ("Anko")

	local final_damage = params.snake_damage
		-- The table containing the information needed for ApplyDamage.
	local damage_table =
	{
		victim = parent,
		attacker = params.caster,
		damage = final_damage,
		damage_type = params.ability:GetAbilityDamageType(),
		damage_flags = DOTA_DAMAGE_FLAG_NONE,
	}

	ApplyDamage(damage_table)
	-- Apply Magic Resistance
	self.magicResist = self:GetSpecialValueFor( "magic_resist" ) 

	caster.AddNewModifier(caster, self, "modifier_senei_jyashu", {})

end
--------------------------------------------------------------------------------