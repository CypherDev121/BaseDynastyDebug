---
---
---

local function loadItems(list)
    local d = {}
    for i = 1, #list do
        table.insert(d, {
            label = list[i].label,
            name = list[i].name,
            price = list[i].price,
            img = list[i].img or string.format("https://image.wac-fivem.com/image/%s.png", list[i].name)
        })
    end
    return d
end

do
    Citizen.Wait(1000)
    TriggerEvent('Tarek-ui:RegisterNUICallback', "shop", "pay", function(data, cb)
        for k,v in pairs(data.basket) do
            if v.amount > 0 then
                TriggerServerEvent('Tarek-ui:shopPay', v.name, v.price, data.method)
            end
        end
        cb('ok')
    end)

    TriggerEvent('Tarek-ui:RegisterNUICallback', "shop", "close", function(data, cb)
        TriggerEvent('Tarek-ui:SetNuiFocus', false)
        cb('ok')
    end)
end

Citizen.CreateThread(function()
    for k,v in pairs(ConF.LTD.Positions) do
        local blip = AddBlipForCoord(v)
        SetBlipSprite(blip, 52)
        SetBlipScale(blip, 0.7)
        SetBlipColour(blip, 2)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("LTD 24/7")
        EndTextCommandSetBlipName(blip)
    end
    while true do
        local isNear = false
        for _, location in pairs(ConF.LTD.Positions) do
            local dist = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), location, true)
            if dist < 3 then
                isNear = true
                ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour intéragir")
                if IsControlJustPressed(0, 38) then
                    TriggerEvent('Tarek-ui:SetNuiFocus', true)
                    TriggerEvent('Tarek-ui:SendNUIMessage', "shop", {
                        action = "show",
                        userIdentity = GetPlayerName(PlayerId()),
                        shopData = loadItems(ConF.LTD.Items)
                    })
                end
            end
        end
        Citizen.Wait(isNear and 0 or 750)
    end
end)