---
---
---

ESX = nil
while ESX == nil do
    ESX = exports['Core_CypherDev']:getSharedObject()
    Citizen.Wait(0)
end

Citizen.CreateThread(function()
    local timeOut = 10
    while timeOut > 0 do
        TriggerEvent('cypherdev_ui:SendNUIMessage', "hud", { disableInformations1 = true })
        Citizen.Wait(250)
        timeOut = timeOut - 1
    end
end)

AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == "Core_CypherDev" then
        ESX = exports['Core_CypherDev']:getSharedObject()
    end
end)