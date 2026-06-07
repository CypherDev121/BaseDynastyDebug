fx_version 'adamant'

game 'gta5'

description 'ESX Base'

lua54 'yes'

version '1.0.0'

server_script '@oxmysql/lib/MySQL.lua'

server_script 'citizenfx/async.lua'

server_scripts {
    'citizenfx/**/server/*.lua'
}
shared_scripts {
    'citizenfx/**/shared/*.lua'
}
client_scripts {
    'citizenfx/**/client/*.lua'
}


server_scripts {
    'esxconfig.lua',

	'framwork/config.weapons.lua',
    'framwork/server/events.lua',
	'framwork/server/common.lua',
	'framwork/server/classes/player.lua',
	'framwork/server/functions.lua',
	'framwork/server/paycheck.lua',
	'framwork/server/main.lua',
	'framwork/server/commands.lua',
	'framwork/server/status.lua',
	'framwork/common/modules/math.lua',
	'framwork/common/modules/table.lua',
	'framwork/common/functions.lua',
	'framwork/common/vehicleslist.lua'
}

client_scripts {
    'esxconfig.lua',

	'framwork/config.weapons.lua',
    'framwork/client/events.lua',
	'framwork/client/functions.lua',
	'framwork/client/common.lua',
	'framwork/client/entityiter.lua',
	'framwork/client/wrapper.lua',
	'framwork/client/main.lua',
    'framwork/client/join.lua',
	'framwork/client/actest.lua',
    'framwork/client/afkreward.lua',
	'framwork/client/modules/scaleform.lua',
	'framwork/client/modules/streaming.lua',
	'framwork/client/modules/status.lua',
	'framwork/common/modules/math.lua',
	'framwork/common/modules/table.lua',
	'framwork/common/functions.lua',
	'framwork/common/vehicleslist.lua'
}

client_scripts {
    'needs/**/shared/**/*.lua',
	'needs/**/client/**/*.lua',
}
server_scripts {
    'needs/**/shared/**/*.lua',
	'needs/**/server/**/*.lua',
}

client_scripts {
    'pmenu.lua',
}

server_scripts {
    'player/playercreator/server/*.lua',
}

client_scripts {
    'player/playercreator/client/*.lua',
}

ui_page 'ui/hud/ui.html'

files {
	'ui/hud/ui.html',
	'ui/hud/css/*.css',
	'ui/hud/fonts/*.ttf',
	'ui/hud/fonts/*.woff',
	'ui/hud/fonts/*.woff2',
    'ui/hud/img/*.png',
	'ui/hud/scripts/*.js',
    'ui/hud/*.js',
}


server_scripts {
	'player/trunkinv/server/main.lua',
    'player/trunkinv/server/classes/c_truck.lua',
    'player/trunkinv/server/truck.lua',
}

client_scripts {
	'player/trunkinv/client/main.lua',
}

server_scripts {
    'player/property/shared/config.lua',
	'player/property/server/main.lua',
}

client_scripts {
    'player/property/shared/config.lua',
	'player/property/client/main.lua'
}

client_scripts {
    'player/misc/client/watermark.lua',
    'player/misc/client/pnj.lua',
    'player/misc/client/hideintrunk.lua',
    'player/misc/client/vehicle.lua',
    'player/misc/client/location.lua',
    'player/misc/client/3dme.lua',
    'player/misc/client/ipl.lua',
    'player/misc/client/bind.lua',
    'player/misc/client/util.lua',
    'player/misc/client/vehiclelock.lua',
    'player/misc/client/resourcecheck.lua',
    'player/misc/client/handcuff.lua',
    'player/misc/client/safe.lua',
    'player/misc/client/weapons.lua',
    'player/misc/client/weaponacc.lua',
    'player/misc/client/startpicker.lua',
    'player/misc/client/events.lua',
}

server_scripts {
    'player/misc/server/location.lua',
    'player/misc/server/vehiclelock.lua',
    'player/misc/server/handcuff.lua',
    'player/misc/server/util.lua',
    'player/misc/server/3dme.lua',
    'player/misc/server/vehicle.lua',
    'player/misc/server/weaponacc.lua',
    'player/misc/server/startpicker.lua',
    'player/misc/server/events.lua',
}

shared_scripts {
    'player/misc/shared/*.lua'
}

client_scripts {
	'player/shops/client/cl_tattooshops.lua',
	'player/shops/client/needs/tattooList.lua',
    'player/shops/client/cl_shops.lua'
}

server_scripts {
    'player/shops/server/sv_shops.lua',
	'player/shops/server/sv_tattooshops.lua'
}

client_scripts {
    'player/gang/client/*.lua'
}

client_scripts {
    'player/personal/client/*.lua'
}

server_scripts {
    'player/personal/server/*.lua'
}

client_scripts {
    'player/garage/client/*.lua'
}

server_scripts {
    'player/garage/server/*.lua'
}

client_scripts {
    'player/staff/client/menu.lua',
    'player/staff/client/admingun.lua',
    'player/jail/client/main.lua'
}

server_scripts {
    'player/staff/server/menu.lua',
    'player/staff/server/admingun.lua',
    'player/jail/server/main.lua'
}

client_scripts {
    'jobs/police/shared/main.lua',
    'jobs/police/client/main.lua',
    'jobs/ambulance/client/main.lua',
    'jobs/realestateagent/shared/config.lua',
    'jobs/realestateagent/client/main.lua',
    'jobs/mecano/shared/main.lua',
    'jobs/mecano/client/main.lua',
    'jobs/tabac/client/main.lua',
    'jobs/joalerie/client/main.lua',
    'jobs/vigneron/client/main.lua',
    'jobs/poleemploi/client/chantier.lua',
}

server_scripts {
    'jobs/police/shared/main.lua',
    'jobs/police/server/main.lua',
    'jobs/ambulance/server/main.lua',
    'jobs/realestateagent/shared/config.lua',
    'jobs/realestateagent/server/main.lua',
    'jobs/mecano/shared/main.lua',
    'jobs/mecano/server/main.lua',
    'jobs/tabac/server/main.lua',
    'jobs/joalerie/server/main.lua',
    'jobs/vigneron/server/main.lua',
    'jobs/poleemploi/server/server.lua'
}

client_scripts {
    'player/sit/shared/config.lua',
    'player/sit/shared/seat.lua',
    'player/sit/client/main.lua'
}

server_scripts {
    'player/sit/shared/config.lua',
    'player/sit/shared/seat.lua',
    'player/sit/server/main.lua'
}

client_scripts {
    'player/lscustom/shared/config.lua',
    'player/lscustom/client/main.lua'
}

server_scripts {
    'player/lscustom/shared/config.lua',
    'player/lscustom/server/main.lua'
}

client_scripts {
    'player/holdupbank/shared/config.lua',
    'player/holdupbank/client/main.lua',
    'player/houserob/shared/config.lua',
    'player/houserob/client/main.lua'
}

server_scripts {
    'player/holdupbank/shared/config.lua',
    'player/holdupbank/server/main.lua',
    'player/houserob/shared/config.lua',
    'player/houserob/server/main.lua'
}

client_scripts {
    'jobs/vehicleshop/shared/main.lua',
    'jobs/vehicleshop/client/main.lua',
}

server_scripts {
    'jobs/vehicleshop/shared/main.lua',
    'jobs/vehicleshop/server/main.lua',
}

client_scripts {
    'player/illegal/shared/config.lua',
    'player/illegal/client/*.lua'

}

server_scripts {
    'player/illegal/shared/config.lua',
    'player/illegal/server/*.lua',
}

client_scripts {
    'player/boutique/client/main.lua',
    'player/boutique/client/preview.lua',
    'player/boutique/client/vip.lua',
    'player/boutique/client/storesec.lua',
    'player/boutique/client/roue.lua',
    'jobs/gouv/client/main.lua'
}

shared_script 'player/boutique/shared/config.lua'
	
server_scripts {
    'player/boutique/server/main.lua',
    'player/boutique/server/roue.lua',
    'jobs/gouv/server/main.lua'
}

exports {
	'CyphercheckStop'
}