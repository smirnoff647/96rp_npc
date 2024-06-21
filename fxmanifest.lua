fx_version 'cerulean'
game 'gta5'

name "96_npc"
description "Simple resource to spawn ped models onto the map"
author "author"
version "1.0.0"
lua54 'yes'

shared_scripts {
	'@ox_lib/init.lua',
	'shared/config.lua'
}

client_scripts {
	'client/*.lua'
}

