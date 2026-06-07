---
---
---

RegisterNetEvent('cypherdev_ui:OpenRegister')
AddEventHandler('cypherdev_ui:OpenRegister', function()
    TriggerEvent('cypherdev_ui:SetNuiFocus', true)
    TriggerEvent('cypherdev_ui:SendNUIMessage', "register", {
        action = "show"
    })
end)

TriggerEvent('cypherdev_ui:RegisterNUICallback', "register", "validateRegister", function(data, cb)
    ESX.TriggerServerCallback('creator:updateIdentity', function(response)
        if response then
            TriggerEvent('cypherdev_ui:SetNuiFocus', false)
            TriggerEvent('cypherdev_ui:SendNUIMessage', "register", { action = "hide" })
            exports['Core_CypherDev']:stopCamera()
            TriggerEvent('Cypher-skincreator:createCharacter')
        end
    end, data)
    cb('ok')
end)