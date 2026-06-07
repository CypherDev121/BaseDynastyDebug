local reports = {}
local callid = 0

RegisterServerEvent('admin:setJob')
AddEventHandler('admin:setJob', function(player, job, grade, type)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(player)
    if xPlayer.getGroup() ~= 'user' then
        TriggerEvent('esx:sendLog', "staff", GetPlayerName(source) .. " ( "  .. source .. ' - ' .. xPlayer.getUUID() .. " )" .. " a mis job : " .. job .." grade : " .. grade .. " type : " .. type .. " " .. GetPlayerName(player) .. " ( "  .. player .. ' - ' .. xTarget.getUUID() .. " )")
        if type == 1 then
        xTarget.setJob(job, grade)
        elseif type == 2 then
        xTarget.setJob2(job, grade)
        end
    else
        print('Attempt to Admin SetJob ' .. xPlayer.getUUID())
    end
end)

RegisterServerEvent('admin:MakePlayerRegister')
AddEventHandler('admin:MakePlayerRegister', function(target)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer and xPlayer.getGroup() == "admin" then
        TriggerClientEvent("esx:MakeMeRegister", target)
    end
end)

RegisterServerEvent('admin:JailPlayer')
AddEventHandler('admin:JailPlayer', function(target, time, reason)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(target)
    if xPlayer and xTarget and xPlayer.getGroup() ~= "user" then
        if tonumber(time) > 0 then
        JailPlayer(target, "staff", time)
        TriggerClientEvent('esx:announce', target, "Jail", "Vous avez été jail par " .. GetPlayerName(source) .. " pour " .. reason, 2)
        TriggerEvent('esx:sendLog', "staff", GetPlayerName(source) .. " ( "  .. source .. ' - ' .. xPlayer.getUUID() .. " )" .. " a jail " .. GetPlayerName(target) .. " ( "  .. target .. ' - ' .. xTarget.getUUID() .. " ) pour " .. reason .. " pedant " .. time .. " minutes")
        else
            UnJailPlayer(target)
            TriggerClientEvent('esx:announce', target, "Jail", "Vous avez été unjail par " .. GetPlayerName(source), 2)
            TriggerEvent('esx:sendLog', "staff", GetPlayerName(source) .. " ( "  .. source .. ' - ' .. xPlayer.getUUID() .. " )" .. " a unjail " .. GetPlayerName(target) .. " ( "  .. target .. ' - ' .. xTarget.getUUID() .. " )")
        end
    end
end)

ESX.RegisterServerCallback('admin:GetActivePlayers', function(source, cb)
	local xPlayers	= ESX.GetPlayers()
    local players = {}

    for _,v in pairs(xPlayers) do
    local xPlayer = ESX.GetPlayerFromId(v)
    local coloraddon = ''
    if xPlayer.getGroup() == 'admin' then
        coloraddon = '~r~'
    elseif xPlayer.getGroup() == 'superadmin' then
        coloraddon = '~y~'
    elseif xPlayer.getGroup() == 'modo' then
        coloraddon = '~b~'
    end
    table.insert(players, {id = v, name = GetPlayerName(v), uuid = xPlayer.getUUID(), group = xPlayer.getGroup(), addoncolor = coloraddon})
    end

	cb(players)
end)

RegisterServerEvent('esx:adminannounce')
AddEventHandler('esx:adminannounce', function(title, msg, time)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() ~= 'user' then
    TriggerClientEvent('esx:announce', -1, title, msg, time)
    end
end)

AddEventHandler('txAdmin:events:scheduledRestart', function(eventData)
    local timeremaining = eventData.secondsRemaining / 60
    --TriggerClientEvent('esx:announce', -1, '~y~Reboot', 'reboot automatique dans ' .. ESX.Math.Round(timeremaining) .. ' minutes', 2)
    if eventData.secondsRemaining == 60 then
        print("1 minute before restart... saving all players!")
        ESX.SavePlayers(function()
        end)
    end
end)

RegisterServerEvent('admin:Service')
AddEventHandler('admin:Service', function(toggle)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() ~= 'user' then
        if toggle then
            TriggerClientEvent('esx:showNotification', source, "Vous êtes en service", "info")
        else
            TriggerClientEvent('esx:showNotification', source, "Vous n'êtes plus en service", "info")
        end
    end
end)

RegisterServerEvent('admin:TeleportPlayerToMe')
AddEventHandler('admin:TeleportPlayerToMe', function(target, coords)
    local _source = source 
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() ~= 'user' then
    TriggerClientEvent('admin:teleport', target, coords.x, coords.y, coords.z)
    end
end)

RegisterServerEvent('admin:GoToPlayer')
AddEventHandler('admin:GoToPlayer', function(target)
    local _source = source 
    local xPlayer = ESX.GetPlayerFromId(source)
    if tonumber(target) then
    local xTarget = ESX.GetPlayerFromId(tonumber(target))
    local sourceped = GetPlayerPed(_source)
    local playerped = GetPlayerPed(tonumber(target))
	local playercoords = GetEntityCoords(playerped)
    if xPlayer.getGroup() ~= 'user' then
        if xTarget then
            SetEntityCoords(sourceped, playercoords.x, playercoords.y, playercoords.z) 
            --TriggerClientEvent("admin:toggleNoclip", _source)
        end
    end
    end
end)

RegisterServerEvent('admin:SendMessageToPlayer')
AddEventHandler('admin:SendMessageToPlayer', function(target, msg)
    local _source = source 
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() ~= 'user' then
        if target then
           TriggerClientEvent('admin:receivemessage', target, msg)
        end
    end
end)

RegisterServerEvent('admin:WipeArme')
AddEventHandler('admin:WipeArme', function(target, reason)
    local _source = source 
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(target)
    if xPlayer.getGroup() ~= 'user' then
        if xTarget then
            local RemoveList = {}
            for k, v in pairs(xTarget.getLoadout()) do
                table.insert(RemoveList, v.name)
            end
            xTarget.removeWeapons(RemoveList)
            TriggerClientEvent('esx:announce', xTarget.source, '~y~Wipe', 'Vous avez été wipe arme pour ' .. reason, 2)
            TriggerEvent('esx:sendLog', "staff", GetPlayerName(xPlayer.source) .. " ( "  .. xPlayer.source .. ' - ' .. xPlayer.getUUID() .. " )" .. " a wipe arme " .. GetPlayerName(xTarget.source) .. " ( "  .. xTarget.source .. ' - ' .. xTarget.getUUID() .. " ) pour " .. reason)
        end
    end
end)


ESX.RegisterServerCallback('esx:retrievePlayers', function(playerId, cb)
    local players = {}
    local xPlayers = ESX.GetPlayers()

    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        local playercolor = 255
        if xPlayer.getGroup() == 'admin' then
            playercolor = 6
        elseif xPlayer.getGroup() == 'superadmin' then
            playercolor = 12
        elseif xPlayer.getGroup() == 'modo' then
            playercolor = 9
        else
            playercolor = 255
        end
        table.insert(players, {
            id = xPlayers[i],
            group = xPlayer.getGroup(),
            source = xPlayer.source,
            job = xPlayer.getJob().name,
            job2 = xPlayer.getJob2().name,
            name = xPlayer.getName(),
            uuid = xPlayer.getUUID(),
            color = playercolor
        })
    end

    cb(players)
end)

RegisterServerEvent('admin:sendReport')
AddEventHandler('admin:sendReport', function(reason, playername)
    local _source = source 
    local xPlayer = ESX.GetPlayerFromId(source)
    local numreport = #reports + 1
    if not reports[source] then
        local xPlayers = ESX.GetPlayers()
        for i = 1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            if xPlayer and xPlayer.getGroup() ~= "user" then
                TriggerClientEvent('admin:receiveReportNotification', xPlayers[i])
            end
        end
        reports[source] = {num = numreport, source = source, name = playername, message = reason, uuid = xPlayer.getUUID()}
    end
end)

RegisterServerEvent('admin:DeleteReport')
AddEventHandler('admin:DeleteReport', function(playerid)
    local _source = source 
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() ~= 'user' then
    local report = reports[playerid]
    if report and ESX.GetPlayerFromId(report.source) then
        ESX.GetPlayerFromId(report.source).showNotification(GetPlayerName(source) .. " ( "  .. source .. ' - ' .. xPlayer.getUUID() .. " )" .. " a fermé votre ticket !")
        TriggerEvent('esx:sendLog', "staff", GetPlayerName(source) .. " ( "  .. source .. ' - ' .. xPlayer.getUUID() .. " )" .. " a fermé le ticket de " .. GetPlayerName(report.source) .. " ( "  .. report.source .. ' - ' .. report.uuid .. " )")
    end
    reports[playerid] = nil
end
end)

RegisterServerEvent('admin:takingReport')
AddEventHandler('admin:takingReport', function(playerid)
    local _source = source 
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() ~= 'user' then
    local report = reports[playerid]
    if report and ESX.GetPlayerFromId(reports[playerid].source) then
        ESX.GetPlayerFromId(reports[playerid].source).showNotification(GetPlayerName(_source) .. " ( "  .. source .. ' - ' .. xPlayer.getUUID() .. " )" .. " s'occupe de votre ticket !")
        local name = GetPlayerName(_source)
        if not name then
            name = "nil"
        end
        TriggerEvent('esx:sendLog', "staff", name .. " ( "  .. source .. ' - ' .. xPlayer.getUUID() .. " )" .. " s'occupe du ticket de " .. GetPlayerName(report.source) .. " ( "  .. report.source .. ' - ' .. report.uuid .. " )")
    elseif report and not ESX.GetPlayerFromId(reports[playerid].source) then
        xPlayer.showNotification("Ce Joueur s'est déconnecté, ticket fermé")
        reports[playerid] = nil
    end
    end
end)

RegisterServerEvent('admin:give')
AddEventHandler('admin:give', function(type, item, amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() ~= 'user' then
        TriggerEvent('esx:sendLog', "staff", GetPlayerName(source) .. " ( "  .. source .. ' - ' .. xPlayer.getUUID() .. " )" .. " s'est give " .. amount .." " .. type .. " " .. item)
        if type == 'money' then
            if item == 'cash' then
                xPlayer.addMoney(amount)
            elseif item == 'black_money' then
                xPlayer.addAccountMoney(item, amount)
            end
        elseif type == 'item' then
            xPlayer.addInventoryItem(item, amount)
        elseif type == 'weapon' then
            xPlayer.addWeapon(item, amount)
        end
    end
end)

RegisterServerEvent('admin:kick')
AddEventHandler('admin:kick', function(target, reason)
    local _source = source 
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(target)
    if target then
        local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() ~= 'user' then
        TriggerEvent('esx:sendLog', "staff", GetPlayerName(source) .. " ( "  .. source .. ' - ' .. xPlayer.getUUID() .. " )" .. " a kick " ..  GetPlayerName(target) .. " ( "  .. target .. ' - ' .. xTarget.getUUID() .. " ) pour " .. reason)
        DropPlayer(target, reason)
    end
    end
end)

RegisterServerEvent('admin:freeze')
AddEventHandler('admin:freeze', function(target, toggle)
    local _source = source 
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() ~= 'user' then
    if target then
        TriggerClientEvent('admin:FreezePlayer', target, toggle)
    end
    end
end)

ESX.RegisterServerCallback('admin:getReports', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() ~= 'user' then
    cb(reports)
    end
end)



