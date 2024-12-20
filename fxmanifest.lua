fx_version 'adamant'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

game 'rdr3'
lua54 'yes'

author 'BCC Scripts @Bytesizd'
description 'Holiday events for your server'

shared_scripts {
    'config.lua',
    'locale.lua',
    'languages/*.lua'
}

server_script {
    'server/gifts.lua',
    'server/weather.lua',
    'server/displayitem.lua',
}

client_script {
    'client/gifts.lua',
    'client/displayitem.lua',
    'client/devmode.lua'
}

dependencies {
    'bcc-utils',
    'weathersync'
}

version '1.0.2'