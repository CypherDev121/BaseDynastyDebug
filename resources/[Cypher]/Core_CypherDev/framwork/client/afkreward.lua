RegisterCommand("afk", function()
    if ESX.PlayerData.PassJoin and (ESX.PlayerData.safezone or ESX.PlayerData.AFK) then
        ToggleAFK()
    else
        ESX.ShowNotification("Vous ne pouvez pas vous mettre en afk")
    end
end)

function ToggleAFK()
    ESX.PlayerData.AFK = not ESX.PlayerData.AFK
	TriggerServerEvent("esx:ToggleAFK")
    local logoopacity = 0
    local background = 'transparent'
    if ESX.PlayerData.AFK then
        logoopacity = 100
        background = 'url(https://media.discordapp.net/attachments/957321579996512276/969814821442822154/unknown.png)'
        TriggerEvent('esx:displayHud', false)
    else
        TriggerEvent('esx:displayHud', true)
    end
    SendNUIMessage({
        action = 'displayLogo',
        opacity = logoopacity,
        background = background
    })
    FreezeEntityPosition(ESX.PlayerData.cache.playerped, ESX.PlayerData.AFK)
    SetEntityVisible(ESX.PlayerData.cache.playerped, not ESX.PlayerData.AFK)
    if ESX.PlayerData.AFK then
        SetEntityCoords(ESX.PlayerData.cache.playerped, -1809.89, 5511.23, 11.24)
    else
        SetEntityCoords(ESX.PlayerData.cache.playerped, 224.32, -788.5, 30.73)    
    end
    Citizen.CreateThread(function()
        while ESX.PlayerData.AFK do
            if #(ESX.PlayerData.cache.coords - vector3(-1809.89, 5511.23, 11.24)) > 10 then
                SetEntityCoords(ESX.PlayerData.cache.playerped, -1809.89, 5511.23, 11.24)
            end
            FreezeEntityPosition(ESX.PlayerData.cache.playerped, ESX.PlayerData.AFK)
            SetEntityVisible(ESX.PlayerData.cache.playerped, not ESX.PlayerData.AFK)
            Wait(5)
        end
        FreezeEntityPosition(ESX.PlayerData.cache.playerped, ESX.PlayerData.AFK)
        SetEntityVisible(ESX.PlayerData.cache.playerped, not ESX.PlayerData.AFK)
        if ESX.PlayerData.AFK then
            SetEntityCoords(ESX.PlayerData.cache.playerped, -1809.89, 5511.23, 11.24)
        else
            SetEntityCoords(ESX.PlayerData.cache.playerped, 224.32, -788.5, 30.73)    
        end
    end)
end

