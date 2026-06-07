fx_version 'cerulean'
lua54 'yes'
game 'gta5'

shared_script 'config.lua'

client_scripts {
    'client/client.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/server.lua'
}

ui_page 'ui/index.html'

files {
    'ui/index.html',
    'ui/style.css',
    'ui/script.js',
    'ui/assets/*.png',
    'ui/assets/*.woff2'
}
