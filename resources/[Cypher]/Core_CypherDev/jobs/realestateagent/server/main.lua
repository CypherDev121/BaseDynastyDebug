
TriggerEvent('society:registerSociety', 'realestateagent', "Agent Immobilier", 'society_realestateagent', 'society_realestateagent', 'society_realestateagent', {type = 'private'})

RegisterServerEvent('realestateagentjob:revoke')
AddEventHandler('realestateagentjob:revoke', function(property, owner)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'realestateagent' then
		TriggerEvent('property:removeOwnedPropertyIdentifier', property, owner)
	else
		print(('realestateagentjob: %s attempted to revoke a property!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('realestateagentjob:sell')
AddEventHandler('realestateagentjob:sell', function(target, property, price)
	local xPlayer, xTarget = ESX.GetPlayerFromId(source), ESX.GetPlayerFromId(target)

	if xPlayer.job.name ~= 'realestateagent' then
		print(('realestateagentjob: %s attempted to sell a property!'):format(xPlayer.identifier))
		return
	end

	if xTarget.getMoney() >= price then
		xTarget.removeMoney(price)

		TriggerEvent('addonaccount:getSharedAccount', 'society_realestateagent', function(account)
			account.addMoney(price)
		end)
	
		TriggerEvent('property:setPropertyOwned', property, price, false, xTarget.identifier)
	else
		TriggerClientEvent('esx:showNotification', xPlayer.source, "your client cannot afford that")
	end
end)

RegisterServerEvent('realestateagentjob:rent')
AddEventHandler('realestateagentjob:rent', function(target, property, price)
	local xPlayer = ESX.GetPlayerFromId(target)

	TriggerEvent('property:setPropertyOwned', property, price, true, xPlayer.identifier)
end)

ESX.RegisterServerCallback('realestateagentjob:getCustomers', function(source, cb)
	TriggerEvent('ownedproperty:getOwnedProperties', function(properties)
		local xPlayers  = ESX.GetPlayers()
		local customers = {}

		for i=1, #properties, 1 do
			for j=1, #xPlayers, 1 do
				local xPlayer = ESX.GetPlayerFromId(xPlayers[j])

				if xPlayer.identifier == properties[i].owner then
					table.insert(customers, {
						name           = xPlayer.name,
						propertyOwner  = properties[i].owner,
						propertyRented = properties[i].rented,
						propertyId     = properties[i].id,
						propertyPrice  = properties[i].price,
						propertyName   = properties[i].name,
						propertyLabel  = properties[i].label
					})
				end
			end
		end

		cb(customers)
	end)
end)
