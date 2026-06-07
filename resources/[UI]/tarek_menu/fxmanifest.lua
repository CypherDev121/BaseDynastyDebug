fx_version 'adamant'

game 'gta5'

version '1.0.0'

server_script '@oxmysql/lib/MySQL.lua'


client_script 'nuimanager/*.lua'

server_script {
    'server.lua'
}

files {
    'ui/**/*'
}

ui_page 'ui/index.html'