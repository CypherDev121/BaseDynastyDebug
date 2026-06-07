local NUIFocus = false
local isCreatingCharacter = false

RegisterNetEvent("Cypher-skincreator:SendNUIMessage")
AddEventHandler("Cypher-skincreator:SendNUIMessage", function(message)
    SendNUIMessage(message)
end)

RegisterNetEvent("Cypher-skincreator:RegisterNUICallback")
AddEventHandler("Cypher-skincreator:RegisterNUICallback", function(name, func)
    RegisterNUICallback(name, func)
end)

RegisterNetEvent("Cypher-skincreator:setNUIFocus")
AddEventHandler("Cypher-skincreator:setNUIFocus", function(toggle)
    NUIFocus = toggle
    SetNuiFocus(toggle, toggle)
end)

Citizen.CreateThread(function()
    TriggerEvent("Cypher-skincreator:RegisterNUICallback", "close", function()
        TriggerEvent("Cypher-skincreator:setNUIFocus", false)
        TriggerEvent("Cypher-skincreator:SendNUIMessage", {
            show = false
        })    
    end)
end)

function createCameraFrontOfPlayer()
    local playerPed = PlayerPedId()
    local playerCoords = GetPedBoneCoords(playerPed, 31086)
    local playerHeading = GetEntityHeading(playerPed)
    local frontOffset = math.rad(playerHeading)
    
    local camX = playerCoords.x + math.sin(frontOffset) * 1.0
    local camY = playerCoords.y + math.cos(frontOffset) * 1.0
    local camZ = playerCoords.z
    
    local cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
    SetCamCoord(cam, camX, camY, camZ)
    PointCamAtCoord(cam, playerCoords.x, playerCoords.y, playerCoords.z)
    SetCamFov(cam, 40.0)

    SetCamActive(cam, true)
    RenderScriptCams(true, false, 0, true, true)

    return cam
end


RegisterNetEvent("Cypher-skincreator:createCharacter")
AddEventHandler("Cypher-skincreator:createCharacter", function()
    isCreatingCharacter = true
    TriggerEvent("Cypher-skincreator:setNUIFocus", true)
    TriggerEvent("Cypher-skincreator:SendNUIMessage", {
        show= true,
    })
end)

RegisterNUICallback("selectCategory", function(data, cb)
    TriggerEvent("Cypher-skincreator:SendNUIMessage", {
        serverName = "NyseraRP",
        menuName = "Modification de l'apparence",
        menuSubTitle = "Création de personnage",
        menuDesc = "Cette interface vous permet de modifier votre personnage à votre guise.",
        selectedCategory = data.key,
        variationsCount = variationsHandler[data.key].variationsCount,
        variationsList = variationsHandler[data.key].variationsList,
        itemsList = generateItems(data.key)
    })
    cb("ok")
end)

RegisterNUICallback('updateSkinData', function(data, cb)
    TriggerEvent('skinchanger:change', data.key, tonumber(data.value))
    cb("ok")
end)

RegisterNUICallback('validate', function(data, cb)
    if isCreatingCharacter then
        TriggerEvent('skinchanger:getSkin', function(skin)
            TriggerEvent("Cypher-skincreator:SendNUIMessage", {
                show = false
            })
            TriggerEvent("Cypher-skincreator:setNUIFocus", false)
            TriggerServerEvent('esx_skin:save', skin)
            TriggerEvent('NyseraRP:Addons:Client:chooseStarter')
        end)
    end
    ESX.TriggerServerCallback('Cypher-skincreator:saveSkin', function(response)
        if response then
            TriggerEvent('skinchanger:getSkin', function(skin)
                TriggerServerEvent('esx_skin:save', skin)
            end)
        end
    end)
    cb("ok")
end)