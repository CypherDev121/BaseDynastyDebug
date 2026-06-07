local NUIFocus = false

RegisterNetEvent("zinzins-ui:SendNUIMessage")
AddEventHandler("zinzins-ui:SendNUIMessage", function(module, message)
    message.module = module
    SendNUIMessage(message)
end)

RegisterNUICallback('hideDeathscreen', function(data, cb)
    if data.action == "hide" then SetNuiFocus(false, false) end
    cb('ok')
end)

RegisterNetEvent("zinzins-ui:RegisterNUICallback")
AddEventHandler("zinzins-ui:RegisterNUICallback", function(moduleName, name, func)
    RegisterNUICallback(moduleName .. "-" .. name, func)
end)

RegisterNetEvent("zinzins-ui:SetNuiFocus")
AddEventHandler("zinzins-ui:SetNuiFocus", function(toggle)
    NUIFocus = toggle
    SetNuiFocus(toggle, toggle)
end)

RegisterNUICallback('gunfightselector-closegunfightselector', function(data, cb)
    SetNuiFocus(false, false)
    SendNUIMessage({
        type = "gunfightselector",
        module = "gunfightselector",
        action = "hide"
    })
    TriggerEvent('gunfight:closeSelector')
    cb('ok')
end)
