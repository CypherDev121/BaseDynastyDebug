local AFKPlayers = {}
local AFKZone = vector3(-1809.89, 5511.23, 11.24)

ESX.StartPayCheck = function()
	function payCheck()
		local xPlayers = ESX.GetPlayers()

		for i=1, #xPlayers, 1 do
			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
			local job     = xPlayer.job.grade_name
			local salary  = 100

			if xPlayer.getRank() == 'vip' then
				salary = math.floor(salary * 1.5)
				xPlayer.showNotification('Votre salaire a été multiplié grâce à votre grade ' .. string.lower(xPlayer.getRank()))
			elseif xPlayer.getRank() == 'diamond' then
				salary = math.floor(salary * 2)
				xPlayer.showNotification('Votre salaire a été multiplié grâce à votre grade ' .. string.lower(xPlayer.getRank()))	
			end

			if salary > 0 then
				xPlayer.addAccountMoney('bank', salary)
				TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, "banque", "paiement reçu", "Vous avez reçu une aide de l'état de : ~g~$" .. salary, 'CHAR_BANK_MAZE', 9)
			end

		end

		SetTimeout(Config.PaycheckInterval, payCheck)
	end

	SetTimeout(Config.PaycheckInterval, payCheck)
end

ESX.StartAFKCheck = function()
	function afkCheck()
		for k, v in pairs(AFKPlayers) do
			local xPlayer = ESX.GetPlayerFromId(k)
			if xPlayer then
				if xPlayer.afk.enable then
					local PlayerPed = GetPlayerPed(xPlayer.source)
                    local playerCoords = GetEntityCoords(PlayerPed)
					if DoesEntityExist(PlayerPed) and #(playerCoords - AFKZone) > 10 then
						SetEntityCoords(PlayerPed, AFKZone.x, AFKZone.y, AFKZone.z)
					end
			        AFKPlayers[k] = v + 1
				    xPlayer.setAFK(xPlayer.afk.enable, AFKPlayers[k])
				else
					ESX.RemoveAFKPlayer(xPlayer.source)
				end
		    else
				AFKPlayers[k] = nil
		    end
		end
		SetTimeout(60 * 1000, afkCheck)
	end

	SetTimeout(60 * 1000, afkCheck)
end

ESX.AddAFKPlayer = function(source)
	if not AFKPlayers[source] then
		local xPlayer = ESX.GetPlayerFromId(source)
		if xPlayer then
            AFKPlayers[source] = 0
			xPlayer.setAFK(true, 0)
		end
	end
end

RegisterServerEvent("esx:ToggleAFK")
AddEventHandler("esx:ToggleAFK", function()
	if not AFKPlayers[source] then
		ESX.AddAFKPlayer(source)
	else
		ESX.RemoveAFKPlayer(source)
	end
end)

ESX.RemoveAFKPlayer = function(source)
	if AFKPlayers[source] then
		AFKPlayers[source] = nil
		local xPlayer = ESX.GetPlayerFromId(source)
		if xPlayer then
			xPlayer.setAFK(false, 0)
		end
	end
end

ESX.StartAFKReward = function()
	function afkReward()
		for k, v in pairs(AFKPlayers) do
			if v >= 10 then
				local xPlayer = ESX.GetPlayerFromId(k)
				if xPlayer then
					local reward  = 1000

					if xPlayer.getRank() == 'vip' then
						reward = 1500
						xPlayer.showNotification('Votre reward afk a été multiplié grâce à votre grade ' .. string.lower(xPlayer.getRank()))
					elseif xPlayer.getRank() == 'diamond' then
						reward = 2500
						xPlayer.showNotification('Votre reward afk a été multiplié grâce à votre grade ' .. string.lower(xPlayer.getRank()))	
					end

					xPlayer.addMoney(reward)
				    xPlayer.showNotification('Votre reward afk s\'élève à ~g~' .. reward .. '$~s~')
				end
			end
		end

		SetTimeout(10 * 60 * 1000, afkReward)
	end

	SetTimeout(10 * 60 * 1000, afkReward)
end
