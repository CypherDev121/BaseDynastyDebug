ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local display = false

Citizen.CreateThread(function()
    for _, bank in pairs(Config.Banks) do
        local blip = AddBlipForCoord(bank.coords)
        SetBlipSprite(blip, bank.blip.sprite)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, bank.blip.scale)
        SetBlipColour(blip, bank.blip.color)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(bank.blip.label)
        EndTextCommandSetBlipName(blip)
    end
end)

Citizen.CreateThread(function()
    while true do
        local sleep = 1000
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        
        for _, bank in pairs(Config.Banks) do
            local distance = #(coords - bank.coords)
            
            if distance < Config.DisplayDistance then
                sleep = 0
                DrawMarker(1, bank.coords.x, bank.coords.y, bank.coords.z - 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 128, 0, 255, 100, false, true, 2, false, nil, nil, false)
                
                if distance < 1.5 then
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder à la banque")
                    if IsControlJustReleased(0, Config.InteractionKey) then
                        OpenBankingUI()
                    end
                end
            end
        end
        
        Wait(sleep)
    end
end)

Citizen.CreateThread(function()
    while true do
        if display then
            local playerPed = PlayerPedId()
            local coords = GetEntityCoords(playerPed)
            local isNearBank = false
            
            for _, bank in pairs(Config.Banks) do
                if #(coords - bank.coords) < Config.DisplayDistance then
                    isNearBank = true
                    break
                end
            end
            
            if not isNearBank then
                CloseBankingUI()
            end
        end
        Wait(1000)
    end
end)

function OpenBankingUI()
    if display then return end
    
    display = true
    SetNuiFocus(true, true)
    SendNUIMessage({
        type = "ui",
        status = true
    })
    
    ESX.TriggerServerCallback('banking:getAccountInfo', function(accountInfo)
        SendNUIMessage({
            type = "update",
            balance = accountInfo.balance,
            firstName = accountInfo.firstName,
            lastName = accountInfo.lastName,
            transactions = accountInfo.transactions
        })
    end)
end

function CloseBankingUI()
    display = false
    SetNuiFocus(false, false)
    SendNUIMessage({
        type = "ui",
        status = false
    })
end


RegisterNUICallback('exit', function(data, cb)
    CloseBankingUI()
    cb('ok')
end)

RegisterNUICallback('deposit', function(data, cb)
    TriggerServerEvent('banking:deposit', tonumber(data.amount))
    cb('ok')
end)

RegisterNUICallback('withdraw', function(data, cb)
    TriggerServerEvent('banking:withdraw', tonumber(data.amount))
    cb('ok')
end)

RegisterNUICallback('transfer', function(data, cb)
    TriggerServerEvent('banking:transfer', tonumber(data.targetId), tonumber(data.amount))
    cb('ok')
end)

RegisterNetEvent('banking:updateUI')
AddEventHandler('banking:updateUI', function(data)
    if display then
        SendNUIMessage({
            type = "update",
            balance = data.balance,
            transactions = data.transactions
        })
    end
end)

RegisterNetEvent('banking:refreshBalance')
AddEventHandler('banking:refreshBalance', function()
    if display then
        ESX.TriggerServerCallback('banking:getAccountInfo', function(accountInfo)
            SendNUIMessage({
                type = "update",
                balance = accountInfo.balance,
                firstName = accountInfo.firstName,
                lastName = accountInfo.lastName
            })
        end)
    end
end)

AddEventHandler('esx:onPlayerDeath', function()
    if display then
        CloseBankingUI()
    end
end)