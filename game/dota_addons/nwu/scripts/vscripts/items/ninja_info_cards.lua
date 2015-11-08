require('utilities')
--[[ ============================================================================================================
	Author: Dave
	Date: October 15, 2015
	Gives the caster gold if he attacks a enemy hero. shortCD = applies of passive is used, longCD applies on killed creep
	longCD is changed on the even listener OnEntityKilled->events.lua
================================================================================================================= ]]
function givegold(keys)
	local target = keys.target
	local caster = keys.caster
	local ability = keys.ability
	local max_stacks = ability:GetLevelSpecialValueFor("gain_gold_max_stacks", (ability:GetLevel() - 1))
	local gold_gain_cd = ability:GetLevelSpecialValueFor("gold_gain_cd", (ability:GetLevel() - 1))
	local gold_gain = ability:GetLevelSpecialValueFor("gold_gain", (ability:GetLevel() - 1))
	local extra_damage = ability:GetLevelSpecialValueFor("extra_damage_on_harras", (ability:GetLevel() - 1))
	local current_stacks = keys.ability.current_stacks
	local modifier_name = "item_nina_info_cards_modifier"
		if target:IsHero() and (target:GetTeamNumber() ~= caster:GetTeamNumber()) and keys.ability.current_stacks > 0  and not keys.ability.longCD then 
			-- add gold to caster
			caster:ModifyGold(gold_gain, false, 0)
			-- make player see his bonus gold
			PopupGoldGain(caster, gold_gain)
			--reduce stack count
			keys.ability.current_stacks = keys.ability.current_stacks - 1
			--applies extra magical damage to the target
			local damageTable = {
				victim = target,
				attacker = caster,
				damage = extra_damage,
				damage_type = 'DAMAGE_TYPE_MAGICAL'
			}
			ApplyDamage( damageTable )
			--show the new stack to the player
			caster:SetModifierStackCount( modifier_name, ability, keys.ability.current_stacks)
			--call stackItem-> starts timers to restack the item
			GameMode:StackItem(gold_gain_cd, max_stacks, modifier_name, keys.ability, keys.caster)	
	end
end
--[[ ============================================================================================================
	Author: Dave
	Date: October 15, 2015
	-- Initiates the values for 'givegold'
================================================================================================================= ]]
function initgivegold( keys )
	local max_stacks = keys.ability:GetLevelSpecialValueFor("gain_gold_max_stacks", (keys.ability:GetLevel() - 1))
	keys.ability.current_stacks = 3
	keys.ability.shortCD = false
	keys.ability.longCD = false
	keys.ability.extra_gold_total = 0
	keys.caster:SetModifierStackCount( keys.modifier_name, keys.ability, 3)
	keys.caster:SetModifierStackCount( keys.modifier_name_extra, keys.ability, 0)
end
--[[Author: LearningDave
  Date: october, 19th 2015.
  Resets the Cooldown of 'item_item_ninja_info_cards' if the Caster kills a enemy creep.
  ]]
function ninjaInfoCardsSetCD(killedUnit, killerEntity)
  --Support Item Check
  if killedUnit:IsNeutralUnitType() and killerEntity:IsRealHero() and killerEntity:HasItemInInventory("item_ninja_info_cards") and killedUnit:GetTeamNumber() ~= killerEntity:GetTeamNumber() then 
      local itemIndex = GameMode:GetItemIndex("item_item_ninja_info_cards", killerEntity)
      killerEntity:GetItemInSlot(itemIndex):StartCooldown(12)
      killerEntity:GetItemInSlot(itemIndex).longCD = true
      Timers:CreateTimer( 12, function()
          killerEntity:GetItemInSlot(itemIndex).longCD = false
          return nil
      end
      )
  end
end
--[[Author: LearningDave
  Date: october, 19th 2015.
  Give the caster extra gold without popping it up.
]]
function extraGold( keys)
	local caster = keys.caster
	local ability = keys.ability
	local extra_gold_per_seconds = ability:GetLevelSpecialValueFor("extra_gold_per_seconds", (ability:GetLevel() - 1))
	local extra_gold_total = ability:GetLevelSpecialValueFor("extra_gold_total", (ability:GetLevel() - 1))
	caster:ModifyGold(extra_gold_per_seconds, false, 0)
	keys.ability.extra_gold_total = keys.ability.extra_gold_total + extra_gold_per_seconds
	keys.caster:SetModifierStackCount( keys.modifier_name, keys.ability, keys.ability.extra_gold_total)
end
