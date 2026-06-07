local CountPlayers = 0

Citizen.CreateThread(function()
    AddTextEntry('PM_PANE_LEAVE', ESXConfig.DefaultColorCode .. 'Retourner sur la liste des serveurs.')
    AddTextEntry("PM_PANE_QUIT", "Fermer ~r~FiveM")
    AddTextEntry("PM_SCR_MAP", "Map " .. ESXConfig.DefaultColorCode .. ESXConfig.ServerName .. "~w~")
    AddTextEntry("PM_SCR_GAM", ESXConfig.DefaultColorCode .. "A�roport~w~")
    AddTextEntry("PM_SCR_INF", ESXConfig.DefaultColorCode .. "Logs~w~")
    AddTextEntry("PM_SCR_STA", ESXConfig.DefaultColorCode .. "Statistiques~w~")
    AddTextEntry("PM_SCR_SET", ESXConfig.DefaultColorCode .. "Param�tres~w~")
    AddTextEntry("PM_SCR_GAL", ESXConfig.DefaultColorCode .. "Gallerie~w~")
    AddTextEntry("PM_SCR_RPL", ESXConfig.DefaultColorCode .. "Rockstar~w~")
    AddTextEntry('PM_PANE_KEYS', ESXConfig.DefaultColorCode .. "Configurer vos Touches")
    AddTextEntry('PM_PANE_CFX', ESXConfig.DefaultColorCode .. ESXConfig.ServerName)
end)

Citizen.CreateThread(function()
    while not ESX.PlayerData.PassJoin do
        Wait(100)
    end
    while true do
        SetDiscordAppId(ESXConfig.RichPresenceID)
        SetDiscordRichPresenceAsset("logo")
        SetDiscordRichPresenceAssetText(ESXConfig.DiscordURL)
        
        local uuid = ESX.PlayerData.uuid
        SetRichPresence(uuid .. " | " .. CountPlayers .. "/128")
        SetDiscordRichPresenceAction(0, "?? DISCORD", ESXConfig.DiscordURL)
        SetDiscordRichPresenceAction(1, "?? JOUER", "fivem://connect/" .. ESXConfig.ConnectURL)
        
        AddTextEntry("FE_THDR_GTAO", uuid .. " | " .. CountPlayers .. "/128" .. " - " .. ESXConfig.DefaultColorCode .. ESXConfig.ServerName .. "~w~ | " .. ESXConfig.DiscordURL)
        Citizen.Wait(10000)
    end
end)

RegisterNetEvent("esx:UpdatePlayersCount")
AddEventHandler("esx:UpdatePlayersCount", function(count)
    CountPlayers = count
end)

