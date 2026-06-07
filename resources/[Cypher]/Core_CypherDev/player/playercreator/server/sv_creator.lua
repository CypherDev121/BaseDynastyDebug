PlayersRegistredThisSession = {}

--[[ RegisterServerEvent('creator:setIdentity')
AddEventHandler('creator:setIdentity', function(data)
	local xPlayer = ESX.GetPlayerFromId(source)

	print(json.encode(data))
	xPlayer.setFirstName(data.firstname)
	xPlayer.setLastName(data.lastname)
	xPlayer.setDOB(data.birthdate)
	xPlayer.setSex(data.gender)
	xPlayer.setHeight(data.height)
	PlayersRegistredThisSession[xPlayer.identifier] = true

	TriggerClientEvent('Cypher-skincreator:createCharacter', xPlayer.source)
end)
 ]]
print('creator:updateId')

--[[  RegisterServerEvent('creator:updateId')
 AddEventHandler('creator:updateId', function(data)
	 local xPlayer = ESX.GetPlayerFromId(source)
 
	 print(json.encode(data))
	 xPlayer.setFirstName(data.firstname)
	 xPlayer.setLastName(data.lastname)
	 xPlayer.setDOB(data.birthdate)
	 xPlayer.setSex(data.gender)
	 xPlayer.setHeight(data.height)
	 PlayersRegistredThisSession[xPlayer.identifier] = true
end) ]]

ESX.RegisterServerCallback('creator:updateIdentity', function(source, callback, data)
	local xPlayer = ESX.GetPlayerFromId(source)
 
	xPlayer.setFirstName(data.firstname)
	xPlayer.setLastName(data.lastname)
	xPlayer.setDOB(data.birthdate)
	xPlayer.setSex(data.gender)
	xPlayer.setHeight(data.height)
	
	PlayersRegistredThisSession[xPlayer.identifier] = true
	callback(true)

	print('Saved:')
	print(xPlayer.getFirstName())
	print(xPlayer.getLastName())
end)


RegisterServerEvent('creator:putMeInBukket')
AddEventHandler('creator:putMeInBukket', function(enable)
	if enable then
		SetPlayerRoutingBucket(source, source)
	else 
		SetPlayerRoutingBucket(source, 0)
	end
end)