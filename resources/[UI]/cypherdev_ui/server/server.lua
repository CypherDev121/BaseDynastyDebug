---
---
---

while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
end

--[[ REGISTER ]]--

ESX.RegisterServerCallback('isPlayerRegistered', function(source, cb)
    local this = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
        ['@identifier'] = this.identifier
    }, function(result)
        if result[1] then
            if (result[1].firstname == nil or result[1].lastname == nil or result[1].dateofbirth == nil) then
                cb(false)
            else
                cb(true)
            end
        end
    end)
end)

RegisterServerEvent('cypherdev_ui:shopPay')
AddEventHandler('cypherdev_ui:shopPay', function(itemName, price, type)
    local xPlayer = ESX.GetPlayerFromId(source)
    for k,v in pairs(ConF.LTD.Items) do
        if v.name == itemName then
            if v.price == price then
                if xPlayer.getAccount(type).money >= price then
                    xPlayer.removeAccountMoney(type, price)
                    xPlayer.addInventoryItem(itemName, 1)
                    TriggerClientEvent('esx:showNotification', source, "Vous avez acheté un ~b~" .. v.label)
                else
                    TriggerClientEvent('esx:showNotification', source, "Vous n'avez pas assez d'argent")
                end
            else
                DropPlayer(xPlayer.source, "Nous avons détecté une modification de votre client, veuillez vous reconnecter !")
            end
        end
    end
end)

--[[ GARAGES ]]--

RegisterServerEvent('cypherdev_ui:fetchVehicles')
AddEventHandler('cypherdev_ui:fetchVehicles', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local vehicles = {}
    MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner', {
        ['@owner'] = xPlayer.identifier
    }, function(result)
        for i=1, #result, 1 do
            local vehicle = json.decode(result[i].vehicle)
            table.insert(vehicles, {
                vehicle = vehicle,
                plate = vehicle.plate,
                model = vehicle.model,
                label = result[i].label,
                state = result[i].state,
                type = result[i].type
            })
        end
        TriggerClientEvent('cypherdev_ui:loadVehicles', xPlayer.source, vehicles)
    end)
end)

RegisterServerEvent('cypherdev_ui:createGarage')
AddEventHandler('cypherdev_ui:createGarage', function(data)
    local xPlayer = ESX.GetPlayerFromId(source)
    -- id, name, menu, spawn, delete
    MySQL.Async.execute('INSERT INTO garages (name, menu, spawn, delete) VALUES (@name, @menu, @spawn, @delete)', {
        ['@name'] = data.name,
        ['@menu'] = json.encode(data.menu),
        ['@spawn'] = json.encode(data.spawn),
        ['@delete'] = json.encode(data.delete)
    }, function(rowsChanged)
        if rowsChanged > 0 then
            TriggerClientEvent('esx:showNotification', xPlayer.source, "Garage créé avec succès")
        else
            TriggerClientEvent('esx:showNotification', xPlayer.source, "Erreur lors de la création du garage")
        end
    end)
end)