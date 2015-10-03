from glob import glob

output = open('game/dota_addons/nwu/scripts/npc/npc_abilities_custom.txt', 'w')
output.write('"DOTAAbilities"\n')
output.write('{\n')

files = glob('game/dota_addons/nwu/scripts/npc/abilities/*.txt')
for path in files:
	with open(path, 'r') as f:
		for line in f:
			output.write('  '+line)
	output.write('\n')

output.write('}')
output.close()