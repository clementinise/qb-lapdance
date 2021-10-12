fx_version 'cerulean'
game 'gta5'

author 'Clementinise'
description 'Lapdance resource for the Unicorn strip club'
version '1.0'

shared_scripts {
	'config.lua',
	'@qb-core/import.lua',
	'locales/*.lua',
}

client_script 'client/main.lua'

server_script 'server/main.lua'