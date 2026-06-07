local NUIFocus = false

RegisterNetEvent("Tarek-ui:SendNUIMessage")
AddEventHandler("Tarek-ui:SendNUIMessage", function(module, message)
    message.module = module
    SendNUIMessage(message)
end)

RegisterNetEvent("Tarek-ui:RegisterNUICallback")
AddEventHandler("Tarek-ui:RegisterNUICallback", function(moduleName, name, func)
    RegisterNUICallback(moduleName .. "-" .. name, func)
end)

RegisterNetEvent("Tarek-ui:SetNuiFocus")
AddEventHandler("Tarek-ui:SetNuiFocus", function(toggle)
    NUIFocus = toggle
    SetNuiFocus(toggle, toggle)
end)
