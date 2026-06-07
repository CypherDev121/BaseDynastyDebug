local NUIFocus = false
local inGunfightZone = false
local isLeaderboardVisible = false

local function hideAllUI()
    -- Cache le leaderboard
    SendNUIMessage({
        action = "setLeaderboard",
        opacity = 0
    })
    -- Cache le placement
    SendNUIMessage({
        action = "hideMyPlacement"
    })
end

exports('setInGunfightZone', function(status)
    inGunfightZone = status
    if not status then
        hideAllUI()
        SendNUIMessage({
            action = "showMyPlacement"
        })
        SendNUIMessage({
            action = "notification",
            status = "exit",
            title = "ZONE GUNFIGHT",
            text = "Vous avez quitté la zone de combat !",
            noPlacement = true
        })
    end
end)

exports('showNotification', function(status, title, text)
    SendNUIMessage({
        action = "notification",
        status = status,
        title = title,
        text = text,
        noPlacement = not inGunfightZone
    })
end)

exports('showNotificationRed', function(status, title, text)
    SendNUIMessage({
        action = "notification",
        status = status,
        title = title,
        text = text,
        noPlacement = not inGunfightZone,
        color = "red"
    })
end)

exports('updateLeaderboard', function(playerData)
    if not inGunfightZone then return end
    SendNUIMessage({
        action = "populateLeaderBoard",
        data = playerData
    })
end)

exports('updateRank', function(rank, total)
    if not inGunfightZone then 
        SendNUIMessage({
            action = "hideMyPlacement"
        })
        return 
    end
    SendNUIMessage({
        action = "updateRank",
        text = rank .. " / " .. total
    })
end)

exports('addKill', function(killer, weapon, victim)
    if not inGunfightZone then return end
    SendNUIMessage({
        action = "addKill",
        killer = killer,
        weapon = weapon,
        victim = victim
    })
end)

-- Gestion de la touche X pour le leaderboard
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if inGunfightZone then
            if IsControlPressed(0, 73) then -- 73 est le code pour la touche X
                if not isLeaderboardVisible then
                    isLeaderboardVisible = true
                    SendNUIMessage({
                        action = "setLeaderboard",
                        opacity = 100
                    })

                end
            else
                if isLeaderboardVisible then
                    isLeaderboardVisible = false
                    SendNUIMessage({
                        action = "setLeaderboard",
                        opacity = 0
                    })
                end
            end
        else
            if isLeaderboardVisible then
                isLeaderboardVisible = false
                hideAllUI()
            end
        end
    end
end)

RegisterNUICallback('close', function()
    SetNuiFocus(false, false)
end)
