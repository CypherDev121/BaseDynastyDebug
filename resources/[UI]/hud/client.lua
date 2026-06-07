ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(10)
    end
end)

function updateHUD()
    if not ESX then return end
    ESX.TriggerServerCallback('NyseraRPHUD:getPlayerMoney', function(data)
        if data then
            SendNUIMessage({
                type = 'updateHUD',
                dirty = data.dirty,   -- Argent Sale
                cash = data.cash,     -- Liquide
                bank = data.bank      -- Banque
            })
        end
    end)
end

AddEventHandler('playerSpawned', updateHUD)
RegisterNetEvent('esx:setAccountMoney', updateHUD)

RegisterCommand('update', function()
    updateHUD()
end, false)

Citizen.CreateThread(function()
    while true do
        updateHUD()
        Citizen.Wait(5000)
    end
end)