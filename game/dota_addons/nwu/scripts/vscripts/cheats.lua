CHEAT_CODES = {
    ["lvlup"] = function(arg) GameMode:LvlUp(arg) end,                -- "Levels up your hero level x times"        
    ["riseandshine"] = function() GameMode:RiseAndShine() end,        -- "Set time of day to dawn" 
    ["lightsout"] = function() GameMode:LightsOut() end,              -- "Set time of day to dusk"          
}
-- A player has typed something into the chat
function GameMode:OnPlayerChat(keys)
	local text = keys.text
	local playerID = keys.userid-1
	local bTeamOnly = keys.teamonly

    -- Handle '-command'
    if StringStartsWith(text, "-") then
        text = string.sub(text, 2, string.len(text))
    end

	local input = split(text)
	local command = input[1]
	if CHEAT_CODES[command] then
		CHEAT_CODES[command](input[2])
	elseif DEBUG_CODES[command] then
        DEBUG_CODES[command]()
    elseif TEST_CODES[command] then
        TEST_CODES[command](input[2], input[3], input[4], playerID)
    end        
end
--[[Author: LearningDave
  Date: october, 30th 2015.
  Gives the Hero of the Player who typed 'lvlup x' x level ups
]]
function GameMode:LvlUp(value)
    local cmdPlayer = Convars:GetCommandClient()
    local pID = cmdPlayer:GetPlayerID()
    if not value then value = 1 end
    
    local hero = PlayerResource:GetPlayer(pID):GetAssignedHero()

    for i=1, value do 
        hero:HeroLevelUp(true)
    end
    GameRules:SendCustomMessage("Cheat enabled!", 0, 0)
end

function GameMode:RiseAndShine()
    GameRules:SetTimeOfDay( 0.3 )
end

function GameMode:LightsOut()
    GameRules:SetTimeOfDay( 0.8 )
end