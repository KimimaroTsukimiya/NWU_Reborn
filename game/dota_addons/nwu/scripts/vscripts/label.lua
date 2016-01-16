function GameMode:setPlayerHealthLabel( player )
    if PlayerResource:IsValidPlayerID(player:GetPlayerID()) then
        if not PlayerResource:IsBroadcaster(player:GetPlayerID()) then
          --dave
          if PlayerResource:GetSteamAccountID(player:GetPlayerID()) == 133943769 then
            if PlayerResource:GetPlayer(player:GetPlayerID()):GetAssignedHero() ~= nil then
              PlayerResource:GetPlayer(player:GetPlayerID()):GetAssignedHero():SetCustomHealthLabel("Mod Creator", 30, 144, 255)
            end
          end
          --neil
          if PlayerResource:GetSteamAccountID(player:GetPlayerID()) == 148677144 then
            if PlayerResource:GetPlayer(player:GetPlayerID()):GetAssignedHero() ~= nil then
              PlayerResource:GetPlayer(player:GetPlayerID()):GetAssignedHero():SetCustomHealthLabel("Map Creator", 192, 30, 255)
            end
          end
          --jaze
          if PlayerResource:GetSteamAccountID(player:GetPlayerID()) == 21777321 then
            if PlayerResource:GetPlayer(player:GetPlayerID()):GetAssignedHero() ~= nil then
              PlayerResource:GetPlayer(player:GetPlayerID()):GetAssignedHero():SetCustomHealthLabel("Graphic Designer", 12, 70, 110)
            end
          end
          --digital
          if PlayerResource:GetSteamAccountID(player:GetPlayerID()) == 114682903 then
            if PlayerResource:GetPlayer(player:GetPlayerID()):GetAssignedHero() ~= nil then
              PlayerResource:GetPlayer(player:GetPlayerID()):GetAssignedHero():SetCustomHealthLabel("Map Creator", 0, 255, 255)
            end
          end
          --muzk
          if PlayerResource:GetSteamAccountID(player:GetPlayerID()) == 99391993 then
            if PlayerResource:GetPlayer(player:GetPlayerID()):GetAssignedHero() ~= nil then
              PlayerResource:GetPlayer(player:GetPlayerID()):GetAssignedHero():SetCustomHealthLabel("NWU Creator", 41, 58, 212)
            end
          end
           --spastic
          if PlayerResource:GetSteamAccountID(player:GetPlayerID()) == 35879484 then
            if PlayerResource:GetPlayer(player:GetPlayerID()):GetAssignedHero() ~= nil then
              PlayerResource:GetPlayer(player:GetPlayerID()):GetAssignedHero():SetCustomHealthLabel("The Genin", 255, 140, 0)
            end
          end
           --lucci
          if PlayerResource:GetSteamAccountID(player:GetPlayerID()) == 93546854 then
            if PlayerResource:GetPlayer(player:GetPlayerID()):GetAssignedHero() ~= nil then
              PlayerResource:GetPlayer(player:GetPlayerID()):GetAssignedHero():SetCustomHealthLabel("Best Player", 30, 144, 255)
            end
          end
          --taggin
          if PlayerResource:GetSteamAccountID(player:GetPlayerID()) == 59452361 then
            if PlayerResource:GetPlayer(player:GetPlayerID()):GetAssignedHero() ~= nil then
              PlayerResource:GetPlayer(player:GetPlayerID()):GetAssignedHero():SetCustomHealthLabel("Project Member", 30, 144, 255)
            end
          end
          --damir
           if PlayerResource:GetSteamAccountID(player:GetPlayerID()) == 112105070 then
            if PlayerResource:GetPlayer(player:GetPlayerID()):GetAssignedHero() ~= nil then
              PlayerResource:GetPlayer(player:GetPlayerID()):GetAssignedHero():SetCustomHealthLabel("Project Member", 18, 51, 0)
            end
          end

          --nezz
          if PlayerResource:GetSteamAccountID(player:GetPlayerID()) == 294607899 then
            if PlayerResource:GetPlayer(player:GetPlayerID()):GetAssignedHero() ~= nil then
              PlayerResource:GetPlayer(player:GetPlayerID()):GetAssignedHero():SetCustomHealthLabel("SW Legend", 30, 144, 255)
            end
          end

           --lightforce
          if PlayerResource:GetSteamAccountID(player:GetPlayerID()) == 87707161 then
            if PlayerResource:GetPlayer(player:GetPlayerID()):GetAssignedHero() ~= nil then
              PlayerResource:GetPlayer(player:GetPlayerID()):GetAssignedHero():SetCustomHealthLabel("Map Creator", 255, 255, 255)
            end
          end

          --bonusses
          if PlayerResource:GetSteamAccountID(player:GetPlayerID()) == 240969051 then
            if PlayerResource:GetPlayer(player:GetPlayerID()):GetAssignedHero() ~= nil then
              PlayerResource:GetPlayer(player:GetPlayerID()):GetAssignedHero():SetCustomHealthLabel("Project Member",  30, 144, 255)
            end
          end
        
        --kuru
          if PlayerResource:GetSteamAccountID(player:GetPlayerID()) == 253439703 then
            if PlayerResource:GetPlayer(player:GetPlayerID()):GetAssignedHero() ~= nil then
              PlayerResource:GetPlayer(player:GetPlayerID()):GetAssignedHero():SetCustomHealthLabel("Mother of NWR",  250, 0, 142)
            end
          end
          

        end
    end
end
