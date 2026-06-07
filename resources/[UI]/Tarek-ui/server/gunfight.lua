local playersInZones = {}
local playerStats = {}
local zonePlayers = {}
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('gunfight:addReward')
AddEventHandler('gunfight:addReward', function(amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        xPlayer.addAccountMoney('money', amount)
    end
end)

local function getPlayersInBucket(bucketId)
    local players = {}
    for _, playerId in ipairs(GetPlayers()) do
        if GetPlayerRoutingBucket(tonumber(playerId)) == bucketId then
            local name = GetPlayerName(tonumber(playerId))
            if name then
                players[tonumber(playerId)] = name
            end
        end
    end
    return players
end

local function isPlayerValid(playerId)
    if not playerId then return false end
    local name = GetPlayerName(tonumber(playerId))
    return name ~= nil and name ~= ""
end

local function broadcastStats()
    local players = {}
    for id, stats in pairs(playerStats) do
        if playersInZones[id] then
            players[id] = {
                name = stats.name,
                kills = stats.kills,
                deaths = stats.deaths
            }
        end
    end
    TriggerClientEvent('gunfight:refreshPlayers', -1, players)
end

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    
    for _, playerId in ipairs(GetPlayers()) do
        SetPlayerRoutingBucket(tonumber(playerId), 0)
    end
    playersInZones = {}
    playerStats = {}
    zonePlayers = {}
end)

AddEventHandler('playerJoining', function()
    local source = source
    SetPlayerRoutingBucket(source, 0)
end)

RegisterNetEvent('gunfight:requestBucket')
AddEventHandler('gunfight:requestBucket', function(bucket, zone)
    local source = source
    
    if playersInZones[source] then
        local oldZone = playersInZones[source]
        playersInZones[source] = nil
        
        local oldCount = getPlayersCountInZone(oldZone)
        TriggerClientEvent('gunfight:updateZonePlayers', -1, oldZone, oldCount)
    end
    
    SetPlayerRoutingBucket(source, bucket)
    
    if bucket > 0 and zone then
        playersInZones[source] = zone
        playerStats[source] = {
            name = GetPlayerName(source),
            kills = 0,
            deaths = 0
        }
        
        local newCount = getPlayersCountInZone(zone)
        TriggerClientEvent('gunfight:updateZonePlayers', -1, zone, newCount)
        
        TriggerClientEvent('gunfight:setBucket', source, bucket, zone)
        
        local zoneStats = {}
        for player, playerZone in pairs(playersInZones) do
            if playerZone == zone and playerStats[player] then
                zoneStats[player] = playerStats[player]
            end
        end
        TriggerClientEvent('gunfight:refreshPlayers', -1, zoneStats)
    end
end)

function getPlayersCountInZone(zone)
    local count = 0
    for _, playerZone in pairs(playersInZones) do
        if playerZone == zone then
            count = count + 1
        end
    end
    return count
end

function sendPlayersCountPerZone()
    local playersCountPerZone = {}
    for zone, _ in pairs(playersInZones) do
        local count = getPlayersCountInZone(zone)
        playersCountPerZone[zone] = count
    end
    TriggerClientEvent('gunfight:updatePlayersCountPerZone', -1, playersCountPerZone)
end

RegisterNetEvent('gunfight:getPlayersInZone')
AddEventHandler('gunfight:getPlayersInZone', function(zone)
    local source = source
    local count = 0
    for _, playerZone in pairs(playersInZones) do
        if playerZone == zone then
            count = count + 1
        end
    end
    TriggerClientEvent('gunfight:updateZonePlayers', source, zone, count)
end)

RegisterNetEvent('gunfight:playerKilled')
AddEventHandler('gunfight:playerKilled', function(killerId, victimId, weapon)
    if not playersInZones[killerId] or not playersInZones[victimId] then return end
    if playersInZones[killerId] ~= playersInZones[victimId] then return end
    
    if not playerStats[killerId] then
        playerStats[killerId] = {
            name = GetPlayerName(killerId),
            kills = 1,
            deaths = 0
        }
    else
        playerStats[killerId].kills = playerStats[killerId].kills + 1
    end
    
    if not playerStats[victimId] then
        playerStats[victimId] = {
            name = GetPlayerName(victimId),
            kills = 0,
            deaths = 1
        }
    else
        playerStats[victimId].deaths = playerStats[victimId].deaths + 1
    end
    
    local zone = playersInZones[killerId]
    for player, playerZone in pairs(playersInZones) do
        if playerZone == zone then
            TriggerClientEvent('gunfight:onPlayerKilled', player, killerId, victimId, weapon)
        end
    end
end)

RegisterNetEvent('gunfight:getPlayersInZone')
AddEventHandler('gunfight:getPlayersInZone', function(zone)
    local source = source
    TriggerClientEvent('gunfight:updateZonePlayers', source, zone, getPlayersCountInZone(zone))
end)

RegisterNetEvent('gunfight:playerLeftZone')
AddEventHandler('gunfight:playerLeftZone', function(playerId, zone)
    local source = source
    
    if source ~= playerId then return end
    
    if playersInZones[source] then
        playersInZones[source] = nil
        playerStats[source] = nil
        
        local count = getPlayersCountInZone(zone)
        TriggerClientEvent('gunfight:updateZonePlayers', -1, zone, count)
        
        local zoneStats = {}
        for player, playerZone in pairs(playersInZones) do
            if playerZone == zone and playerStats[player] then
                zoneStats[player] = playerStats[player]
            end
        end
        TriggerClientEvent('gunfight:refreshPlayers', -1, zoneStats)
    end
end)

AddEventHandler('playerDropped', function()
    local source = source
    if playersInZones[source] then
        local zone = playersInZones[source]
        playersInZones[source] = nil
        playerStats[source] = nil
        
        local count = getPlayersCountInZone(zone)
        TriggerClientEvent('gunfight:updateZonePlayers', -1, zone, count)
        
        local zoneStats = {}
        for player, playerZone in pairs(playersInZones) do
            if playerZone == zone and playerStats[player] then
                zoneStats[player] = playerStats[player]
            end
        end
        TriggerClientEvent('gunfight:refreshPlayers', -1, zoneStats)
    end
end)

RegisterServerEvent('gunfight:playerJoinedZone')
AddEventHandler('gunfight:playerJoinedZone', function(playerId)
    TriggerClientEvent('gunfight:playerJoined', -1, playerId)
end)

RegisterServerEvent('gunfight:playerLeftZone')
AddEventHandler('gunfight:playerLeftZone', function(playerId)
    TriggerClientEvent('gunfight:playerLeft', -1, playerId)
end)