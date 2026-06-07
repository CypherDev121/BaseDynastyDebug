ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
end)

local isUiOpen = false
local AmmunationLocation = {
    {x = -662.1, y = -935.3, z = 20.8},
    {x = 810.2, y = -2157.3, z = 28.6},
    {x = 1693.4, y = 3759.5, z = 33.7},
    {x = -330.2, y = 6083.8, z = 30.4},
    {x = 252.3, y = -50.0, z = 68.9},
    {x = 22.0, y = -1107.2, z = 28.8},
    {x = 2567.6, y = 294.3, z = 107.7},
    {x = -1117.5, y = 2698.6, z = 17.5},
    {x = -842.5, y = -1033.0, z = 27.1},
    {x = -3171.9, y = 1087.3, z = 19.838},
    {x = -1306.2, y = -393.691, z = 35.695}
}

function OpenShop(shopType)
    TriggerServerEvent('shop:requestItems', shopType)
end

RegisterNetEvent('shop:openMenu')
AddEventHandler('shop:openMenu', function(items, shopType)
    if not isUiOpen then
        SetNuiFocus(true, true)

        SendNuiMessage(json.encode({
            action = 'open',
            items = items,
            shopType = shopType
        }))

        isUiOpen = true
    else   
        SetNuiFocus(false, false)
        SendNuiMessage(json.encode({
            action = 'close'
        }))
        isUiOpen = false
    end
end)

RegisterNetEvent('shop:openShop')
AddEventHandler('shop:openShop', function(shopType)
    OpenShop(shopType)
end)

RegisterNUICallback('close', function()
    SetNuiFocus(false, false)
    SendNuiMessage(json.encode({
        action = 'close'
    }))
    isUiOpen = false
end)

RegisterNUICallback('closeall', function()
    SetNuiFocus(false, false)
    SendNuiMessage(json.encode({
        action = 'close'
    }))
    isUiOpen = false
end)

RegisterNUICallback('checkMoney', function(data, cb)
    TriggerServerEvent('shop:checkMoney', data)
    cb('ok')
end)

RegisterNetEvent('shop:checkoutResult')
AddEventHandler('shop:checkoutResult', function(success)
    if success then
        SendNuiMessage(json.encode({
            action = 'clearCart'
        }))
        SetNuiFocus(false, false)
        isUiOpen = false
    else
        TriggerEvent('esx:showNotification', 'Vous n\'avez pas assez d\'argent.')
    end
end)

Citizen.CreateThread(function()
    for _, location in ipairs(AmmunationLocation) do
        local blip = AddBlipForCoord(location.x, location.y, location.z)
        SetBlipSprite(blip, 110)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.8)
        SetBlipColour(blip, 1)
        SetBlipAsShortRange(blip, true)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Armurerie")
        EndTextCommandSetBlipName(blip)
    end

    while true do
        local playerCoords = GetEntityCoords(PlayerPedId())
        local isNearAnyShop = false

            for _, location in ipairs(AmmunationLocation) do
            local distance = #(playerCoords - vector3(location.x, location.y, location.z))
            if distance < 1.5 then
                isNearAnyShop = true
                ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le menu.")
                if IsControlJustReleased(0, 38) then
                    OpenShop('ammunation')
                end
            end
        end

        if not isNearAnyShop then
            Citizen.Wait(500)
        else
            Citizen.Wait(0)
        end
    end
end)