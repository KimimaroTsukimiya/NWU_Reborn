WTF_MODE = false

CHEAT_CODES = {
    ["wtfmode"] = function() GameMode:Wtf() end,              -- "Toggles Wtf-mode: Gives all playes no cd on their abilities and 1k manareg"    
    ["gold"] = function(arg) GameMode:Gold(arg) end,              -- "Gives the player x gold"    
    ["repick"] = function(arg) GameMode:Repick(arg) end,              -- "Changes the Hero of the player"    
    ["lvlup"] = function(arg) GameMode:LvlUp(arg) end,                -- "The player lvlups x levels"        
    ["riseandshine"] = function() GameMode:RiseAndShine() end,        -- "Set time of day to dawn" 
    ["lightsout"] = function() GameMode:LightsOut() end,              -- "Set time of day to dusk"          
}
-- A player has typed something into the chat
function GameMode:OnPlayerChat(keys)
	local text = keys.text
	local playerID = keys.userid-1
	local bTeamOnly = keys.teamonly
    GameMode:Setup_Hero_Tables()
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
--[[Author: LearningDave
    All players get 1000 manareg and have no cds
]]
function GameMode:Wtf()
    if WTF_MODE then
        WTF_MODE = false
    else
        WTF_MODE = true
    end
    local cmdPlayer = Convars:GetCommandClient()
    local PlayerCount = PlayerResource:GetPlayerCount() - 1
    if  WTF_MODE then
        Timers:CreateTimer( function()
            for i=0, PlayerCount do
                if PlayerResource:IsValidPlayer(i) then
                    local player = PlayerResource:GetPlayer(i)
                    
                    local hero = player:GetAssignedHero()
                    hero:SetBaseManaRegen(1000)
                    for i=0, hero:GetAbilityCount()-1 do 
                        if  hero:GetAbilityByIndex(i) ~= nil then
                            hero:GetAbilityByIndex(i):EndCooldown()
                        end
                    end
                    for i=0, 6 do 
                        if  hero:GetItemInSlot(i) ~= nil then
                            hero:GetItemInSlot(i):EndCooldown()
                        end
                    end
                end
            end
            if WTF_MODE then
                return 0.003
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
--[[Author: LearningDave
  Date: november, 9th 2015.
  Gives the player a new hero
]]
function GameMode:Repick(value)
    local cmdPlayer = Convars:GetCommandClient()
    local pID = cmdPlayer:GetPlayerID()
    if  value then   
        if tableContains(GameRules.nwrHeroTable, value) then
            local hero_index = getIndex(GameRules.nwrHeroTable, value)
            newHeroName = GameRules.heroTable[hero_index]
            PlayerResource:ReplaceHeroWith(pID, newHeroName, 0, 0)
        end
    end
   
end
--[[Author: LearningDave
  Date: november, 9th 2015.
  If not done yet, sets up hero tables to match naruto name to dota hero name
]]
function GameMode:Setup_Hero_Tables()
    -- setup race reference table
    if GameRules.heroTable == nil then
        GameRules.heroTable = {}
        GameRules.heroTable[1] = "npc_dota_hero_lion"
        GameRules.heroTable[2] = "npc_dota_hero_centaur"
        GameRules.heroTable[3] = "npc_dota_hero_doom_bringer"
        GameRules.heroTable[4] = "npc_dota_hero_antimage"
        GameRules.heroTable[5] = "npc_dota_hero_beastmaster"
        GameRules.heroTable[6] = "npc_dota_hero_windrunner"
        GameRules.heroTable[7] = "npc_dota_hero_kunkka"
        GameRules.heroTable[8] = "npc_dota_hero_ogre_magi"
        GameRules.heroTable[9] = "npc_dota_hero_dragon_knight"
        GameRules.heroTable[10] = "npc_dota_hero_sven"
        GameRules.heroTable[11] = "npc_dota_hero_sand_king"
        GameRules.heroTable[12] = "npc_dota_hero_phantom_assassin"
        GameRules.heroTable[13] = "npc_dota_hero_storm_spirit"
        GameRules.heroTable[14] = "npc_dota_hero_juggernaut"
        GameRules.heroTable[15] = "npc_dota_hero_bloodseeker"
        GameRules.heroTable[16] = "npc_dota_hero_axe"
		GameRules.heroTable[17] = "npc_dota_hero_shadow_shaman"
    end
    if GameRules.nwrHeroTable == nil then
        GameRules.nwrHeroTable = {}
        GameRules.nwrHeroTable[1] = "gaara"
        GameRules.nwrHeroTable[2] = "guy"
        GameRules.nwrHeroTable[3] = "hidan"
        GameRules.nwrHeroTable[4] = "itachi"
        GameRules.nwrHeroTable[5] = "kakashi"
        GameRules.nwrHeroTable[6] = "kidoumaru"
        GameRules.nwrHeroTable[7] = "kisame"
        GameRules.nwrHeroTable[8] = "madara"
        GameRules.nwrHeroTable[9] = "naruto"
        GameRules.nwrHeroTable[10] = "onoki"
        GameRules.nwrHeroTable[11] = "raikage"
        GameRules.nwrHeroTable[12] = "sakura"
        GameRules.nwrHeroTable[13] = "sasuke"
        GameRules.nwrHeroTable[14] = "yondaime"
        GameRules.nwrHeroTable[15] = "zabuza"
        GameRules.nwrHeroTable[16] = "neji"
		GameRules.nwrHeroTable[17] = "shikamaru"
    end
end

