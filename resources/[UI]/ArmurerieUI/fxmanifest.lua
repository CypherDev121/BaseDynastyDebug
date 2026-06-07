
fx_version 'adamant'

game 'gta5'
author "tr4vis"
description '.gg/bluelite'

lua54 'yes'

client_script 'client/main.lua'
server_script {
    '@oxmysql/lib/MySQL.lua',

    'server/main.lua',
}

files {
    'dist/index.html',
    'dist/tr4vis.css',
    'dist/scripts.js',
    'dist/assets/*.png'
}

ui_page 'dist/index.html'

shared_script 'shared/config.lua'

exports {
    'OpenShop'
}