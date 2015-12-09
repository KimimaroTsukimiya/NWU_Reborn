--[[Author: LearningDave
  Date: october, 28th 2015.
  Plays/Stops game music on different game stages
  1 -- ??
  2 -- Loadingscreen
  3 -- Hero Selection
  4 -- ??
  5 -- ?? 
  6 -- ??
  7 -- Ingame
]]
function   GameMode:PlayGameMusic(gameState)
  local PlayerCount = PlayerResource:GetPlayerCount() - 1
  if  gameState == 2 then
    GameMode:PlayGameMusicForState2(PlayerCount)
  end
  if  gameState == 3 then
  	GameMode:PlayGameMusicForState3(PlayerCount); 
  end
  if  gameState == 7 then
  	GameMode:PlayGameMusicForState7(PlayerCount)
  end
end
--[[Author: LearningDave
  Date: october, 28th 2015.
  Plays/Stops game music on different on the 2nd Game State => LoadingScreen
]]
function GameMode:PlayGameMusicForState2(PlayerCount)
	 for i=0, PlayerCount do
          if PlayerResource:IsValidPlayer(i) then
            local player = PlayerResource:GetPlayer(i)
             EmitSoundOnClient("loading_screen", player)
          end
          
      end
end
--[[Author: LearningDave
  Date: october, 28th 2015.
  Plays/Stops game music on different on the 3rd Game State => Hero Selection
]]
function GameMode:PlayGameMusicForState3(PlayerCount)
	 for i=0, PlayerCount do     
          if PlayerResource:IsValidPlayer(i) then
            local player = PlayerResource:GetPlayer(i)
            player:StopSound("loading_screen")
            EmitSoundOnClient("hero_pick", player)
          end
        end
end
--[[Author: LearningDave
  Date: october, 28th 2015.
  Plays/Stops game music on different on the 7nd Game State => Ingame
]]
function GameMode:PlayGameMusicForState7(PlayerCount)
	for i=0, PlayerCount do        
		if PlayerResource:IsValidPlayer(i) then
			local player = PlayerResource:GetPlayer(i)
			player:StopSound("hero_pick")

		end
	end
end



--[[Author: LearningDave
  Date: december, 09th 2015.
]]
function GameMode:PlayKillSound(killer, killed)

  local killerName = killer:GetName()
  local killedName = killed:GetName()

  if killerName == "npc_dota_hero_dragon_knight" then 
    if killedName == "npc_dota_hero_storm_spirit" then 
      print("naruto killed sasuke")
      EmitSoundOn("naruto_kills_sasuke", killer)
    elseif killedName == "npc_dota_hero_beastmaster" then 
      print("naruto killed kakashi")
    else                 
      print("blah")
    end
  elseif killerName == "npc_dota_hero_storm_spirit" then 
      if killedName == "npc_dota_hero_dragon_knight" then
        EmitSoundOn("sasuke_kills_naruto", killer)
      elseif killedName == "npc_dota_hero_lion" then
       EmitSoundOn("sasuke_kills_gaara", killer)
      elseif killedName == "npc_dota_hero_antimage" then
        EmitSoundOn("sasuke_kills_itachi", killer)
      end
      print("sasuke killed someone")
  else                 
      print("not sasu killed someone")
  end
end

