local inGunfightZone, isRespawning, isInvincible = false, false, false
local playerStats, myRank, totalPlayers = {}, 1, 0
local zoneBlip, zoneLabel, currentZone, zoneTimer = nil, nil, nil, nil
local lastHit = 0
local killStreak = 0
local zonePlayers = {}
local pendingZoneUpdates = {}
local menuData = nil

local lastWeaponMessage = 0

ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

local function ShowDamageNumber(entity, damage, isHeadshot)
    if not DoesEntityExist(entity) or not Config.Settings.hitmarker.enabled then return end
    
    if Config.Settings.hitmarker.sound then
        local hitConfig = isHeadshot and Config.Settings.hitmarker.headshot or Config.Settings.hitmarker.normal
        PlaySoundFrontend(-1, hitConfig.sound, hitConfig.soundSet, 1)
    end
    
    local coords = GetEntityCoords(entity)
    local drawState = true
    local alpha = 255
    local offset = 0.0
    
    Citizen.CreateThread(function()
        Citizen.Wait(Config.Settings.hitmarker.displayTime)
        drawState = false
    end)
    
    Citizen.CreateThread(function()
        while drawState do
            Citizen.Wait(0)
            offset = offset + 0.001
            alpha = alpha - Config.Settings.hitmarker.fadeSpeed
            
            if alpha <= 0 then
                drawState = false
                break
            end
            
            local pos = vector3(coords.x, coords.y, coords.z + 1.5 + offset)
            local onScreen, x, y = World3dToScreen2d(pos.x, pos.y, pos.z)
            
            if onScreen then
                local hitConfig = isHeadshot and Config.Settings.hitmarker.headshot or Config.Settings.hitmarker.normal
                SetTextScale(hitConfig.scale, hitConfig.scale)
                SetTextColour(hitConfig.color[1], hitConfig.color[2], hitConfig.color[3], alpha)
                BeginTextCommandDisplayText("STRING")
                AddTextComponentSubstringPlayerName(damage)
                SetTextFont(4)
                SetTextDropshadow(0, 0, 0, 0, alpha)
                SetTextEdge(1, 0, 0, 0, alpha)
                SetTextDropShadow()
                SetTextOutline()
                SetTextCentre(true)
                EndTextCommandDisplayText(x, y)
            end
        end
    end)
end

AddEventHandler('gameEventTriggered', function(name, args)
    if name ~= "CEventNetworkEntityDamage" then return end
    if not inGunfightZone then return end
    
    local victim = args[1]
    local attacker = args[2]
    local damage = args[5]
    local isFatal = args[6]
    
    if attacker ~= PlayerPedId() or not IsPedAPlayer(victim) then return end
    
    local isHeadshot = false
    local _, bone = GetPedLastDamageBone(victim)
    if bone == 31086 then
        isHeadshot = true
    end
    
    local victimMaxHealth = GetEntityMaxHealth(victim)
    local victimCurrentHealth = GetEntityHealth(victim)
    local previousHealth = victimCurrentHealth + damage
    
    local damagePercent = math.floor((damage / victimMaxHealth) * 100)
    
    if isFatal then
        damagePercent = math.floor((previousHealth / victimMaxHealth) * 100)
    end
    
    if damagePercent > 0 then
        ShowDamageNumber(victim, damagePercent, isHeadshot)
    end
end)

AddEventHandler('CEventNetworkEntityDamage', function(target, attacker, damage)
    if not inGunfightZone then return end
    if not DoesEntityExist(target) or not DoesEntityExist(attacker) then return end
    
    if attacker == PlayerPedId() and IsPedAPlayer(target) then
        local targetId = NetworkGetPlayerIndexFromPed(target)
        local targetHealth = GetEntityHealth(target)
        local isLastHit = targetHealth <= 0
        local actualDamage = math.floor(damage)
        
        if actualDamage > 0 then
            local targetCoords = GetEntityCoords(target)
            TriggerEvent('gunfight:damageDealt', GetPlayerServerId(targetId), targetCoords, actualDamage, isLastHit)
        end
    end
end)

local function updateLeaderboardUI()
    if not inGunfightZone then return end
    
    local leaderboard = {}
    for id, data in pairs(playerStats) do
        table.insert(leaderboard, {
            name = data.name, kills = data.kills, deaths = data.deaths,
            kd = data.kills / math.max(1, data.deaths)
        })
    end
    
    table.sort(leaderboard, function(a, b)
        return a.kills == b.kills and a.deaths < b.deaths or a.kills > b.kills
    end)
    
    local myName = GetPlayerName(PlayerId())
    for i, data in ipairs(leaderboard) do
        data.rank = i
        if data.name == myName then myRank = i end
    end
    
    if #leaderboard > 0 then
        exports['gunfightui']:updateLeaderboard(leaderboard)
        exports['gunfightui']:updateRank(myRank, #leaderboard)
        totalPlayers = #leaderboard
    else
        exports['gunfightui']:updateLeaderboard({})
        exports['gunfightui']:updateRank(1, 0)
        totalPlayers = 0
    end
end

local function startRespawnTimer()
    if isRespawning then return end
    isRespawning = true
    
    local zoneConfig = Config.Zones[currentZone]
    local respawnTime = zoneConfig.respawnTime or Config.Settings.defaultRespawnTime
    local currentTime = string.format("%02d:%02d", GetClockHours(), GetClockMinutes())
    SetNuiFocus(true, true)
    
    SendNUIMessage({
        module = "deathscreen",
        show = true,
        timeRemaining = string.format("00:%02d", respawnTime),
        deathInformations = {reason = Config.Messages.deathMessage, time = currentTime},
        personalInformations = {name = GetPlayerName(PlayerId())},
        canRevive = false,
        respawnAccepted = true
    })
    
    Citizen.CreateThread(function()
        local timeLeft = respawnTime
        while timeLeft > 0 and isRespawning do
            Citizen.Wait(1000)
            timeLeft = timeLeft - 1
            
            if timeLeft > 0 then
                SendNUIMessage({
                    module = "deathscreen",
                    show = true,
                    timeRemaining = string.format("00:%02d", timeLeft),
                    deathInformations = {reason = Config.Messages.deathMessage, time = currentTime},
                    personalInformations = {name = GetPlayerName(PlayerId())},
                    canRevive = false,
                    respawnAccepted = true
                })
            else
                SendNUIMessage({module = "deathscreen", show = false, action = "hide"})
                SetNuiFocus(false, false)
            end
        end
    end)
    
    local playerId = GetPlayerServerId(PlayerId())
    if playerStats[playerId] then
        playerStats[playerId].deaths = (playerStats[playerId].deaths or 0) + 1
        playerStats[playerId].kd = math.floor((playerStats[playerId].kills / math.max(1, playerStats[playerId].deaths)) * 100) / 100
        updateLeaderboardUI()
    end
    
    killStreak = 0
    
    Citizen.SetTimeout(respawnTime * 1000, function()
        if not inGunfightZone then return end
        
        local ped = PlayerPedId()
        if DoesEntityExist(ped) then
            local zoneConfig = Config.Zones[currentZone]
            local spawnPoint = zoneConfig.spawns[math.random(#zoneConfig.spawns)]
            
            NetworkResurrectLocalPlayer(spawnPoint.x, spawnPoint.y, spawnPoint.z, 0.0, true, false)
            SetEntityCoords(ped, spawnPoint.x, spawnPoint.y, spawnPoint.z, false, false, false, true)
            SetEntityHealth(ped, GetEntityMaxHealth(ped))
            ESX.ShowNotification(Config.Messages.respawnMessage)
            ClearPedBloodDamage(ped)
            
            local invincibilityTime = zoneConfig.invincibilityTime or Config.Settings.defaultInvincibilityTime
            isInvincible = true
            SetEntityInvincible(ped, true)
            SetEntityAlpha(ped, 128, false)
            NetworkSetEntityInvisibleToNetwork(ped, true)
            DisablePlayerFiring(PlayerId(), true)
            
            Citizen.SetTimeout(invincibilityTime * 1000, function()
                if not inGunfightZone then return end
                isInvincible = false
                SetEntityInvincible(ped, false)
                SetEntityAlpha(ped, 255, false)
                NetworkSetEntityInvisibleToNetwork(ped, false)
                DisablePlayerFiring(PlayerId(), false)
            end)
        end
        
        isRespawning = false
    end)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local ped = PlayerPedId()
        if inGunfightZone and DoesEntityExist(ped) then
            if Config.Zones[currentZone].weaponRestriction == "pistol" then
                local currentWeapon = GetSelectedPedWeapon(ped)
                local isAllowed = false
                for _, weapon in ipairs(Config.Zones[currentZone].allowedWeapons) do
                    if GetHashKey(weapon) == currentWeapon then
                        isAllowed = true
                        break
                    end
                end
                if not isAllowed then
                    DisablePlayerFiring(PlayerId(), true)
                    if GetGameTimer() - lastWeaponMessage > 3000 then
                        exports['gunfightui']:showNotification("leave", "ARMES", "Cette arme n'est pas autorisée dans cette zone")
                        lastWeaponMessage = GetGameTimer()
                    end
                end
            end
            
            if IsEntityDead(ped) and not isRespawning and (GetGameTimer() - lastHit) > 5000 then
                lastHit = GetGameTimer()
                
                local killer = GetPedSourceOfDeath(ped)
                if killer ~= 0 and GetEntityType(killer) == 1 then
                    local killerPlayer = NetworkGetPlayerIndexFromPed(killer)
                    if killerPlayer ~= -1 then
                        TriggerServerEvent('gunfight:playerKilled', 
                            GetPlayerServerId(killerPlayer),
                            GetPlayerServerId(PlayerId()),
                            GetSelectedPedWeapon(killer)
                        )
                    end
                end
                
                startRespawnTimer()
            end
            
            if isInvincible then
                DisablePlayerFiring(PlayerId(), true)
            end
            
            local zoneConfig = Config.Zones[currentZone]
            if zoneConfig then
                DrawMarker(1, zoneConfig.center.x, zoneConfig.center.y, zoneConfig.center.z - 1.0,
                    0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
                    zoneConfig.radius * 2.0, zoneConfig.radius * 2.0, 100.0,
                    255, 0, 0, 50, false, false, 2, false, nil, nil, false)
                
                local dist = #(GetEntityCoords(ped) - zoneConfig.center)
                if dist > zoneConfig.radius then
                    if not zoneTimer then
                        zoneTimer = Config.Settings.exitWarningTime or 5
                        
                        Citizen.CreateThread(function()
                            while zoneTimer and zoneTimer > 0 and inGunfightZone do
                                exports['gunfightui']:showNotification("leave", "ATTENTION", string.format(Config.Messages.leaveZoneWarning, zoneTimer))
                                Citizen.Wait(1000)
                                if zoneTimer then
                                    zoneTimer = zoneTimer - 1
                                end
                                
                                local newDist = #(GetEntityCoords(PlayerPedId()) - zoneConfig.center)
                                if newDist <= zoneConfig.radius then
                                    zoneTimer = nil
                                    return
                                end
                            end
                            
                            if zoneTimer and zoneTimer == 0 and inGunfightZone then
                                QuitGunfightZone()
                            end
                        end)
                    end
                else
                    zoneTimer = nil
                end
            end
        end
    end
end)



RegisterNetEvent('gunfight:setBucket')
AddEventHandler('gunfight:setBucket', function(bucket, zone)
    if bucket > 1 and Config.Zones[zone] then
        inGunfightZone = true
        currentZone = zone
        exports['gunfightui']:setInGunfightZone(true)
        exports['gunfightui']:showNotification("enter", "ZONE GUNFIGHT", Config.Messages.enterZone)
        
        local playerId = GetPlayerServerId(PlayerId())
        playerStats[playerId] = {name = GetPlayerName(PlayerId()), kills = 0, deaths = 0, kd = 0, points = 0}
    end
end)

RegisterNetEvent('gunfight:refreshPlayers')
AddEventHandler('gunfight:refreshPlayers', function(players)
    if not inGunfightZone then return end
    
    playerStats = {}
    
    for id, data in pairs(players) do
        if data and type(data) == "table" and data.name then
            playerStats[tonumber(id)] = {
                name = data.name,
                kills = tonumber(data.kills) or 0,
                deaths = tonumber(data.deaths) or 0,
                kd = math.floor((data.kills / math.max(1, data.deaths)) * 100) / 100,
                points = tonumber(data.points) or 0
            }
        end
    end
    
    updateLeaderboardUI()
end)

RegisterNetEvent('gunfight:onPlayerKilled')
AddEventHandler('gunfight:onPlayerKilled', function(killerId, victimId, weapon)
    if not inGunfightZone then return end
    
    if killerId == GetPlayerServerId(PlayerId()) then
        killStreak = killStreak + 1
        
        local points = Config.Rewards.kill
        if Config.Rewards.streak[killStreak] then
            points = points + Config.Rewards.streak[killStreak]
        end
        
        if IsEntityDead(GetPlayerPed(GetPlayerFromServerId(victimId))) and 
           GetPedLastDamageBone(GetPlayerPed(GetPlayerFromServerId(victimId))) == 31086 then
            points = points + Config.Rewards.headshot
        end
        
        if playerStats[killerId] then
            playerStats[killerId].points = (playerStats[killerId].points or 0) + points
        end
        
        TriggerServerEvent('gunfight:addReward', Config.Rewards.Reward)
        
        ESX.ShowNotification(string.format(Config.Messages.moneyReward, ESX.Math.GroupDigits(Config.Rewards.Reward)))
        
        PlaySoundFrontend(-1, "TextHit", "WastedSounds", 1)
    end
    
    if victimId == GetPlayerServerId(PlayerId()) then
        killStreak = 0
    end
    
    if not playerStats[killerId] then
        playerStats[killerId] = {
            name = GetPlayerName(GetPlayerFromServerId(killerId)),
            kills = 1, deaths = 0, kd = 1.0
        }
    else
        playerStats[killerId].kills = playerStats[killerId].kills + 1
        playerStats[killerId].kd = math.floor((playerStats[killerId].kills / math.max(1, playerStats[killerId].deaths)) * 100) / 100
    end
    
    if not playerStats[victimId] then
        playerStats[victimId] = {
            name = GetPlayerName(GetPlayerFromServerId(victimId)),
            kills = 0, deaths = 1, kd = 0.0
        }
    else
        playerStats[victimId].deaths = playerStats[victimId].deaths + 1
        playerStats[victimId].kd = math.floor((playerStats[victimId].kills / math.max(1, playerStats[victimId].deaths)) * 100) / 100
    end
    
    updateLeaderboardUI()
    exports['gunfightui']:addKill(playerStats[killerId].name, weapon, playerStats[victimId].name)
end)

function QuitGunfightZone()
    if not inGunfightZone then return end
    
    local playerId = GetPlayerServerId(PlayerId())
    local previousZone = currentZone
    
    inGunfightZone = false
    local zoneConfig = Config.Zones[previousZone]
    
    TriggerServerEvent('gunfight:playerLeftZone', playerId, previousZone)
    
    exports['gunfightui']:setInGunfightZone(false)
    exports['gunfightui']:showNotification("leave", "ZONE GUNFIGHT", Config.Messages.exitZone)
    
    playerStats, myRank, totalPlayers = {}, 1, 0
    killStreak = 0
    currentZone = nil
    
    if DoesBlipExist(zoneBlip) then RemoveBlip(zoneBlip) end
    if DoesBlipExist(zoneLabel) then RemoveBlip(zoneLabel) end
    
    local ped = PlayerPedId()
    if DoesEntityExist(ped) then
        local zoneConfig = Config.Zones[previousZone]
        local spawnPoint = zoneConfig.exitCoords
        
        SetEntityCoords(ped, spawnPoint.x, spawnPoint.y, spawnPoint.z, false, false, false, true)
        SetEntityHealth(ped, GetEntityMaxHealth(ped))
        SetEntityInvincible(ped, false)
        SetEntityAlpha(ped, 255, false)
        NetworkSetEntityInvisibleToNetwork(ped, false)
        DisablePlayerFiring(PlayerId(), false)
        SetCanAttackFriendly(ped, true, true)
    end
    
    TriggerServerEvent('gunfight:requestBucket', 0)
end

RegisterNetEvent('gunfight:updateZonePlayers')
AddEventHandler('gunfight:updateZonePlayers', function(zone, count)
    zonePlayers[zone] = count
    pendingZoneUpdates[zone] = nil
    
    local allReceived = true
    for zone, _ in pairs(pendingZoneUpdates) do
        if pendingZoneUpdates[zone] then
            allReceived = false
            break
        end
    end
    
    if allReceived and menuData then
        for i, zoneInfo in ipairs(menuData) do
            zoneInfo.players = zonePlayers[zoneInfo.key] or 0
        end
        
        SetNuiFocus(true, true)
        SendNUIMessage({
            type = "gunfightselector",
            module = "gunfightselector",
            zoneData = menuData,
            action = "show"
        })
        
        menuData = nil
    else
        SendNUIMessage({
            type = "gunfightselector",
            module = "gunfightselector",
            updatePlayers = {
                zone = zone,
                players = count
            }
        })
    end
end)

RegisterCommand('gunfight', function()
    if DoesEntityExist(PlayerPedId()) and not inGunfightZone then
        zonePlayers = {}
        pendingZoneUpdates = {}
        local zoneData = {}
        
        for key, zone in pairs(Config.Zones) do
            pendingZoneUpdates[key] = true
            TriggerServerEvent('gunfight:getPlayersInZone', key)
            table.insert(zoneData, {
                name = zone.name,
                key = key,
                players = 0,
                image = zone.image,
                weaponRestriction = zone.weaponRestriction
            })
        end
        menuData = zoneData
    else
        BeginTextCommandThefeedPost("STRING")
        AddTextComponentSubstringPlayerName(Config.Messages.alreadyInZone)
        EndTextCommandThefeedPostTicker(true, false)
    end
end)

RegisterCommand('pvpquit', function()
    if inGunfightZone then QuitGunfightZone() end
end)

RegisterNUICallback('gunfightselector-teleport', function(data, cb)
    if not inGunfightZone and Config.Zones[data.zone] then
        local ped = PlayerPedId()
        if not DoesEntityExist(ped) then cb('error') return end
        
        local zoneConfig = Config.Zones[data.zone]
        local spawnPoint = zoneConfig.spawns[math.random(#zoneConfig.spawns)]
        
        if DoesBlipExist(zoneBlip) then RemoveBlip(zoneBlip) end
        zoneBlip = AddBlipForRadius(zoneConfig.center.x, zoneConfig.center.y, zoneConfig.center.z, zoneConfig.radius)
        SetBlipColour(zoneBlip, zoneConfig.blipSettings and zoneConfig.blipSettings.color or 1)
        SetBlipAlpha(zoneBlip, 128)
        
        if DoesBlipExist(zoneLabel) then RemoveBlip(zoneLabel) end
        zoneLabel = AddBlipForCoord(zoneConfig.center.x, zoneConfig.center.y, zoneConfig.center.z)
        SetBlipSprite(zoneLabel, zoneConfig.blipSettings and zoneConfig.blipSettings.sprite or 110)
        SetBlipDisplay(zoneLabel, 4)
        SetBlipScale(zoneLabel, zoneConfig.blipSettings and zoneConfig.blipSettings.scale or 1.0)
        SetBlipColour(zoneLabel, zoneConfig.blipSettings and zoneConfig.blipSettings.color or 1)
        SetBlipAsShortRange(zoneLabel, zoneConfig.blipSettings and zoneConfig.blipSettings.shortRange or true)
        
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(zoneConfig.name)
        EndTextCommandSetBlipName(zoneLabel)
        
        SetEntityCoords(ped, spawnPoint.x, spawnPoint.y, spawnPoint.z, false, false, false, true)
        SetEntityHealth(ped, GetEntityMaxHealth(ped))
        
        inGunfightZone = true
        currentZone = data.zone
        lastHit = GetGameTimer()
        
        SetNuiFocus(false, false)
        SendNUIMessage({type = "gunfightselector", module = "gunfightselector", action = "hide"})
        
        TriggerServerEvent('gunfight:requestBucket', 2, data.zone)
    end
    cb('ok')
end)

print("Gunfight script loaded.")