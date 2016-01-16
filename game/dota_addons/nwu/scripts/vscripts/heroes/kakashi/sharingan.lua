--[[
	Author: Mognakor (recode)
	Date: december, 4th 2015.
	Gives the caster the 2nd Ability of the target.
]]

local Kakashi_Sharingan = {} -- the table representing the class, which will double as the metatable for the instances
Kakashi_Sharingan.__index = Kakashi_Sharingan -- failed table lookups on the instances should fallback to the class table, to get methods

function Kakashi_Sharingan.new(caster,ability)
  local self = setmetatable({}, Kakashi_Sharingan)
  
  self.caster = caster
  self.ability = ability
  
  return self
end

function Kakashi_Sharingan:LevelUp_Stolen(keys)
	print("LevelUp_Stolen",self.caster:GetPlayerID(),keys.player)
	
	print("Sharingan")
	for k,v in pairs(self) do
		print(k,v)
	end
	
	print("keys")
	for k,v in pairs(keys) do
		print(k,v)
	end
	print("endkeys")
	
	if( self.caster:GetPlayerID() ~= (keys.player-1) ) then
		print("PlayerMismatch", self.caster:GetPlayerID() , (keys.player-1) )
		return;
	end
	
	local lvlUpAbil = nil
	if( keys.abilityname == "kakashi_sharingan" ) then
		lvlUpAbil = self.ability
	else
		print(self.ability:GetAbilityName(),keys.abilityname)
		if(	self.ability:GetAbilityName() ~= keys.abilityname ) then
			return
		end
		lvlUpAbil = self.caster:FindAbilityByName("kakashi_sharingan")
	end
	
	lvlUpAbil:SetLevel(lvlUpAbil:GetLevel()+1)
end

function sharingan( keys )
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	local ability_level = ability:GetLevel()
	local copy_timer =  ability:GetLevelSpecialValueFor("copy_timer", (ability:GetLevel() - 1))
	
	if (target == caster) or (target:GetPlayerID() == caster:GetPlayerID()) then
		ability:EndCooldown()
		return
	end
	
	if( caster.sharingan_ability ) then
		sharingan_end( keys )
	end
	
	local ability1_name = target:GetAbilityByIndex(1):GetName()
	local copy_ability = caster:AddAbility(ability1_name)
	copy_ability:SetLevel(ability_level)

	caster:SwapAbilities("kakashi_empty", ability1_name, false, true)
	caster.sharingan_ability = ability1_name
	
	caster.sharingan_event = ListenToGameEvent("dota_player_learned_ability", Dynamic_Wrap(Kakashi_Sharingan,"LevelUp_Stolen"), Kakashi_Sharingan.new(caster,copy_ability))
	
	ability:ApplyDataDrivenModifier(
			caster,
			caster,
			"kakashi_sharingan_modifier",
			{duration = copy_timer}
		)
end

function sharingan_end(keys)
	local caster = keys.caster
	caster:SwapAbilities("kakashi_empty", caster.sharingan_ability, true, false)
	caster:RemoveAbility(caster.sharingan_ability)
	StopListeningToGameEvent(caster.sharingan_event)
	caster.sharingan_ability =  nil
end