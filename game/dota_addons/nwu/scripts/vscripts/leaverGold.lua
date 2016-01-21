LEAVER_COUNT_TEAM_1 = 0
LEAVER_COUNT_TEAM_2 = 0
leaver_team_1 = {}
leaver_team_2 = {}
gold_inc = 1.67
leavergold_inc_1 = 2.08
leavergold_inc_2 = 2.78
leavergold_inc_3 = 4.17
leavergold_inc_4 = 8.33

function GameMode:ModifyGoldGainDC( hero )

	hero.isDC = true
	Timers:CreateTimer( 5, function()
    	if hero.isDC then
    		GameRules:SendCustomMessage(" didnt reconnect in time, his gold will be split upon his team.", 0, 0)
    		local leaverGold = hero:GetGold()
    		local teammebers = 0

    		for playerID=0,10 do
				if PlayerResource:IsValidPlayerID(playerID) then
					local player = PlayerResource:GetPlayer(playerID)
					if  hero:GetName() ~= player:GetAssignedHero():GetName() and hero:GetTeamNumber() == player:GetAssignedHero():GetTeamNumber() then
						teammebers = teammebers + 1
						local hero = PlayerResource:GetPlayer(playerID):GetAssignedHero()
					end	
				end
			end
			local shareGold = leaverGold / teammebers
			print(teammebers)
			print(shareGold)

			local addGoldGain = 1.67 / teammebers

			for playerID=0,10 do
				if PlayerResource:IsValidPlayerID(playerID) then
					local player = PlayerResource:GetPlayer(playerID)
					if  hero:GetName() ~= player:GetAssignedHero():GetName() and hero:GetTeamNumber() == player:GetAssignedHero():GetTeamNumber() then
						local hero = PlayerResource:GetPlayer(playerID):GetAssignedHero()
						hero:ModifyGold(shareGold,true,0)
					end	
				end
			end

			  -- A timer running every second that starts immediately on the next frame, respects pauses
			  Timers:CreateTimer(function()
			     keys:GetAssignedHero():SetGold(0,false)
			     for playerID=0,10 do
					if PlayerResource:IsValidPlayerID(playerID) then
						local player = PlayerResource:GetPlayer(playerID)
						if  hero:GetName() ~= player:GetAssignedHero():GetName() and hero:GetTeamNumber() == player:GetAssignedHero():GetTeamNumber() then
							local hero = PlayerResource:GetPlayer(playerID):GetAssignedHero()
							hero:ModifyGold(addGoldGain,true,0)
						end	
					end
				end
			     if hero.isDC then
			     	return 1.0
			     else
			     	return nil
			     end
			      
			    end
			  )


    	end
		return nil
	end
	)
end
  