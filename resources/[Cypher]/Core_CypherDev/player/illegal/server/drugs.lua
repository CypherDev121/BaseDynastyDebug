local PlayersHarvesting = {}
local PlayersTransforming = {}
local PlayersSelling = {}

local function Harvest(source, drug)

	SetTimeout(5000, function()

		if PlayersHarvesting[source] == true then

			local xPlayer  = ESX.GetPlayerFromId(source)

			if CheckDrugsCoords(source, drug, "harvest") then

			    if not xPlayer.canCarryItem(drug, 1) then 
				    PlayersHarvesting[source] = false 
				    TriggerClientEvent('esx:showNotification', source, 'Votre inventaire est plein')
				    return
			    end

			    xPlayer.addInventoryItem(drug, 1)
			    Harvest(source, drug)
		    else
				PlayersHarvesting[source] = false
		    end

		end
	end)
end

RegisterServerEvent('drugs:startHarvest')
AddEventHandler('drugs:startHarvest', function(drug)

	local _source = source

	if CheckDrugsCoords(source, drug, "harvest") then

	PlayersHarvesting[_source] = true

	TriggerClientEvent('esx:showNotification', _source, 'Récolte en cours...')

	Harvest(_source, drug)
	else
		exports["WaveShield"]:banPlayer(_source, "Unauthorized Drugs Farm attempt", "Unauthorized Drugs Farm attempt", "Main", 9999999999999)
	end

end)

RegisterServerEvent('drugs:stopHarvest')
AddEventHandler('drugs:stopHarvest', function()

	local _source = source

	PlayersHarvesting[_source] = false

end)

local function Transform(source, drug)

	SetTimeout(7000, function()

		if PlayersTransforming[source] == true then

			local _source = source
			local xPlayer = ESX.GetPlayerFromId(_source)

			if CheckDrugsCoords(source, drug, "transform") then

			    local Quantity = xPlayer.getInventoryItem(drug).count
			    if not xPlayer.canCarryItem(drug .. '_pooch', 1) then 
				    TriggerClientEvent('esx:showNotification', source, 'Votre inventaire est plein')
				    return
			    end
			    if Quantity < 3 then
				    TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez pas assez de drogue sur vous')
			    else
				    xPlayer.removeInventoryItem(drug, 3)
				    xPlayer.addInventoryItem(drug .. '_pooch', 1)
			
				    Transform(source, drug)
			    end

			else
				PlayersTransforming[source] = false
		    end

		end
	end)
end

RegisterServerEvent('drugs:startTransform')
AddEventHandler('drugs:startTransform', function(drug)

	local _source = source

	if CheckDrugsCoords(source, drug, "transform") then

	PlayersTransforming[_source] = true

	TriggerClientEvent('esx:showNotification', _source, 'Transformation en cours...')

	Transform(_source, drug)

	else
		exports["WaveShield"]:banPlayer(_source, "Unauthorized Drugs Farm attempt", "Unauthorized Drugs Farm attempt", "Main", 9999999999999)
	end
end)

RegisterServerEvent('drugs:stopTransform')
AddEventHandler('drugs:stopTransform', function()

	local _source = source

	PlayersTransforming[_source] = false

end)

local function Sell(source, drug)

	SetTimeout(4000, function()
      
		if PlayersSelling[source] == true then

			local _source = source
			local xPlayer = ESX.GetPlayerFromId(_source)
		if CheckDrugsCoords(source, drug, "sell") then


		if drug ~= "moneywash" then
			local poochQuantity = xPlayer.getInventoryItem(drug .. '_pooch').count

			if poochQuantity == 0 then
				TriggerClientEvent('esx:showNotification', source,'Pas assez d\'items sur vous')
			else
				xPlayer.removeInventoryItem(drug .. '_pooch', 1)
				local modifier = 1

			if GetVIP(source) then
				modifier = 1.5
				TriggerClientEvent('esx:showNotification', source, 'Vous avez un bonus grâce à votre grade VIP')

			end 
			    
                if drug == 'coke' then
				xPlayer.addAccountMoney('black_money', modifier * 2000)
                elseif drug == 'meth' then
                xPlayer.addAccountMoney('black_money', modifier * 3000)
                elseif drug == 'opium' then
                xPlayer.addAccountMoney('black_money', modifier * 2500)
                elseif drug == 'weed' then
                xPlayer.addAccountMoney('black_money', modifier * 1500) 
                end
				TriggerClientEvent('esx:showNotification', source, 'Vendu 1x'..drug..'')
				
				Sell(source, drug)
			end

elseif drug == "moneywash" then
                    -- Logique pour blanchir de l'argent avec moneywash par tranches de 9000
                    local blackMoney = xPlayer.getAccount('black_money').money

                    if blackMoney >= 9000 then
                        xPlayer.removeAccountMoney('black_money', 9000)
                        xPlayer.addMoney(9000)  -- Convertir en argent propre
                        TriggerClientEvent('esx:showNotification', source, 'Vous avez blanchi ~g~9000$~s~')
                        Sell(source, drug)
                    else
                        TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez pas assez d\'argent ~r~sale~s~ à blanchir')
                    end
                elseif drug == "washblack" then
                    -- Logique pour le blanchiment d'argent propre en argent sale (washblack) par tranches de 9000
                    local cleanMoney = xPlayer.getMoney()

                    if cleanMoney >= 9000 then
                        xPlayer.removeMoney(9000)
                        xPlayer.addAccountMoney('black_money', 9000)
                        TriggerClientEvent('esx:showNotification', source, 'Vous avez converti ~g~9000$~s~ en argent sale.')
                        Sell(source, drug)
                    else
                        TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez pas assez d\'argent ~g~propre~s~ pour convertir.')
                    end
                else
                    PlayersSelling[source] = false
                end
            else
                PlayersSelling[source] = false
            end
        end
    end)
end

function CheckDrugsCoords(source, drug, zone)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not DrugsZones[drug] or not DrugsZones[drug][zone] then
        PlayersHarvesting[source] = false
        PlayersSelling[source] = false
        PlayersTransforming[source] = false
        TriggerClientEvent('esx:showNotification', source, 'Zone de drogue non trouvée.')
        return false
    end

    local coords = vector3(DrugsZones[drug][zone].x, DrugsZones[drug][zone].y, DrugsZones[drug][zone].z)
    local playerped = GetPlayerPed(source)
    local playercoords = GetEntityCoords(playerped)

    if xPlayer then
        if #(playercoords - coords) < 10 then
            return true
        else
            PlayersHarvesting[source] = false
            PlayersSelling[source] = false
            PlayersTransforming[source] = false
        end
    else
        DropPlayer(source, "Désynchronisation ou stop resource")
    end

    return false
end


RegisterServerEvent('drugs:startSell')
AddEventHandler('drugs:startSell', function(drug)

	local _source = source

	if CheckDrugsCoords(source, drug, "sell") then

	PlayersSelling[_source] = true

	TriggerClientEvent('esx:showNotification', _source, 'Vente en cours...')

	Sell(_source, drug)
	else
		exports["WaveShield"]:banPlayer(_source, "Unauthorized Drugs Farm attempt", "Unauthorized Drugs Farm attempt", "Main", 9999999999999)

	---	SendAntiCheatLog(_source, "Unauthorized Drugs Farm attempt", true)
	end
end)

RegisterServerEvent('drugs:stopSell')
AddEventHandler('drugs:stopSell', function()

	local _source = source

	PlayersSelling[_source] = false

end)

local function SellAllDrugs(source)
    SetTimeout(4000, function()
        if PlayersSelling[source] == true then
            local xPlayer = ESX.GetPlayerFromId(source)
            local drugTypes = {"coke", "meth", "opium", "weed"}  -- Types de drogues à vérifier

            local anySold = false
            for _, drug in ipairs(drugTypes) do
                local poochQuantity = xPlayer.getInventoryItem(drug .. '_pooch').count

                while poochQuantity > 0 do
                    xPlayer.removeInventoryItem(drug .. '_pooch', 1)
                    local modifier = 1

                    if GetVIP(source) then
                        modifier = 1.5
                        TriggerClientEvent('esx:showNotification', source, 'Vous avez un bonus grâce à votre grade VIP')
                    end 

                    local price = 0
                    if drug == 'coke' then
                        price = modifier * 2000
                    elseif drug == 'meth' then
                        price = modifier * 3000
                    elseif drug == 'opium' then
                        price = modifier * 2500
                    elseif drug == 'weed' then
                        price = modifier * 1500
                    end

                    xPlayer.addAccountMoney('black_money', price)
                    TriggerClientEvent('esx:showNotification', source, 'Vendu 1x ' .. drug)
                    poochQuantity = poochQuantity - 1
                    anySold = true
                end
            end

            if not anySold then
                TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez plus de drogues à vendre')
                PlayersSelling[source] = false
            else
                SellAllDrugs(source)
            end
        end
    end)
end

RegisterServerEvent('drugs:startSellAll')
AddEventHandler('drugs:startSellAll', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local drugsList = {"coke", "weed", "meth", "opium"} -- Liste des types de drogues disponibles
    local hasSold = false

    local function sellDrug(drugIndex)
        if drugIndex > #drugsList then
            TriggerClientEvent('esx:showNotification', _source, 'Vous avez vendu tout ce que vous pouviez.')
            return
        end

        local drug = drugsList[drugIndex]
        local poochQuantity = xPlayer.getInventoryItem(drug .. '_pooch').count

        if poochQuantity > 0 then
            xPlayer.removeInventoryItem(drug .. '_pooch', 1)
            local modifier = 1
            if GetVIP(_source) then
                modifier = 1.5
                TriggerClientEvent('esx:showNotification', _source, 'Vous avez un bonus grâce à votre grade VIP')
            end

            local payment = 0
            if drug == 'coke' then
                payment = modifier * 2000
            elseif drug == 'meth' then
                payment = modifier * 3000
            elseif drug == 'opium' then
                payment = modifier * 2500
            elseif drug == 'weed' then
                payment = modifier * 1500
            end

            xPlayer.addAccountMoney('black_money', payment)
            TriggerClientEvent('esx:showNotification', _source, 'Vendu 1x ' .. drug)

            -- Recommencer la vente pour le même type de drogue après un délai
            SetTimeout(4000, function()
                sellDrug(drugIndex)
            end)
            hasSold = true
        else
            -- Passer à la prochaine drogue
            SetTimeout(4000, function()
                sellDrug(drugIndex + 1)
            end)
        end
    end

    -- Démarrer la vente avec le premier type de drogue
    sellDrug(1)
end)


