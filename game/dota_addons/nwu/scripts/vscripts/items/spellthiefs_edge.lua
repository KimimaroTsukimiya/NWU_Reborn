require('utilities')
--[[ ============================================================================================================
	Author: Dave
	Date: October 15, 2015
	Gives the caster gold if he attacks a enemy hero. shortCD = applies of passive is ued, longCD applies on killed creep
	longCD is changed on the even listener OnEntityKilled->gamemode.lua
================================================================================================================= ]]
function givegold(keys)
	local target = keys.target
	local caster = keys.caster
	local ability = keys.ability
	local max_stacks = ability:GetLevelSpecialValueFor("gain_gold_max_stacks", (ability:GetLevel() - 1))
	local gold_gain_cd = ability:GetLevelSpecialValueFor("gold_gain_cd", (ability:GetLevel() - 1))
	local gold_gain = ability:GetLevelSpecialValueFor("gold_gain", (ability:GetLevel() - 1))
	local current_stacks = keys.ability.current_stacks
	local modifier_name = "item_spellthiefs_edge_modifier"
		if target:IsHero() and (target:GetTeamNumber() ~= caster:GetTeamNumber()) and keys.ability.current_stacks > 0  and not keys.ability.longCD then 
			-- add gold to caster
			caster:ModifyGold(gold_gain, false, 0)
			-- make player see his bonus gold
			PopupGoldGain(caster, gold_gain)
			--reduce stack count
			keys.ability.current_stacks = keys.ability.current_stacks - 1
			--show the new stack to the player
			caster:SetModifierStackCount( modifier_name, ability, keys.ability.current_stacks)
			--if its not on cd do something
			if not keys.ability.shortCD then
			--set shordCD true so on reattack it wont trigger again
			keys.ability.shortCD = true
			--show the player the cooldown
			keys.ability:StartCooldown(gold_gain_cd)
			--start a timer once its reached do something
			Timers:CreateTimer( gold_gain_cd, function()
						--if the current stack didnt reach its max limit repeat the former steps (didnt know how to include recursion with timers)
						if keys.ability.current_stacks < max_stacks then
							keys.ability.shortCD = false
							keys.ability.current_stacks = keys.ability.current_stacks + 1
							keys.ability:StartCooldown(gold_gain_cd)
							caster:SetModifierStackCount( modifier_name, ability, keys.ability.current_stacks)
							-- calls a function which basicly does the same until max stacks are reached. 
							resetCDFirst(keys, modifier_name)
						end
						return nil
			end
			)
		end
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
--[[ ============================================================================================================
	Author: Dave
	Date: October 15, 2015
	I wasn't sure how recursion works with Timers, therefor i made 2 dirty functions. TODO CLEANER CODE
	Does check if the support item has less than 3 stacks, if so starts a timer which will add a stack after x seconds cd.
================================================================================================================= ]]
function resetCDFirst(keys, modifier_name)
	local max_stacks = keys.ability:GetLevelSpecialValueFor("gain_gold_max_stacks", (keys.ability:GetLevel() - 1))
	local gold_gain_cd = keys.ability:GetLevelSpecialValueFor("gold_gain_cd", (keys.ability:GetLevel() - 1))
	if not keys.ability.shortCD then
			keys.ability.shortCD = true
			keys.ability:StartCooldown(gold_gain_cd)
			Timers:CreateTimer( gold_gain_cd, function()
						if keys.ability.current_stacks < max_stacks  then
							keys.ability.shortCD = false
							keys.ability.current_stacks = keys.ability.current_stacks + 1
							keys.caster:SetModifierStackCount( modifier_name, keys.ability, keys.ability.current_stacks)
							resetCDSecond(keys, modifier_name)
						end
						return nil
				end
			)
	end
end
--[[ ============================================================================================================
	Author: Dave
	Date: October 15, 2015
	I wasn't sure how recursion works with Timers, therefor i made 2 dirty functions. TODO CLEANER CODE
	Does check if the support item has less than 3 stacks, if so starts a timer which will add a stack after x seconds cd.
================================================================================================================= ]]
function resetCDSecond(keys, modifier_name)
	local max_stacks = keys.ability:GetLevelSpecialValueFor("gain_gold_max_stacks", (keys.ability:GetLevel() - 1))
	local gold_gain_cd = keys.ability:GetLevelSpecialValueFor("gold_gain_cd", (keys.ability:GetLevel() - 1))

	if not keys.ability.shortCD then
			keys.ability.shortCD = true
			keys.ability:StartCooldown(gold_gain_cd)
			Timers:CreateTimer( gold_gain_cd, function()
						if keys.ability.current_stacks < max_stacks then
							keys.ability.shortCD = false

							keys.ability.current_stacks = keys.ability.current_stacks + 1
							keys.caster:SetModifierStackCount( modifier_name, keys.ability, keys.ability.current_stacks)
						end
						return nil
				end
			)
	end
end
--[[Author: LearningDave
  Date: october, 19th 2015.
  Resets the Cooldown of 'Spell thiefs edge' if the Caster kills a enemy creep.
  ]]
function spellThiefsEdgeSetCD(killedUnit, killerEntity)
  --Support Item Check
  if killedUnit:IsNeutralUnitType() and killerEntity:IsRealHero() and killerEntity:HasItemInInventory("item_spellthiefs_edge") and killedUnit:GetTeamNumber() ~= killerEntity:GetTeamNumber() then 
      local itemIndex = GameMode:GetItemIndex("item_spellthiefs_edge", killerEntity)
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
  Gives the Caster of 'spell thiefs edge' bonus gold if he denies a creep.
  ]]
function spellThiefsEdgeDeny(killedUnit, killerEntity)
  --Support Item Check
  if killedUnit:IsNeutralUnitType() and killerEntity:IsRealHero() and killerEntity:HasItemInInventory("item_spellthiefs_edge") and killedUnit:GetTeamNumber() == killerEntity:GetTeamNumber() then 
      --TODO add dynamic value goldgain isntead of + 5
        -- add gold to killerEntity(hero who denied the creep)
      killerEntity:ModifyGold(5, false, 0)
      -- make player see his bonus gold
      PopupGoldGain(caster, 5)
  end
end
--[[Author: LearningDave
  Date: october, 19th 2015.
  Gives the Caster of 'spell thiefs edge' bonus gold if he denies a creep.
  ]]
function spellThiefsEdgeCarryLastHit(killedUnit, killerEntity)
  --Support Item Check
  if killedUnit:IsNeutralUnitType() and killerEntity:IsRealHero() and killedUnit:GetTeamNumber() ~= killerEntity:GetTeamNumber() then 
  --TODO dynamic aoe for ally heroes
  local targetEntities = FindUnitsInRadius(killerEntity:GetTeamNumber(), killerEntity:GetAbsOrigin(), nil, 1000, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)

  --TODO add dynamic value goldgain instead of + 5
  if targetEntities then
    for _,target in pairs(targetEntities) do
      if target:HasItemInInventory("item_spellthiefs_edge") then
        local itemIndex = GameMode:GetItemIndex("item_spellthiefs_edge", target)
          if not target:GetItemInSlot(itemIndex).longCD then
           -- add gold to killerEntity ally hero
           target:ModifyGold(5, false, 0)
           -- make player see his bonus gold
           PopupGoldGain(target, 5)
          
          end 
        end
      end
    end
  end
end
--[[Author: LearningDave
  Date: october, 19th 2015.
  Does give an ally hero of the caster the gold of a minion last hit and the casteer itself aswell
  Kills the enemy basic units if it hits a certain percentage of its max % hp
]]
function shareLasthit(keys)
  local main_target = keys.target
  local caster = keys.caster
  local ability = keys.ability
  local max_stacks = ability:GetLevelSpecialValueFor("gain_gold_max_stacks", (ability:GetLevel() - 1))
  local gold_gain_cd = ability:GetLevelSpecialValueFor("gold_gain_cd", (ability:GetLevel() - 1))
  local gold_gain = ability:GetLevelSpecialValueFor("gold_gain", (ability:GetLevel() - 1))
  local gold_gain_aoe = ability:GetLevelSpecialValueFor("gold_gain_aoe", (ability:GetLevel() - 1))
  local kill_at_hp_percent = ability:GetLevelSpecialValueFor("kill_at_hp_percent", (ability:GetLevel() - 1))
  local gold_shared = false
  local modifier_name = "item_spellthiefs_edge_modifier"
  if main_target:IsNeutralUnitType() and caster:IsRealHero() and main_target:GetTeamNumber() ~= caster:GetTeamNumber() and keys.ability.current_stacks > 0  and not keys.ability.longCD then 
	  --TODO dynamic aoe for ally heroes
	  local target_hp_percent = main_target:GetHealth() / (main_target:GetMaxHealth() / 100)
	  if target_hp_percent <= kill_at_hp_percent then
	  	  GameMode:KillUnit(main_target)
		  local targetEntities = FindUnitsInRadius(caster:GetTeamNumber(), caster:GetAbsOrigin(), nil, gold_gain_aoe, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
		  if targetEntities then
		    for _,target in pairs(targetEntities) do
		      if not gold_shared then
		      		--TODO find out how to access random gold amount of creep
		           -- add gold to killerEntity ally hero
		           target:ModifyGold(45, false, 0)
		           -- make player see his bonus gold
		           PopupGoldGain(target, 45)
		           caster:ModifyGold(45, false, 0)
		           -- make player see his bonus gold
		           PopupGoldGain(caster, 45)
		          keys.ability.current_stacks = keys.ability.current_stacks - 1
		          caster:SetModifierStackCount( modifier_name, ability, keys.ability.current_stacks)
		          gold_shared = true
		         	GameMode:StackItem(gold_gain_cd, max_stacks, modifier_name, keys.ability, keys.caster)
		         
		        end
		      end
		    end
	  	end
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
