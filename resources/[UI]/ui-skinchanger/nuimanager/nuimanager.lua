local NUIFocus = false
local isCreatingCharacter = false

RegisterNetEvent("Tarek-skincreator:SendNUIMessage")
AddEventHandler("Tarek-skincreator:SendNUIMessage", function(message)
    SendNUIMessage(message)
end)

RegisterNetEvent("Tarek-skincreator:RegisterNUICallback")
AddEventHandler("Tarek-skincreator:RegisterNUICallback", function(name, func)
    RegisterNUICallback(name, func)
end)

RegisterNetEvent("Tarek-skincreator:setNUIFocus")
AddEventHandler("Tarek-skincreator:setNUIFocus", function(toggle)
    NUIFocus = toggle
    SetNuiFocus(toggle, toggle)
end)

Citizen.CreateThread(function()
    TriggerEvent("Tarek-skincreator:RegisterNUICallback", "close", function()
        TriggerEvent("Tarek-skincreator:setNUIFocus", false)
        TriggerEvent("Tarek-skincreator:SendNUIMessage", {
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


RegisterNetEvent("Tarek-skincreator:createCharacter")
AddEventHandler("Tarek-skincreator:createCharacter", function()
    isCreatingCharacter = true
    TriggerEvent("Tarek-skincreator:setNUIFocus", true)
    TriggerEvent("Tarek-skincreator:SendNUIMessage", {
        show= true,
    })
end)

RegisterNUICallback("selectCategory", function(data, cb)
    TriggerEvent("Tarek-skincreator:SendNUIMessage", {
        serverName = "DynastyRP",
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
            TriggerEvent("Tarek-skincreator:SendNUIMessage", {
                show = false
            })
            TriggerEvent("Tarek-skincreator:setNUIFocus", false)
            TriggerServerEvent('esx_skin:save', skin)
            TriggerEvent('Dynasty:Addons:Client:chooseStarter')
        end)
    end
    ESX.TriggerServerCallback('Tarek-skincreator:saveSkin', function(response)
        if response then
            TriggerEvent('skinchanger:getSkin', function(skin)
                TriggerServerEvent('esx_skin:save', skin)
            end)
        end
    end)
    cb("ok")
end)