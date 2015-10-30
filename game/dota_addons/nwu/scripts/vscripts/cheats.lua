WTF_MODE = false

CHEAT_CODES = {
    ["wtf"] = function() GameMode:Wtf() end,              -- "Set time of day to dusk"    
    ["gold"] = function(arg) GameMode:Gold(arg) end,              -- "Set time of day to dusk"    
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
--[[Author: LearningDave
  Date: october, 30th 2015.
  Gives the Hero of the Player who typed 'lvlup x' x level ups
]]
function GameMode:RiseAndShine()
    GameRules:SetTimeOfDay( 0.3 )
end
--[[Author: https://github.com/MNoya/DotaCraft/blob/01a29892b124f695cadd0a134afb8d056c83015a/game/dota_addons/dotacraft/scripts/vscripts/developer.lua
    Brings the light out!->Daytime
]]
function GameMode:LightsOut()
    GameRules:SetTimeOfDay( 0.8 )
end
--[[Author: https://github.com/MNoya/DotaCraft/blob/01a29892b124f695cadd0a134afb8d056c83015a/game/dota_addons/dotacraft/scripts/vscripts/developer.lua
    Night is arriving!->Nighttime
]]
function GameMode:Wtf()
    if WTF_MODE then
        WTF_MODE = false
    else
        WTF_MODE = true
    end
    local cmdPlayer = Convars:GetCommandClient()
    local pID = cmdPlayer:GetPlayerID()
    local hero = PlayerResource:GetPlayer(pID):GetAssignedHero()
    if  WTF_MODE then
        Timers:CreateTimer( function()
            for i=0, hero:GetAbilityCount()-1 do 
                if  hero:GetAbilityByIndex(i) ~= nil then
                    hero:GetAbilityByIndex(i):EndCooldown()
                end
            end
            if WTF_MODE then
                return 0.3
            else
                return nil
            end        
        end
        )   
    end
    if WTF_MODE then
        GameRules:SendCustomMessage("Cheat enabled!", 0, 0)
    else
        GameRules:SendCustomMessage("Cheat disabled!", 0, 0)
    end
end
--[[Author: LearningDave
  Date: october, 30th 2015.
  Gives the Player x Gold (500 if no value given)
]]
function GameMode:Gold(value)
    local cmdPlayer = Convars:GetCommandClient()
    local pID = cmdPlayer:GetPlayerID()
    if not value then value = 500 end
    PlayerResource:ModifyGold(pID, tonumber(value), true, 0)

    GameRules:SendCustomMessage("Cheat enabled!", 0, 0)
end