-- This is the entry-point to your game mode and should be used primarily to precache models/particles/sounds/etc

require('internal/util')
require('gamemode')
require('libraries/popups')
require('libraries/utils')
require('libraries/animations')



function Precache( context )
--[[
  This function is used to precache resources/units/items/abilities that will be needed
  for sure in your game and that will not be precached by hero selection.  When a hero
  is selected from the hero selection screen, the game will precache that hero's assets,
  any equipped cosmetics, and perform the data-driven precaching defined in that hero's
  precache{} block, as well as the precache{} block for any equipped abilities.

  See GameMode:PostLoadPrecache() in gamemode.lua for more information
  ]]


  DebugPrint("[BAREBONES] Performing pre-load precache")

  -- Particles can be precached individually or by folder
  -- It it likely that precaching a single particle system will precache all of its children, but this may not be guaranteed
  --PrecacheResource("particle", "particles/econ/generic/generic_aoe_explosion_sphere_1/generic_aoe_explosion_sphere_1.vpcf", context)
  --PrecacheResource("particle_folder", "particles/test_particle", context)

  -- Sounds can precached here like anything else
  PrecacheResource("soundfile", "soundevents/hero_pick.vsndevts", context)
  PrecacheResource("soundfile", "soundevents/loading_screen.vsndevts", context)
  PrecacheResource("soundfile", "soundevents/itachi_crows.vsndevts", context)
  PrecacheResource("soundfile", "soundevents/itachi_amateratsu.vsndevts", context)
  PrecacheResource("soundfile", "soundevents/itachi_amateratsu_burning.vsndevts", context)
  PrecacheResource("soundfile", "soundevents/naruto_rasen_shuriken.vsndevts", context)
  PrecacheResource("soundfile", "soundevents/naruto_kills_sasuke.vsndevts", context)
  PrecacheResource("soundfile", "soundevents/sasuke_kills_naruto.vsndevts", context)
  PrecacheResource("soundfile", "soundevents/sasuke_kills_gaara.vsndevts", context)
  PrecacheResource("soundfile", "soundevents/sasuke_kills_itachi.vsndevts", context)
  PrecacheResource("soundfile", "soundevents/madara_trees.vsndevts", context)
  PrecacheResource("soundfile", "soundevents/bunshin_seal.vsndevts", context)


  -- Entire items can be precached by name
  -- Abilities can also be precached in this way despite the name

  --PrecacheItemByNameSync("item_example_item", context)

  -- Models
  --PrecacheModel("models/asuma/asuma.vmdl", context)
  PrecacheModel("models/gaara/gaara.vmdl", context)
  PrecacheModel("models/guy/gai.vmdl", context)
  PrecacheModel("models/hidan/tesst.vmdl", context)
  PrecacheModel("models/hidan/hidan.vmdl", context)
  PrecacheModel("models/yondaime_new/yondaime_new.vmdl", context)
  PrecacheModel("models/yondaime_new/yondakunai.vmdl", context)
  PrecacheModel("models/itachi_new/itachi.vmdl", context)
  --PrecacheModel("models/jiroubo/jiroubo.vmdl", context)
  PrecacheModel("models/kakashi/kaka.vmdl", context)
  --PrecacheModel("models/kidoumaru/kidoumaru.vmdl", context)
 -- PrecacheModel("models/kimi/kimi.vmdl", context)
  PrecacheModel("models/kisame/kisame.vmdl", context)
  PrecacheModel("models/kisame_new/kisame_samehada.vmdl", context)
  PrecacheModel("models/madara/madara.vmdl", context)
  PrecacheModel("models/naruto_new/naruto.vmdl", context)
  PrecacheModel("models/kankuro/kankuro.vmdl", context)
  PrecacheModel("models/kankuro/karasu.vmdl", context)
  PrecacheModel("models/kankuro/kuroari.vmdl", context)
  PrecacheModel("models/kankuro/puppet2.vmdl", context)
  PrecacheModel("models/heroes/clinkz/clinkz_arrow.vmdl", context)


  PrecacheModel("models/neji/neji.vmdl", context)
  PrecacheModel("models/temari/temari.vmdl", context)
  --PrecacheModel("models/onuki/onuki.vmdl", context)
  PrecacheModel("models/raikage/raikage.vmdl", context)
  PrecacheModel("models/sakura_new/sakura.vmdl", context)
  PrecacheModel("models/sasuke_new/sasuke.vmdl", context)
  PrecacheModel("models/anko/anko.vmdl", context)
  PrecacheModel("models/shikamaru_new/shika.vmdl", context)
  PrecacheModel("models/onuki/onoki_model.vmdl", context)
  PrecacheModel("models/zabuza/zabuza.vmdl", context)
  PrecacheModel("models/props_gameplay/donkey.vmdl", context)
  PrecacheModel("models/items/tiny_01/tiny_haunted_tree.vmdl", context)
  PrecacheModel("models/props_gameplay/frog.vmdl", context)
  

  -- Stuff
  PrecacheResource("particle_folder", "particles/hero", context)
  PrecacheResource("particle_folder", "particles/ambient", context)
  PrecacheResource("particle_folder", "particles/generic_gameplay", context)
  PrecacheResource("particle_folder", "particles/status_fx/", context)
  PrecacheResource("particle_folder", "particles/item", context)
  PrecacheResource("particle_folder", "particles/items_fx", context)
  PrecacheResource("particle_folder", "particles/items2_fx", context)
  PrecacheResource("particle_folder", "particles/items3_fx", context)



  -- Entire heroes (sound effects/voice/models/particles) can be precached with PrecacheUnitByNameSync
  -- Custom units from npc_units_custom.txt can also have all of their abilities and precache{} blocks precached in this way
  PrecacheUnitByNameSync("npc_dota_hero_ancient_apparition", context)
  PrecacheUnitByNameSync("npc_dota_hero_enigma", context)
  PrecacheUnitByNameSync("npc_dota_hero_brewmaster", context)
  PrecacheUnitByNameSync("npc_dota_hero_lich", context)
  PrecacheUnitByNameSync("npc_dota_hero_razor", context)
  PrecacheUnitByNameSync("npc_dota_hero_centaur", context)
  PrecacheUnitByNameSync("npc_dota_hero_invoker", context)


end

-- Create the game mode when we activate
function Activate()
  --loading custom key values
  GameRules.heroKV = LoadKeyValues("scripts/npc/npc_heroes_custom.txt") 
  GameRules.GameMode = GameMode()
  GameRules.GameMode:InitGameMode()

end