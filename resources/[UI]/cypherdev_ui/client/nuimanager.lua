local NUIFocus = false

RegisterNetEvent("cypherdev_ui:SendNUIMessage")
AddEventHandler("cypherdev_ui:SendNUIMessage", function(module, message)
    message.module = module
    SendNUIMessage(message)
end)

RegisterNetEvent("cypherdev_ui:RegisterNUICallback")
AddEventHandler("cypherdev_ui:RegisterNUICallback", function(moduleName, name, func)
    RegisterNUICallback(moduleName .. "-" .. name, func)
end)

RegisterNetEvent("cypherdev_ui:SetNuiFocus")
AddEventHandler("cypherdev_ui:SetNuiFocus", function(toggle)
    NUIFocus = toggle
    SetNuiFocus(toggle, toggle)
end)
