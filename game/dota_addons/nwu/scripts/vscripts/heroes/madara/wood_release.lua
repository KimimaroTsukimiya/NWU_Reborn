--[[
	Author: LearningDave
	Date: 25.10.2015.
	Creates 10 Trees for a given aoe.
]]
function wood_release( keys )
	local radius = keys.ability:GetLevelSpecialValueFor("radius", keys.ability:GetLevel() - 1)
	local tree_duration = keys.ability:GetLevelSpecialValueFor("tree_duration", keys.ability:GetLevel() - 1)
	local tree_vision = keys.ability:GetLevelSpecialValueFor("tree_vision", keys.ability:GetLevel() - 1)
	local target_point = keys.target_points[1]
	local tree_count = 10
	local scope = math.pi * radius
	local posX = 0
	local posY = 0
	local r = radius / 2
	for i = 1,tree_count do
			posX = target_point.x + r * math.cos((math.pi*2/tree_count) * i)
			posY = target_point.y + r * math.sin((math.pi*2/tree_count) * i)
			CreateTempTree( Vector( posX, posY, 0.0 ), tree_duration )
			--local dummy = CreateUnitByName( "npc_tree", Vector(posX, posY, 0.0), false, keys.caster, nil, keys.caster:GetTeamNumber() )
	end
	AddFOWViewer( keys.caster:GetTeamNumber(), target_point, tree_vision, tree_duration, false )
end