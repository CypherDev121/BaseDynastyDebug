---
---
---

ESX = nil
while ESX == nil do
    ESX = exports['Tarek']:getSharedObject()
    Citizen.Wait(0)
end

Citizen.CreateThread(function()
    local timeOut = 10
    while timeOut > 0 do
        TriggerEvent('Tarek-ui:SendNUIMessage', "hud", { disableInformations1 = true })
        Citizen.Wait(250)
        timeOut = timeOut - 1
    end
end)

AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == "Tarek" then
        ESX = exports['Tarek']:getSharedObject()
    end
end)