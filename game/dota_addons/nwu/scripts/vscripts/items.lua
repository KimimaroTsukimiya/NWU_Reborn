require('items/spellthiefs_edge')

--[[Author: LearningDave
  Date: october, 19th 2015.
  Fires all functions from SpellThiefsEdge listening to OnEntityKilled
]]
function   GameMode:SpellThiefsEdgeOnEntityKilled(killedUnit, killerEntity)
  spellThiefsEdgeSetCD(killedUnit, killerEntity)
  spellThiefsEdgeDeny(killedUnit, killerEntity)
  spellThiefsEdgeCarryLastHit(killedUnit, killerEntity)
end
