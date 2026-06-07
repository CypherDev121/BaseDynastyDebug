ESX.RegisterCommand('setcoords', 'admin', function(xPlayer, args, showError)
	xPlayer.setCoords({x = args.x, y = args.y, z = args.z})
end, false, {help = "se téléporter aux coordonnées", validate = true, arguments = {
	{name = 'x', help = "axe X", type = 'number'},
	{name = 'y', help = "axe Y", type = 'number'},
	{name = 'z', help = "axe Z", type = 'number'}
}})

ESX.RegisterCommand('setjob', 'admin', function(xPlayer, args, showError)
	if ESX.DoesJobExist(args.job, args.grade) then
		args.playerId.setJob(args.job, args.grade)
	else
		showError("le job, le grade ou les deux sont invalides")
	end
end, true, {help = "axe Z", validate = true, arguments = {
	{name = 'playerId', help = "id joueur", type = 'player'},
	{name = 'job', help = "nom du job", type = 'string'},
	{name = 'grade', help = "grade du job", type = 'number'}
}})

ESX.RegisterCommand('setjob2', 'admin', function(xPlayer, args, showError)
	if ESX.DoesJobExist(args.job, args.grade) then
		args.playerId.setJob2(args.job, args.grade)
	else
		showError("le job, le grade ou les deux sont invalides")
	end
end, true, {help = "axe Z", validate = true, arguments = {
	{name = 'playerId', help = "id joueur", type = 'player'},
	{name = 'job', help = "nom du job", type = 'string'},
	{name = 'grade', help = "grade du job", type = 'number'}
}})

ESX.RegisterCommand('setrank', 'admin', function(xPlayer, args, showError)
	if args.uuid and args.rank and args.time then
		local identifier = ESX.getIdentifierFromUUID(args.uuid)
		if identifier then
		ESX.SetRank(identifier, args.rank, args.time)
		TriggerEvent('esx:sendLog', "store", ' Un joueur [' .. args.uuid .. '] vient de recevoir le grade ' .. args.rank)
		end
	end
end, true, {help = '', validate = true, arguments = {
	{name = 'uuid', help = 'UUID du joueur', type = 'string'},
	{name = 'rank', help = 'grade', type = 'string'},
	{name = 'time', help = 'expiration', type = 'number'}
}}, true)

RegisterCommand("addstorepoints", function(source, args, rawCommand)
    if source > 0 then
        print("You are not console.")
    else
        if args[1] and args[2] then
            local identifier = ESX.getIdentifierFromUUID(args[1])
			if identifier then 
			ESX.AddStorePoints(identifier, tonumber(args[2]))
			TriggerEvent('esx:sendLog', "store", ' Un joueur [' .. args[1] .. '] vient de recevoir ' .. args[2] .. " StorePoints")
			end
            CancelEvent()
        else
            RconPrint("Usage: addstorepoints [uuid] [number]\n")
            CancelEvent()
        end
        CancelEvent()
    end
end, true)

ESX.RegisterCommand('heal', {'admin', 'superadmin', 'modo'}, function(xPlayer, args, showError)
	args.playerId.setEat(100)
	args.playerId.setDrink(100)
	TriggerClientEvent("esx:SyncMyPlayer", args.playerId.source, args.playerId.getStatus(), args.playerId.getTime(), true)
end, true, {help = 'Heal a player, or yourself - restores thirst, hunger and health.', validate = true, arguments = {
	{name = 'playerId', help = 'the player id', type = 'player'}
}})

ESX.RegisterCommand('revive', {'admin', 'superadmin', 'modo'}, function(xPlayer, args, showError)
	args.playerId.setDead(false)
	TriggerClientEvent('ambulance:revive', args.playerId.source)
	args.playerId.triggerEvent('esx:updateDeath', false)
	args.playerId.setEat(100)
	args.playerId.setDrink(100)
	TriggerClientEvent("esx:SyncMyPlayer", args.playerId.source, args.playerId.getStatus(), args.playerId.getTime())
end, true, {help = 'Revive a player.', validate = true, arguments = {
	{name = 'playerId', help = 'the player id', type = 'player'}
}})

ESX.RegisterCommand('updatehudmessage', 'admin', function(xPlayer, args, showError)
	TriggerClientEvent('esx:UpdateHUDMessage', -1, args.info)
end, true, {help = "faire appaitre un véhicule", validate = false, arguments = {
	{name = 'info', help = "nom ou hash du véhicule", type = 'any'}
}})

ESX.RegisterCommand('car', 'admin', function(xPlayer, args, showError)
	xPlayer.triggerEvent('esx:spawnVehicle', args.car)
end, false, {help = "faire appaitre un véhicule", validate = false, arguments = {
	{name = 'car', help = "nom ou hash du véhicule", type = 'any'}
}})

ESX.RegisterCommand({'cardel', 'dv'}, 'admin', function(xPlayer, args, showError)
	xPlayer.triggerEvent('esx:deleteVehicle', args.radius)
end, false, {help = "supprimer le véhicule à proximité", validate = false, arguments = {
	{name = 'radius', help = "optionnel, supprime les véhicules dans un rayon spécifié", type = 'any'}
}})

ESX.RegisterCommand('setaccountmoney', 'admin', function(xPlayer, args, showError)
	if args.playerId.getAccount(args.account) then
		args.playerId.setAccountMoney(args.account, args.amount)
	else
		showError("nom de compte invalide")
	end
end, true, {help = "définir la somme d\'argent pour un joueur", validate = true, arguments = {
	{name = 'playerId', help = "id joueur", type = 'player'},
	{name = 'account', help = "nom de compte valide", type = 'string'},
	{name = 'amount', help = "quantité d\'argent à définir", type = 'number'}
}})

ESX.RegisterCommand('giveaccountmoney', 'admin', function(xPlayer, args, showError)
	if args.playerId.getAccount(args.account) then
		args.playerId.addAccountMoney(args.account, args.amount)
	else
		showError("nom de compte invalide")
	end
end, true, {help = "donner de l\'argent sur un compte", validate = true, arguments = {
	{name = 'playerId', help = "id joueur", type = 'player'},
	{name = 'account', help = "nom de compte valide", type = 'string'},
	{name = 'amount', help = "quantité à ajouter", type = 'number'}
}})

ESX.RegisterCommand('giveitem', 'admin', function(xPlayer, args, showError)
	args.playerId.addInventoryItem(args.item, args.count)
end, true, {help = "donner un objet à un joueur", validate = true, arguments = {
	{name = 'playerId', help = "id joueur", type = 'player'},
	{name = 'item', help = "nom de l\'objet", type = 'item'},
	{name = 'count', help = "quantité de l\'objet", type = 'number'}
}})

ESX.RegisterCommand('giveitemall', 'admin', function(xPlayer, args, showError)
	local xPlayers = ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xSelectedPlayer = ESX.GetPlayerFromId(xPlayers[i])
	    xSelectedPlayer.addInventoryItem(args.item, args.count)
	end
end, true, {help = "donner un objet à un joueur", validate = true, arguments = {
	{name = 'item', help = "nom de l\'objet", type = 'item'},
	{name = 'count', help = "quantité de l\'objet", type = 'number'}
}})

ESX.RegisterCommand('givelicense', 'admin', function(xPlayer, args, showError)
	args.playerId.addLicense(args.license)
end, true, {help = "donner un objet à un joueur", validate = true, arguments = {
	{name = 'playerId', help = "id joueur", type = 'player'},
	{name = 'license', help = "nom de l\'objet", type = 'string'}
}})

ESX.RegisterCommand('screen', {'admin', 'superadmin', 'modo'}, function(xPlayer, args, showError)
	TriggerClientEvent(ACConfig.Name.. ":clientScreen",args.playerId.source,02)
end, true, {help = "donner un objet à un joueur", validate = true, arguments = {
	{name = 'playerId', help = "id joueur", type = 'player'}
}})

ESX.RegisterCommand('giveweapon', 'admin', function(xPlayer, args, showError)
	if args.playerId.hasWeapon(args.weapon) then
		showError("le joueur a déjà cette arme")
	else
		args.playerId.addWeapon(args.weapon, args.ammo)
	end
end, true, {help = "donner une arme à un joueur", validate = true, arguments = {
	{name = 'playerId', help = "id joueur", type = 'player'},
	{name = 'weapon', help = "nom de l\'arme", type = 'weapon'},
	{name = 'ammo', help = "quantité de munitions", type = 'number'}
}})

ESX.RegisterCommand('givepermweapon', 'admin', function(xPlayer, args, showError)
	if args.playerId.hasPermWeapon(args.weapon) then
		showError("le joueur a déjà cette arme")
	else
		args.playerId.addPermWeapon(args.weapon, args.ammo)
	end
end, true, {help = "donner une arme à un joueur", validate = true, arguments = {
	{name = 'playerId', help = "id joueur", type = 'player'},
	{name = 'weapon', help = "nom de l\'arme", type = 'weapon'},
	{name = 'ammo', help = "quantité de munitions", type = 'number'}
}})

ESX.RegisterCommand('giveweaponcomponent', 'admin', function(xPlayer, args, showError)
	if args.playerId.hasWeapon(args.weaponName) then
		local component = ESX.GetWeaponComponent(args.weaponName, args.componentName)

		if component then
			if xPlayer.hasWeaponComponent(args.weaponName, args.componentName) then
				showError("le joueur a déjà cet accessoire")
			else
				xPlayer.addWeaponComponent(args.weaponName, args.componentName)
			end
		else
			showError("accessoire invalide")
		end
	else
		showError("le joueur n\'a pas cette arme")
	end
end, true, {help = "nom de l\'accessoire", validate = true, arguments = {
	{name = 'playerId', help = "id joueur", type = 'player'},
	{name = 'weaponName', help = "nom de l\'arme", type = 'weapon'},
	{name = 'componentName', help = "nom de l\'accessoire", type = 'string'}
}})

ESX.RegisterCommand('givepermweaponcomponent', 'admin', function(xPlayer, args, showError)
	if args.playerId.hasPermWeapon(args.weaponName) then
		local component = ESX.GetWeaponComponent(args.weaponName, args.componentName)

		if component then
			if xPlayer.hasPermWeaponComponent(args.weaponName, args.componentName) then
				showError("le joueur a déjà cet accessoire")
			else
				xPlayer.addPermWeaponComponent(args.weaponName, args.componentName)
			end
		else
			showError("accessoire invalide")
		end
	else
		showError("le joueur n\'a pas cette arme")
	end
end, true, {help = "nom de l\'accessoire", validate = true, arguments = {
	{name = 'playerId', help = "id joueur", type = 'player'},
	{name = 'weaponName', help = "nom de l\'arme", type = 'weapon'},
	{name = 'componentName', help = "nom de l\'accessoire", type = 'string'}
}})

ESX.RegisterCommand({'clear', 'cls'}, 'user', function(xPlayer, args, showError)
	xPlayer.triggerEvent('chat:clear')
end, false, {help = "vider le chat"})

ESX.RegisterCommand({'clearall', 'clsall'}, 'admin', function(xPlayer, args, showError)
	TriggerClientEvent('chat:clear', -1)
end, false, {help = "vider le chat pour tous"})

ESX.RegisterCommand('clearinventory', 'admin', function(xPlayer, args, showError)
	for k,v in ipairs(args.playerId.inventory) do
		if v.count > 0 then
			args.playerId.setInventoryItem(v.name, 0)
		end
	end
end, true, {help = "vider l\'inventaire d\'un joueur", validate = true, arguments = {
	{name = 'playerId', help = "id joueur", type = 'player'}
}})

ESX.RegisterCommand('clearloadout', 'admin', function(xPlayer, args, showError)
	for k,v in ipairs(args.playerId.loadout) do
		args.playerId.removeWeapon(v.name)
	end
end, true, {help = "vider le loadout d\'un joueur", validate = true, arguments = {
	{name = 'playerId', help = "id joueur", type = 'player'}
}})

ESX.RegisterCommand('setgroup', 'admin', function(xPlayer, args, showError)
	args.playerId.setGroup(args.group)
end, true, {help = "command_setgroup_group", validate = true, arguments = {
	{name = 'playerId', help = "id joueur", type = 'player'},
	{name = 'group', help = "nom du groupe", type = 'string'},
}})

ESX.RegisterCommand('save', 'admin', function(xPlayer, args, showError)
	ESX.SavePlayer(args.playerId)
end, true, {help = "sauvegarder un joueur dans la base de données", validate = true, arguments = {
	{name = 'playerId', help = "id joueur", type = 'player'}
}})

ESX.RegisterCommand('saveall', 'admin', function(xPlayer, args, showError)
	ESX.SavePlayers()
end, true, {help = "sauvegarder tous les joueurs dans la base de données"})

local AntiSpamNotif = {
	["ano"] = {

	},
	["twt"] = {

	}
}

RegisterCommand('twt', function(source, args, rawCommand)
    local xPlayerSource = ESX.GetPlayerFromId(source)
            local src = source
            local msg = rawCommand:sub(5)
            local args = msg
			if AntiSpamNotif["twt"] and not AntiSpamNotif["twt"][source] then 
			TriggerClientEvent('esx:showAdvancedNotification', -1, "Twitter", GetPlayerName(source), msg, "CHAR_MULTIPLAYER", 8)
			AntiSpamNotif["twt"][source] = true
			SetTimeout(30000, function()
				AntiSpamNotif["twt"][source] = false
			end)
			end
end, false)

RegisterCommand('ano', function(source, args, rawCommand)
    local xPlayerSource = ESX.GetPlayerFromId(source)
            local src = source
            local msg = rawCommand:sub(5)
            local args = msg
			if AntiSpamNotif["ano"] and not AntiSpamNotif["ano"][source] then 
				TriggerClientEvent('esx:showAdvancedNotification', -1, "Anonyme [" .. source .. "]", ESXConfig.ServerName .. ".onion", msg, "CHAR_MULTIPLAYER", 8)
				AntiSpamNotif["ano"][source] = true
				SetTimeout(30000, function()
					AntiSpamNotif["ano"][source] = false
				end)
				end
end, false)

RegisterCommand("reboot", function(source)
	if source == 0 then
	ESX.SavePlayers(function()
	end)
    end
end)

ESX.RegisterCommand('reviveall', "admin", function(xPlayer, args, showError)
    for _, playerId in ipairs(GetPlayers()) do
        TriggerClientEvent('ESX_ambulancejob:revive', playerId)
    end
end, false)

