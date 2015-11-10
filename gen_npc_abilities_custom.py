from glob import glob

def joinFiles(header, inputDir, outputDir):
	print('Generating %s' % (outputDir))
	output = open(outputDir, 'w')
	output.write(header)
	output.write('{\n')

	files = glob(inputDir)
	for path in files:
		with open(path, 'r') as f:
			for line in f:
				output.write('  '+line)
		output.write('\n')

	output.write('}')
	output.close()	

joinFiles('"DOTAAbilities"\n', 'game/dota_addons/nwu/scripts/npc/abilities/*.txt', 'game/dota_addons/nwu/scripts/npc/npc_abilities_custom.txt')
joinFiles('"DOTAAbilities"\n', 'game/dota_addons/nwu/scripts/npc/items/*.txt', 'game/dota_addons/nwu/scripts/npc/npc_items_custom.txt')
joinFiles('"DOTAHeroes"\n', 'game/dota_addons/nwu/scripts/npc/heroes/*.txt', 'game/dota_addons/nwu/scripts/npc/npc_heroes_custom.txt')
joinFiles('"DOTAUnits"\n', 'game/dota_addons/nwu/scripts/npc/units/*.txt', 'game/dota_addons/nwu/scripts/npc/npc_units_custom.txt')