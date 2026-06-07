ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) 
    ESX = obj 
end)

local function GetMoneyLeaderboard()
    local players = {}
    local xPlayers = ESX.GetPlayers()
    local playerList = {}
    
  
    for i=1, #xPlayers do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer then
            local totalMoney = xPlayer.getMoney() + xPlayer.getAccount('bank').money + xPlayer.getAccount('black_money').money
            
          
            local result = MySQL.Sync.fetchAll("SELECT identity, accounts, job, job2 FROM users WHERE identifier = @identifier", {
                ['@identifier'] = xPlayer.identifier
            })
            
            if result[1] then
                local identity = json.decode(result[1].identity)
                local firstName = identity and identity.firstName or "Tarek"
                local lastName = identity and identity.lastName or "Dev"
                local accounts = json.decode(result[1].accounts)
                local money = accounts.money or 0
                local bankMoney = accounts.bank or 0
                local blackMoney = accounts.black_money or 0
                
                local totalMoney = money + bankMoney + blackMoney
            
                local playerData = {
                    name = firstName .. " " .. lastName,
                    firstName = firstName,
                    lastName = lastName,
                    money = totalMoney,
                    scorea = totalMoney,
                    gfKD = 0,
                    gameTime = 0
                }
                table.insert(playerList, playerData)
            end
            
        end
    end

    table.sort(playerList, function(a, b)
        return a.money > b.money
    end)
    

    for i, player in ipairs(playerList) do
        player.positions = {
            money = i,
            scorea = i
        }
    end
    
    return playerList
end

RegisterServerEvent("tarek_menu:getPlayerData")
AddEventHandler("tarek_menu:getPlayerData", function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    
    if xPlayer then
        local result = MySQL.Sync.fetchAll("SELECT identity, accounts, time, job, job2 FROM users WHERE identifier = @identifier", {
            ['@identifier'] = xPlayer.identifier
        })
        
        local firstName = "Tarek"
        local lastName = "Dev"
        local gameTime = 0

        if result[1] then
            local identity = json.decode(result[1].identity)
            if identity then
                firstName = identity.firstName or "Tarek"
                lastName = identity.lastName or "Dev"
            end
            gameTime = result[1].time or 0
        end
        
        local leaderboardPlayers = GetMoneyLeaderboard()
        local playerPosition = 1
        local totalMoney = xPlayer.getMoney() + xPlayer.getAccount('bank').money + xPlayer.getAccount('black_money').money
        
        for i, player in ipairs(leaderboardPlayers) do
            if player.firstName == firstName and player.lastName == lastName then
                playerPosition = i
                break
            end
        end
        
        local playerData = {
            firstName = firstName,
            lastName = lastName,
            identifier = xPlayer.identifier,
            uuid = xPlayer.getUUID(),
            gameTime = gameTime,
            job = xPlayer.job,
            job2 = xPlayer.job2,
            money = xPlayer.getMoney(),
            bank = xPlayer.getAccount('bank').money,
            black_money = xPlayer.getAccount('black_money').money,
            leaderboard = {
                search = "",
                filter = {
                    name = "money",
                    state = "decreasing"
                },
                playersList = {
                    money = {
                        decreasing = leaderboardPlayers
                    }
                },
                itemsList = {
                    {
                        label = "Prénom/Nom",
                        key = "name",
                        enabled = true,
                        filtering = "decreasing"
                    },
                    {
                        label = "Argent Total",
                        key = "money",
                        enabled = true,
                        filtering = "decreasing"
                    }
                },
                myInfo = {
                    position = playerPosition,
                    firstName = firstName,
                    lastName = lastName,
                    money = totalMoney,
                    scorea = totalMoney,
                    gfKD = 0,
                    gameTime = gameTime,
                    positions = {
                        money = playerPosition,
                        scorea = playerPosition
                    }
                }
            }
        }
        TriggerClientEvent("tarek_menu:receivePlayerData", _source, playerData)
    end
end)
