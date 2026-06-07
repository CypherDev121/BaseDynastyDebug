LogsConfig = {}

local AleardyJoinedPlayer = {}

LogsConfig.username = "NyseraRP Logs"
LogsConfig.avatar = "https://media.discordapp.net/attachments/959852659395940432/978404170514178149/logodyna.png"

LogsConfig.webhooks = {
    ["joins"] = "https://discord.com/api/webhooks/961064228440137779/c3yV7naHp32HdzprTQV0KXXMq_R3w5ZUO5A45WM1iuWMLwrMelMep7tN_9zEFztk0AoE",
	["leave"] = "https://discord.com/api/webhooks/961064535035363408/V8nD9tV_Ftsz2Rqt56yBIIs7Y45A-XhXtMpBZRkLXE06d5Pn1C7DTLGr_2pDK6o91zk-",
	["deaths"] = "https://discord.com/api/webhooks/961064620192317481/J5OFxil6FarHYNFkECme6pTM3ezPZb1_ZK3EwGu8okRHS5r0U0KY-kObHC3XtIn-X3bv",
	["money"] = "https://discord.com/api/webhooks/961064687670296606/FYJ7AoqhCmF8vDIKWwHWkxYFi9UJf0o-SQ4YmmTqH4i5RRHK6Nf4kgbQ66BL6YTXLrXz",
	["billing"] = "https://discord.com/api/webhooks/961064755706093619/5CY-xJpy3Jfs16Bs7rB86cUPJA6JHxDPX6oLhjGktEdu9jSwbB5jSRL6v1gn0C_wznMY",
	["weapons"] = "https://discord.com/api/webhooks/961064826904391700/YpGeq2hl22SfACzULv0YjuCIoE71ylE2KIOnzA3_3lKdeG51KOeVUXulGF0H-0r-CvJ1",
	["staff"] = "https://discord.com/api/webhooks/961064909699964968/cbV-779u1m7lV1VwPmn0VnscATOaWxgj6iGaF1m2FBnSCMop_6E5pvwNmc4w01zXM3gd",
	["holdup"] = "https://discord.com/api/webhooks/957364719981846569/zIQ3ucsPbgPQ_-bxJa4g1MSYQ13Zw0f5aKQ30ENJXtlvS4Hgm6tTDM8B_I5aS4GzX5An",
	["store"] = "https://discord.com/api/webhooks/961065058736144396/9_FBogCCo7sG6QBLBWREprNSJ02jB4cAoehZ96fmgajaLNaCkxMp4JEJWSiClZc-WdBR",
	["anticheat"] = "https://discord.com/api/webhooks/957363953430827008/5jqqD3X_RJcFtB_GC9RKJb0NMUwuFVZ950oRV6EI2Q0Gz9NnH1rl2Jd2m_i-oOLWd0oh"
}

function discordLog(channel, message)
      PerformHttpRequest(LogsConfig.webhooks[channel], function(err, text, headers) end, 'POST', json.encode({username = LogsConfig.username, content = message, avatar_url = LogsConfig.avatar}), { ['Content-Type'] = 'application/json' })
end

RegisterNetEvent('esx:sendLog')
AddEventHandler('esx:sendLog', function(channel, message)
    discordLog(channel, message)
end)

local deadPlayers = {}

RegisterNetEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function(data)
	deadPlayers[source] = data
end)

RegisterNetEvent('esx:playerDroppedData')
AddEventHandler('esx:playerDroppedData', function(source, reason, xPlayer)
	local playerPed = ESX.PlayerData.cache.playerped

	if xPlayer.IsDead then
		if reason == 'Disconnected.' or reason == 'Exiting' then
			discordLog('leave', GetPlayerName(source) .. " ( "  .. source .. ' - ' .. xPlayer.getUUID() .. " )".. ' a quitté en étant mort.')
		else
			discordLog('leave', GetPlayerName(source) .. " ( "  .. source .. ' - ' .. xPlayer.getUUID() .. " )".. ' a crash en étant mort.')
		end
	else 
		if reason == 'Disconnected.' or reason == 'Exiting' then
			discordLog('leave', GetPlayerName(source) .. " ( "  .. source .. ' - ' .. xPlayer.getUUID() .. " )".. ' a quitté le serveur.')
		else
		    discordLog('leave', GetPlayerName(source) .. " ( "  .. source .. ' - ' .. xPlayer.getUUID() .. " )".. ' a crash.')
		end
	end 
end)

RegisterServerEvent('playerDied')
AddEventHandler('playerDied',function(id,player,killer,DeathReason, Weapon)
	local xPlayer = ESX.GetPlayerFromId(player)
	local xKiller = ESX.GetPlayerFromId(killer)
	
	if id == 1 then  -- Suicide/died
        discordLog('deaths', GetPlayerName(player) .. " ( "  .. player .. ' - ' .. xPlayer.getUUID() .. " )".. ' s\'est suicidé.')
	elseif id == 2 then -- Killed by other player
	    discordLog('deaths', GetPlayerName(player) .. " ( "  .. player .. ' - ' .. xPlayer.getUUID() .. " )".. ' s\'est fait tuer par ' .. GetPlayerName(killer) .. " ( "  .. killer .. ' - ' .. xKiller.getUUID() .. " )")
	else -- When gets killed by something else
		discordLog('deaths', GetPlayerName(player) .. " ( "  .. player .. ' - ' .. xPlayer.getUUID() .. " )".. ' est mort.')
	end
end)