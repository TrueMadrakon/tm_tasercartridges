fx_version 'cerulean'

game 'gta5'
lua54 "yes"

author 'Madrakon'
description 'Taser Cartridges'
version '0.1.0'

shared_scripts {
    '@ox_lib/init.lua',
    '@es_extended/imports.lua',
    "config.lua"
}

server_script 'server/*.lua'
client_script 'client/*.lua'
