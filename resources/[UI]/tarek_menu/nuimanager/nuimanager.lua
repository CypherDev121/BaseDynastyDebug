local NUIFocus = false

RegisterNetEvent("tarek_menu:SendNUIMessage")
AddEventHandler("tarek_menu:SendNUIMessage", function(message)
    SendNUIMessage(message)
end)

RegisterNetEvent("tarek_menu:RegisterNUICallback")
AddEventHandler("tarek_menu:RegisterNUICallback", function(name, func)
    RegisterNUICallback(name, func)
end)

RegisterNetEvent("tarek_menu:setNUIFocus")
AddEventHandler("tarek_menu:setNUIFocus", function(toggle)
    NUIFocus = toggle
    SetNuiFocus(toggle, toggle)
end)

Citizen.CreateThread(function()
    TriggerEvent("tarek_menu:RegisterNUICallback", "close", function()
        TriggerEvent("tarek_menu:setNUIFocus", false)
        TriggerEvent("tarek_menu:SendNUIMessage", {
            show = false
        })    
    end)
end)

RegisterKeyMapping('Tarekmenu', 'Ouvrir le menu', 'keyboard', 'F4')

RegisterCommand('Tarekmenu', function()
    TriggerServerEvent("tarek_menu:getPlayerData")
end)


RegisterNetEvent("tarek_menu:receivePlayerData")
AddEventHandler("tarek_menu:receivePlayerData", function(serverData)
    local playerPed = PlayerPedId()
    local playerId = PlayerId()

    local uuid = serverData.uuid or "Unknown"

    local message = {
        show = true,
        playerData = {
            firstName = serverData.firstName or "Tarek",
            lastName = serverData.lastName or "FiveM",
            uuid = uuid,
            gameTime = serverData.gameTime or 0,
            jobName = (serverData.job and serverData.job.label) or "Unemployed",
            jobGrade = (serverData.job and serverData.job.grade_label) or "",
            job2Name = (serverData.job2 and serverData.job2.label) or "Unemployed",
            job2Grade = (serverData.job2 and serverData.job2.grade_label) or "",
            accounts = {
                money = serverData.money or 0,
                bank = serverData.bank or 0,
                black_money = serverData.black_money or 0
            }
        }
    }

    if serverData.leaderboard then
        message.leaderboard = {
            search = "",
            filter = {
                name = "money",
                state = "decreasing"
            },
            itemsList = serverData.leaderboard.itemsList,
            playersList = {
                money = {
                    decreasing = serverData.leaderboard.playersList.money.decreasing
                }
            },
            myInfo = serverData.leaderboard.myInfo
        }
    end

    TriggerEvent("tarek_menu:SendNUIMessage", message)
    TriggerEvent("tarek_menu:setNUIFocus", true)
end)

