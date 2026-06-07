fx_version 'cerulean'

game 'gta5'

client_scripts {
    'nuimanager.lua'
}

export {
    'setInGunfightZone',
    'showNotification',
    'showLeaderboard',
    'updateLeaderboard',
    'updateRank',
    'addKill'
}

ui_page 'ui/index.html'

files {
    'ui/index.html',
    'ui/assets/css/app.css',
    'ui/assets/js/app.js',
    'ui/assets/img/leaderboard/*.png',
    'ui/assets/img/weapons/*.png'
}