--[[
	Author: LearningDave
	Date: October, 27th 2015
	Swaps Position of Caster and his Illusion
]]
naruto_kage_bunshin_mastery = class({})

function naruto_kage_bunshin_mastery:OnSpellStart( event )
	local ability = self
	local caster = ability:GetCaster()
	local target = ability:GetCursorTarget()
	local hero_position = caster:GetAbsOrigin()
	caster:AddNoDraw()
	target:AddNoDraw()
	FindClearSpaceForUnit( caster, target:GetAbsOrigin(), false )
	FindClearSpaceForUnit( target, hero_position, false )
	caster:RemoveNoDraw()
	target:RemoveNoDraw()
end

--------------------------------------------------------------------------------
 
function naruto_kage_bunshin_mastery:CastFilterResultTarget( target )
	local ability = self
	local caster = ability:GetCaster()

	-- Check illusion target
	if target:IsIllusion() and target:GetTeamNumber() == caster:GetTeamNumber() then 
		return UF_SUCCESS
	else
		return UF_FAIL_CUSTOM
	end
	return ""
end
  
function naruto_kage_bunshin_mastery:GetCustomCastErrorTarget( target )
	local ability = self
	local caster = ability:GetCaster()

	-- Check illusion target
	if target:IsIllusion() and target:GetTeamNumber() == caster:GetTeamNumber() then 
		return ""
	else
		return "#error_must_target_owner_illusion"
	end
	return ""
end