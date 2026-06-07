local NUIFocus = false

RegisterNetEvent("cypherdev_menu:SendNUIMessage")
AddEventHandler("cypherdev_menu:SendNUIMessage", function(message)
    SendNUIMessage(message)
end)

RegisterNetEvent("cypherdev_menu:RegisterNUICallback")
AddEventHandler("cypherdev_menu:RegisterNUICallback", function(name, func)
    RegisterNUICallback(name, func)
end)

RegisterNetEvent("cypherdev_menu:setNUIFocus")
AddEventHandler("cypherdev_menu:setNUIFocus", function(toggle)
    NUIFocus = toggle
    SetNuiFocus(toggle, toggle)
end)

Citizen.CreateThread(function()
    TriggerEvent("cypherdev_menu:RegisterNUICallback", "close", function()
        TriggerEvent("cypherdev_menu:setNUIFocus", false)
        TriggerEvent("cypherdev_menu:SendNUIMessage", {
            show = false
        })    
    end)
end)

RegisterKeyMapping('Cyphermenu', 'Ouvrir le menu', 'keyboard', 'F4')

RegisterCommand('Cyphermenu', function()
    TriggerServerEvent("cypherdev_menu:getPlayerData")
end)


RegisterNetEvent("cypherdev_menu:receivePlayerData")
AddEventHandler("cypherdev_menu:receivePlayerData", function(serverData)
    local playerPed = PlayerPedId()
    local playerId = PlayerId()

    local uuid = serverData.uuid or "Unknown"

    local message = {
        show = true,
        playerData = {
            firstName = serverData.firstName or "Cypher",
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

    TriggerEvent("cypherdev_menu:SendNUIMessage", message)
    TriggerEvent("cypherdev_menu:setNUIFocus", true)
end)

