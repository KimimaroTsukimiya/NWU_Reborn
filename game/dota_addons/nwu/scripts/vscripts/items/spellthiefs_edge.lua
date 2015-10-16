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
	keys.caster:SetModifierStackCount( keys.modifier_name, keys.ability, 3)
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