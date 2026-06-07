---
---
---

RegisterNetEvent('Tarek-ui:OpenRegister')
AddEventHandler('Tarek-ui:OpenRegister', function()
    TriggerEvent('Tarek-ui:SetNuiFocus', true)
    TriggerEvent('Tarek-ui:SendNUIMessage', "register", {
        action = "show"
    })
end)

TriggerEvent('Tarek-ui:RegisterNUICallback', "register", "validateRegister", function(data, cb)
    ESX.TriggerServerCallback('creator:updateIdentity', function(response)
        if response then
            TriggerEvent('Tarek-ui:SetNuiFocus', false)
            TriggerEvent('Tarek-ui:SendNUIMessage', "register", { action = "hide" })
            exports['Tarek']:stopCamera()
            TriggerEvent('Tarek-skincreator:createCharacter')
        end
    end, data)
    cb('ok')
end)