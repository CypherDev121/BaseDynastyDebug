fx_version 'adamant'

game 'gta5'
lua54 'yes'
version '1.0.0'

server_script '@oxmysql/lib/MySQL.lua'



client_scripts {
    'client/*.lua'
}

server_script 'server/*.lua'
shared_script 'shared/config.lua'
shared_script 'shared/gfconfig.lua'

files {
    'ui/**/*'
}

ui_page 'ui/index.html'