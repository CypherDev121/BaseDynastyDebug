RegisterServerEvent('store:buyItem')
AddEventHandler('store:buyItem', function(Type, Item, weapontype)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local item = Item
    local type = Type
    local uuid = xPlayer.getUUID()

    if type == 'weapon' then
        for k, v in pairs(StoreConfig.Weapons) do
            if item == v.NameWeapon then
                if tonumber(xPlayer.getStorePoints()) >= tonumber(v.Point) then
                    if weapontype == 'normal' then
                        if not xPlayer.hasWeapon(v.NameWeapon) then
                            xPlayer.removeStorePoints(tonumber(v.Point))
                    xPlayer.addWeapon(v.NameWeapon, 250)
                    TriggerClientEvent('esx:showNotification', _source,  'Merci pour votre Achat !')
                        else
                            TriggerClientEvent('esx:showNotification', _source,  'Vous avez déjà cette arme !')
                        end
                    elseif weapontype == 'perm' then
                      if not xPlayer.hasPermWeapon(v.NameWeapon) then
                        xPlayer.removeStorePoints(tonumber(v.Point))
                       xPlayer.addPermWeapon(v.NameWeapon, 250)
                       TriggerClientEvent('esx:showNotification', _source,  'Merci pour votre Achat !')
                      else
                        TriggerClientEvent('esx:showNotification', _source,  'Vous avez déjà cette arme !')

                      end
                    end
                    TriggerEvent('esx:sendLog', "store", GetPlayerName(_source) .. " ( "  .. _source .. ' - ' .. xPlayer.getUUID() .. " )".. ' a acheté l\'arme [' .. weapontype .. '] ' .. v.NameWeapon)
                else
                    TriggerClientEvent('esx:showNotification', _source, 'Vous n\'avez pas assez de fonds pour acheter ceci !')
                end
                break
            end
        end

    elseif type == 'vehicle' then
        for k, v in pairs(StoreConfig.Vehicles) do
            if item == v.data.NameVehicle then
                if tonumber(xPlayer.getStorePoints()) >= tonumber(v.data.Point) then
                    xPlayer.removeStorePoints(tonumber(v.data.Point))
                    TriggerEvent('esx:sendLog', "store", GetPlayerName(_source) .. " ( "  .. _source .. ' - ' .. xPlayer.getUUID() .. " )".. ' a acheté le véhicule ' .. item)
                    AssignVehicle(_source, uuid, v.data.NameVehicle, GeneratePlate())
                    TriggerClientEvent('esx:showNotification', _source,  'Merci pour votre Achat !')
                else
                    TriggerClientEvent('esx:showNotification', _source, 'Vous n\'avez pas assez de fonds pour acheter ceci !')
                end
            end
        end
    elseif type == 'pack' then
        if tonumber(xPlayer.getStorePoints()) >= tonumber(StoreConfig.Packs[Item].price) then
        xPlayer.removeStorePoints(tonumber(StoreConfig.Packs[Item].price))
        TriggerEvent('esx:sendLog', "store", GetPlayerName(_source) .. " ( "  .. _source .. ' - ' .. xPlayer.getUUID() .. " )".. ' a acheté le pack ' .. item)
        for k, v in pairs(StoreConfig.Packs[Item].loots) do
            if v.type == 'weapon' then
                xPlayer.addWeapon(v.item, v.amount)
            elseif v.type == 'vehicle' then
                AssignVehicle(uuid, v.item, GeneratePlate())
            elseif v.type == 'money' then
                if v.item == 'black_money' then
                    xPlayer.addAccountMoney(v.item, v.amount)
                elseif v.item == 'money' then
                    xPlayer.addMoney(v.amount)
                end
            end
        end    
        end 
    elseif type == "rank" then
        local RanksPrices = {["vip"] = 2000, ["diamond"] = 3000}
        local rankPrice = RanksPrices[item]
        if tonumber(xPlayer.getStorePoints()) >= tonumber(rankPrice) then
            xPlayer.removeStorePoints(tonumber(rankPrice))
            ESX.SetRank(xPlayer.identifier, item, 2)
            TriggerClientEvent('esx:showNotification', _source,  'Merci pour votre Achat !')
            TriggerEvent('esx:sendLog', "store", GetPlayerName(_source) .. " ( "  .. _source .. ' - ' .. xPlayer.getUUID() .. " )".. ' a acheté le grade ' .. item)
        else
            TriggerClientEvent('esx:showNotification', _source, 'Vous n\'avez pas assez de fonds pour acheter ceci !')
        end
    end
end)

function AssignVehicle(source, uuid, model, plate, native)
    local vehiclehash = GetHashKey(model)
    if vehiclehash and uuid then
    local vehicleprops = {model = vehiclehash, plate = plate}
    MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (@owner, @plate, @vehicle)',
	{
		['@owner']   = uuid,
		['@plate']   = plate,
		['@vehicle'] = json.encode(vehicleprops)
	}, function (rowsChanged)
        if not GetGarageVehicle(plate) then
            InsertGarageVehicle({ owner = uuid, plate = plate, vehicle = vehicleprops, type = "car", state = true})
        end
        if source and source ~= 0 and ESX.GetPlayerFromId(source) then
		TriggerClientEvent('esx:announce', source, '~y~Boutique', 'Véhicule acheté : ~b~' .. string.upper(model) .. '~w~ de plaque ~b~' .. plate .. '~s~ !', 2)
        end
    end)
    end
end

-- Configuration des caisses
CaisseConfig = {
    ["caisse_standard"] = {
        price = 1000,
        rewards = {
            {type = "weapon", item = "WEAPON_PISTOL", chance = 15, amount = 100},
            {type = "weapon", item = "WEAPON_SMG", chance = 10, amount = 100},
            {type = "money", item = "money", chance = 30, amount = 50000},
            {type = "money", item = "black_money", chance = 20, amount = 25000},
            {type = "vehicle", item = "t20", chance = 5},
            {type = "storepoints", amount = 500, chance = 20}
        }
    },
    ["caisse_premium"] = {
        price = 2000,
        rewards = {
            {type = "weapon", item = "WEAPON_CARBINERIFLE", chance = 15, amount = 200},
            {type = "weapon", item = "WEAPON_APPISTOL", chance = 20, amount = 200},
            {type = "money", item = "money", chance = 25, amount = 100000},
            {type = "money", item = "black_money", chance = 20, amount = 50000},
            {type = "vehicle", item = "zentorno", chance = 10},
            {type = "storepoints", amount = 1000, chance = 10}
        }
    }
}

-- Fonction pour obtenir une récompense aléatoire basée sur les chances
local function GetRandomReward(caisseType)
    local caisse = CaisseConfig[caisseType]
    if not caisse then return nil end

    local totalChance = 0
    for _, reward in pairs(caisse.rewards) do
        totalChance = totalChance + reward.chance
    end

    local roll = math.random(1, totalChance)
    local currentSum = 0

    for _, reward in pairs(caisse.rewards) do
        currentSum = currentSum + reward.chance
        if roll <= currentSum then
            return reward
        end
    end
end

-- Event pour ouvrir une caisse
RegisterServerEvent('store:openCaisse')
AddEventHandler('store:openCaisse', function(caisseType)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local caisse = CaisseConfig[caisseType]

    if not caisse then
        TriggerClientEvent('esx:showNotification', _source, 'Cette caisse n\'existe pas!')
        return
    end

    if tonumber(xPlayer.getStorePoints()) >= tonumber(caisse.price) then
        xPlayer.removeStorePoints(tonumber(caisse.price))
        -- Mise à jour des points côté client
        TriggerClientEvent('store:updatePoints', _source, xPlayer.getStorePoints())
        
        local reward = GetRandomReward(caisseType)
        if reward then
            -- Attribution de la récompense
            if reward.type == "weapon" then
                xPlayer.addWeapon(reward.item, reward.amount)
                TriggerClientEvent('esx:showNotification', _source, 'Vous avez reçu ' .. ESX.GetWeaponLabel(reward.item))
            elseif reward.type == "money" then
                if reward.item == "black_money" then
                    xPlayer.addAccountMoney(reward.item, reward.amount)
                else
                    xPlayer.addMoney(reward.amount)
                end
                TriggerClientEvent('esx:showNotification', _source, 'Vous avez reçu ' .. reward.amount .. '$')
            elseif reward.type == "vehicle" then
                AssignVehicle(_source, xPlayer.getUUID(), reward.item, GeneratePlate())
            elseif reward.type == "storepoints" then
                xPlayer.addStorePoints(reward.amount)
                -- Mise à jour des points après avoir reçu des points en récompense
                TriggerClientEvent('store:updatePoints', _source, xPlayer.getStorePoints())
                TriggerClientEvent('esx:showNotification', _source, 'Vous avez reçu ' .. reward.amount .. ' points boutique!')
            end

            TriggerEvent('esx:sendLog', "store", GetPlayerName(_source) .. " ( " .. _source .. ' - ' .. xPlayer.getUUID() .. " )" .. ' a ouvert une ' .. caisseType .. ' et a reçu ' .. reward.type .. ' ' .. (reward.item or reward.amount))
        end
    else
        TriggerClientEvent('esx:showNotification', _source, 'Vous n\'avez pas assez de points boutique!')
    end
end)