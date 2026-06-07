local isPaused, isDead = false, false
local PassJoin = false

local HUDActive, LogoEnable = true, false

local WeaponsAmmo = {}
local AmmoChanged = false

FirstSpawn = true

PauseVSync = false

info = ESXConfig.DiscordURL

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if NetworkIsPlayerActive(PlayerId()) then
			TriggerServerEvent('esx:onPlayerJoined')
			break
		end
	end
end)


exports('getSharedObject', function()
	return ESX
end)


RegisterNetEvent('esx:updateDeath')
AddEventHandler('esx:updateDeath', function(isdead)
	ESX.PlayerData.IsDead = isdead
end)

RegisterNetEvent('esx:updateLicenses')
AddEventHandler('esx:updateLicenses', function(licenses)
	ESX.PlayerData.licenses = licenses
end)

RegisterNetEvent('esx:updateJail')
AddEventHandler('esx:updateJail', function(jail)
	ESX.PlayerData.jail = jail
end)

RegisterNetEvent('esx:updateIdentity')
AddEventHandler('esx:updateIdentity', function(identity)
	ESX.PlayerData.identity = identity
end)

RegisterNetEvent('esx:updateSkin')
AddEventHandler("esx:updateSkin", function(newskin)
	if newskin then
	ESX.PlayerData.skin = newskin
	end
end)

RegisterNetEvent('esx:toggleLogo')
AddEventHandler("esx:toggleLogo", function()
	toggleLogo()
end)

RegisterNetEvent('esx:ToggleCinematic')
AddEventHandler('esx:ToggleCinematic', function()
	PauseVSync = not PauseVSync
end)

Citizen.CreateThread(function()
    SetMapZoomDataLevel(0, 0.96, 0.9, 0.08, 0.0, 0.0) -- Level 0
    SetMapZoomDataLevel(1, 1.6, 0.9, 0.08, 0.0, 0.0) -- Level 1
    SetMapZoomDataLevel(2, 8.6, 0.9, 0.08, 0.0, 0.0) -- Level 2
    SetMapZoomDataLevel(3, 12.3, 0.9, 0.08, 0.0, 0.0) -- Level 3
    SetMapZoomDataLevel(4, 22.3, 0.9, 0.08, 0.0, 0.0) -- Level 4
end)

Citizen.CreateThread(function()
    while true do
		Citizen.Wait(100)
		SetRadarZoom(1100)
    end
end)


function toggleLogo()
        LogoEnable = not LogoEnable
		local logoopacity = 100
		local background = 'transparent'
	if LogoEnable then
		logoopacity = 100
		background = 'radial-gradient(transparent, rgba(122, 35, 235, 0.2))'
	else
		logoopacity = 0
		background = 'transparent'
	end
	SendNUIMessage({
		action = 'displayLogo',
		opacity = logoopacity,
		background = background
	})
end

RegisterNetEvent('esx:UpdateHUDMessage')
AddEventHandler('esx:UpdateHUDMessage', function(message)
	info = message
	SendNUIMessage({
		action = 'updateHUDElement',
		info = info
	})
end)

AddEventHandler('esx:toggleHUD', function()
	local ahud = not HUDActive
	TriggerEvent('esx:displayHud', ahud)
end)

RegisterNetEvent('esx:displayHud')
AddEventHandler('esx:displayHud', function(toggle)
	local hudopacity = 100
	HUDActive = toggle
	if toggle then
		hudopacity = 100
	else
		hudopacity = 0
	end
	SendNUIMessage({
		action = 'setHUDDisplay',
		opacity = hudopacity
	})
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(playerData)
	ESX.PlayerLoaded = true
	ESX.PlayerData = playerData

	Citizen.CreateThread(function()
		ESX.PlayerData.cache = {
			playerped = PlayerPedId(),
			coords = GetEntityCoords(PlayerPedId()),
			heading = GetEntityHeading(PlayerPedId()),
			invehicle = IsPedInAnyVehicle(PlayerPedId(), false),
			vehicle = GetVehiclePedIsIn(PlayerPedId(), false),
		}
		while true do
			ESX.PlayerData.cache.playerped = PlayerPedId()
			ESX.PlayerData.cache.coords = GetEntityCoords(ESX.PlayerData.cache.playerped)
			ESX.PlayerData.cache.heading = GetEntityHeading(ESX.PlayerData.cache.playerped)
			ESX.PlayerData.cache.invehicle = IsPedInAnyVehicle(ESX.PlayerData.cache.playerped, false)
			ESX.PlayerData.cache.vehicle = GetVehiclePedIsIn(ESX.PlayerData.cache.playerped, false)
			Wait(5)
		end
	end)


	while not PassJoin do
		Citizen.Wait(0)
	end

	-- check if player is coming from loading screen
	if GetEntityModel(ESX.PlayerData.cache.playerped) == GetHashKey('PLAYER_ZERO') then
		local defaultModel = GetHashKey('a_m_y_stbla_02')
		RequestModel(defaultModel)

		while not HasModelLoaded(defaultModel) do
			Citizen.Wait(10)
		end

		SetPlayerModel(PlayerId(), defaultModel)
		SetPedDefaultComponentVariation(ESX.PlayerData.cache.playerped)
		--SetPedRandomComponentVariation(ESX.PlayerData.cache.playerped, true)
		SetModelAsNoLongerNeeded(defaultModel)
	end

	-- freeze the player
	FreezeEntityPosition(ESX.PlayerData.cache.playerped, true)

	-- enable PVP
	SetCanAttackFriendly(ESX.PlayerData.cache.playerped, true, false)
	NetworkSetFriendlyFireOption(true)

	-- disable wanted level
	ClearPlayerWantedLevel(PlayerId())
	SetMaxWantedLevel(0)

	local cash, dirtycash, bank = 0, 0, 0

	SendNUIMessage({
		action = 'updateStatus',
		eat = ESX.PlayerData.status.eat,
		drink = ESX.PlayerData.status.drink
	})

	for k,v in ipairs(playerData.accounts) do
		if v.name == "money" then
			cash = ESX.Math.GroupDigits(v.money)
		end
		if v.name == "black_money" then
			dirtycash = ESX.Math.GroupDigits(v.money)
		end
		if v.name == "bank" then
			bank = ESX.Math.GroupDigits(v.money)
		end
	end
	SendNUIMessage({
		action = 'updateHUDElement',
		money = cash,
		black_money = dirtycash,
		bank = bank,
		info = info,
		job = ESX.PlayerData.job.label .. ' - ' .. ESX.PlayerData.job.grade_label,
        job2 = ESX.PlayerData.job2.label .. ' - ' .. ESX.PlayerData.job2.grade_label
	})

		TriggerServerEvent('esx:onPlayerSpawn')
		TriggerEvent('esx:onPlayerSpawn')
		TriggerEvent('playerSpawned')

		ShutdownLoadingScreen()
		ShutdownLoadingScreenNui()
		FreezeEntityPosition(ESX.PlayerData.cache.playerped, false)
		StartServerSyncLoops()
	TriggerEvent('esx:loadingScreenOff')
end)

Citizen.CreateThread(function()
	while true do
		Wait(250)
		if IsPauseMenuActive() then
			SendNUIMessage({
				action = 'setHUDDisplay',
				opacity = 0
			})
		elseif HUDActive then
			SendNUIMessage({
				action = 'setHUDDisplay',
				opacity = 100
			})
		end
	end
end)

RegisterNetEvent('esx:setMaxWeight')
AddEventHandler('esx:setMaxWeight', function(newMaxWeight) ESX.PlayerData.maxWeight = newMaxWeight end)

AddEventHandler('esx:onPlayerSpawn', function() isDead = false end)
AddEventHandler('esx:onPlayerDeath', function() isDead = true end)

AddEventHandler('modelLoaded', function()
	while not ESX.PlayerLoaded do
		Citizen.Wait(100)
	end

	TriggerEvent('esx:restoreLoadout')
end)

local foodX, foodY = 0.016, 0.792

function drawRct(x,y,width,height, c)
	DrawRect(x + width / 2, y + height / 2, width, height, c[1], c[2], c[3], c[4])
end


RegisterNetEvent('status:reset')
AddEventHandler("status:reset", function()
	ESX.PlayerData.status.eat = 100
	ESX.PlayerData.status.drink = 100
	SendNUIMessage({
		action = 'updateStatus',
		eat = ESX.PlayerData.status.eat,
		drink = ESX.PlayerData.status.drink
	})
	local playerPed = ESX.PlayerData.cache.playerped
	SetEntityHealth(playerPed, GetEntityMaxHealth(playerPed))
end)

RegisterNetEvent("esx:SyncMyPlayer")
AddEventHandler("esx:SyncMyPlayer", function(status, time, doHeal)
	if status then
	    ESX.PlayerData.status = status
		SendNUIMessage({
			action = 'updateStatus',
			eat = ESX.PlayerData.status.eat,
			drink = ESX.PlayerData.status.drink
		})
	end
	if time then
		ESX.PlayerData.time = tonumber(time)
	end
	if doHeal then
		SetEntityHealth(ESX.PlayerData.cache.playerped, GetEntityMaxHealth(ESX.PlayerData.cache.playerped))
	end
end)

RegisterNetEvent("status:add")
AddEventHandler("status:add", function(name, val)
if name == "eat" then
  if ESX.PlayerData.status.eat + val > 100 then
    ESX.PlayerData.status.eat = 100
  else
    ESX.PlayerData.status.eat = ESX.PlayerData.status.eat + val
  end
elseif name == "drink" then
  if ESX.PlayerData.status.drink + val > 100 then
    ESX.PlayerData.status.drink = 100
  else
    ESX.PlayerData.status.drink = ESX.PlayerData.status.drink + val
  end
end
SendNUIMessage({
	action = 'updateStatus',
	eat = ESX.PlayerData.status.eat,
	drink = ESX.PlayerData.status.drink
})
end)

Citizen.CreateThread(function()
	while not PassJoin do
	  Citizen.Wait(1000)
	end

	Citizen.CreateThread(function()
		if FirstSpawn then
		  local skin = ESX.PlayerData.skin
			if skin == nil then
			  TriggerEvent('caruiskinchanger:loadSkin', {sex = 0}, function()
				TriggerEvent('esx:restoreLoadout')
			  end)
			else
			  acc = skin
			  TriggerEvent('caruiskinchanger:loadSkin', skin, function()
				TriggerEvent('esx:restoreLoadout')
			  end)
			end
		  FirstSpawn = false
		end
	end)

	Citizen.CreateThread(function()
		while true do
		 Citizen.Wait(1000)

		   local playerPed = ESX.PlayerData.cache.playerped
		   local prevHealth = GetEntityHealth(playerPed)
		   local health = prevHealth

		   if ESX.PlayerData.status.eat == 0 then
			 if prevHealth <= 150 then
			   health = health - 5
			 else
			   health = health - 1
			 end
		   end

		   if ESX.PlayerData.status.drink == 0 then
			 if prevHealth <= 150 then
			   health = health - 5
			 else
			   health = health - 1
			 end
		   end

		   if health ~= prevHealth then
			 SetEntityHealth(playerPed, health)
		   end

		end
	end)

end)

AddEventHandler('esx:restoreLoadout', function()
	local playerPed = ESX.PlayerData.cache.playerped
	local ammoTypes = {}
	RemoveAllPedWeapons(playerPed, true)

	for k,v in ipairs(ESX.PlayerData.loadout) do
		local weaponName = v.name
		local weaponHash = GetHashKey(weaponName)

		if HasPedGotWeapon(playerPed, weaponHash, false) then
			return
		end
		GiveWeaponToPed(playerPed, weaponHash, 0, false, false)
		SetPedWeaponTintIndex(playerPed, weaponHash, v.tintIndex)

		local ammoType = GetPedAmmoTypeFromWeapon(playerPed, weaponHash)

		for k2,v2 in ipairs(v.components) do
			local componentHash = ESX.GetWeaponComponent(weaponName, v2).hash
			GiveWeaponComponentToPed(playerPed, weaponHash, componentHash)
		end

		if not ammoTypes[ammoType] then
			AddAmmoToPed(playerPed, weaponHash, v.ammo)
			ammoTypes[ammoType] = true
		end
	end

	for k,v in ipairs(ESX.PlayerData.permloadout) do
		local weaponName = v.name
		local weaponHash = GetHashKey(weaponName)

		if HasPedGotWeapon(playerPed, weaponHash, false) then
			return
		end

		GiveWeaponToPed(playerPed, weaponHash, 0, false, false)
		SetPedWeaponTintIndex(playerPed, weaponHash, v.tintIndex)

		local ammoType = GetPedAmmoTypeFromWeapon(playerPed, weaponHash)

		for k2,v2 in ipairs(v.components) do
			local componentHash = ESX.GetWeaponComponent(weaponName, v2).hash
			GiveWeaponComponentToPed(playerPed, weaponHash, componentHash)
		end

		if not ammoTypes[ammoType] then
			AddAmmoToPed(playerPed, weaponHash, v.ammo)
			ammoTypes[ammoType] = true
		end
	end

	--ESX.ShowNotification(#ESX.PlayerData.permloadout .. ' arme(s) permanente(s) ont été synchronisés')
end)

AddEventHandler('esx:restorePermLoadout', function()
	TriggerEvent('esx:restoreLoadout')
end)

RegisterNetEvent("esx:passjoin")
AddEventHandler("esx:passjoin", function()
	PassJoin = true
	ESX.PlayerData.PassJoin = true
end)

RegisterNetEvent('esx:setAccountMoney')
AddEventHandler('esx:setAccountMoney', function(account)

	for i = 1, #ESX.PlayerData.accounts, 1 do
		if ESX.PlayerData.accounts[i].name == account.name then
			ESX.PlayerData.accounts[i] = account
			break
		end
	end

	if Config.EnableHud then
		if account.name == "money" then
			SendNUIMessage({
				action = 'updateHUDElement',
				money = ESX.Math.GroupDigits(account.money)
			})
		end
		if account.name == "black_money" then
			SendNUIMessage({
				action = 'updateHUDElement',
				black_money = ESX.Math.GroupDigits(account.money)
			})
		end
		if account.name == "bank" then
			SendNUIMessage({
				action = 'updateHUDElement',
				bank = ESX.Math.GroupDigits(account.money)
			})
		end
	end
end)

function DrawSub(text, time)
	ClearPrints()
	SetTextEntry_2("STRING")
	AddTextComponentString(text)
	DrawSubtitleTimed(time, 1)
end

RegisterNetEvent('esx:addInventoryItem')
AddEventHandler('esx:addInventoryItem', function(item, count)
	for k,v in ipairs(ESX.PlayerData.inventory) do
		if v.name == item then
			DrawSub("+"..count - v.count.." "..v.label, 1000)
			ESX.PlayerData.inventory[k].count = count
			break
		end
	end
end)

RegisterNetEvent('esx:removeInventoryItem')
AddEventHandler('esx:removeInventoryItem', function(item, count, showNotification)
	for k,v in ipairs(ESX.PlayerData.inventory) do
		if v.name == item then
			DrawSub(count - v.count.." "..v.label, 1000)
			ESX.PlayerData.inventory[k].count = count
			break
		end
	end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job

	if Config.EnableHud then
		SendNUIMessage({
			action = 'updateHUDElement',
			job = ESX.PlayerData.job.label .. ' - ' .. ESX.PlayerData.job.grade_label
		})
	end
end)

RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job)
	ESX.PlayerData.job2 = job

	if Config.EnableHud then
		SendNUIMessage({
			action = 'updateHUDElement',
			job2 = ESX.PlayerData.job2.label .. ' - ' .. ESX.PlayerData.job2.grade_label
		})
	end
end)

RegisterNetEvent('esx:setRank')
AddEventHandler('esx:setRank', function(rank, expiration)
	ESX.PlayerData.rank = rank
	ESX.PlayerData.expiration = expiration
end)

RegisterNetEvent('esx:setStorePoints')
AddEventHandler('esx:setStorePoints', function(storepoints)
	ESX.PlayerData.storepoints = storepoints
end)

RegisterNetEvent('esx:announce')
AddEventHandler('esx:announce', function(title, msg, sec)
	SetAudioFlag("LoadMPData", 1)
PlaySoundFrontend(-1, "Boss_Message_Orange", "GTAO_Boss_Goons_FM_Soundset", 1)
ESX.Scaleform.ShowFreemodeMessage(title, msg, sec)
end)


-- Loadout

RegisterNetEvent('esx:addWeapon')
AddEventHandler('esx:addWeapon', function(weaponName, ammo)
	local playerPed = ESX.PlayerData.cache.playerped
	local weaponHash = GetHashKey(weaponName)
	table.insert(ESX.PlayerData.loadout, {
		name = weaponName,
		ammo = ammo,
		label = ESX.GetWeaponLabel(weaponName) or "UNKNOWN NAME",
		components = {},
		tintIndex = 0
	})

	GiveWeaponToPed(playerPed, weaponHash, ammo, false, false)

	DrawSub("+ " .. ESX.GetWeaponLabel(weaponName) or "UNKNOWN NAME", 1000)
end)

RegisterNetEvent('esx:addWeaponComponent')
AddEventHandler('esx:addWeaponComponent', function(weaponName, weaponComponent)
	local playerPed = ESX.PlayerData.cache.playerped
	local weaponHash = GetHashKey(weaponName)
	local componentHash = ESX.GetWeaponComponent(weaponName, weaponComponent).hash

	GiveWeaponComponentToPed(playerPed, weaponHash, componentHash)
end)

RegisterNetEvent('esx:setWeaponAmmo')
AddEventHandler('esx:setWeaponAmmo', function(weaponName, weaponAmmo)
	local playerPed = ESX.PlayerData.cache.playerped
	local weaponHash = GetHashKey(weaponName)
	for k, v in pairs(ESX.PlayerData.loadout) do 
		if string.lower(v.name) == string.lower(weaponName) then
			v.ammo = weaponAmmo
			break
		end
	end
	SetPedAmmo(playerPed, weaponHash, weaponAmmo)
end)

RegisterNetEvent('esx:setWeaponTint')
AddEventHandler('esx:setWeaponTint', function(weaponName, weaponTintIndex)
	local playerPed = ESX.PlayerData.cache.playerped
	local weaponHash = GetHashKey(weaponName)

	SetPedWeaponTintIndex(playerPed, weaponHash, weaponTintIndex)
end)

RegisterNetEvent('esx:removeWeapon')
AddEventHandler('esx:removeWeapon', function(weaponName)
	local playerPed = ESX.PlayerData.cache.playerped
	local weaponHash = GetHashKey(weaponName)

	RemoveWeaponFromPed(playerPed, weaponHash)
	for k, v in pairs(ESX.PlayerData.loadout) do 
		if v and tostring(v.name) then
		if string.lower(v.name) == string.lower(weaponName) then
			table.remove(ESX.PlayerData.loadout, k)
			break
		end
	    end
	end
	SetPedAmmo(playerPed, weaponHash, 0) -- remove leftover ammo
	DrawSub("- " .. ESX.GetWeaponLabel(weaponName) or "UNKNOWN NAME", 1000)
end)

RegisterNetEvent('esx:removeWeaponComponent')
AddEventHandler('esx:removeWeaponComponent', function(weaponName, weaponComponent)
	local playerPed = ESX.PlayerData.cache.playerped
	local weaponHash = GetHashKey(weaponName)
	local componentHash = ESX.GetWeaponComponent(weaponName, weaponComponent).hash

	RemoveWeaponComponentFromPed(playerPed, weaponHash, componentHash)
end)

-- Perma Loadout

RegisterNetEvent('esx:addPermWeapon')
AddEventHandler('esx:addPermWeapon', function(weaponName, ammo)
	local playerPed = ESX.PlayerData.cache.playerped
	local weaponHash = GetHashKey(weaponName)
	table.insert(ESX.PlayerData.permloadout, {
		name = weaponName,
		ammo = ammo,
		label = ESX.GetWeaponLabel(weaponName) or "UNKNOWN NAME",
		components = {},
		tintIndex = 0
	})
	GiveWeaponToPed(playerPed, weaponHash, ammo, false, false)

	DrawSub("+ " .. ESX.GetWeaponLabel(weaponName) or "UNKNOWN NAME", 1000)
end)

RegisterNetEvent('esx:addPermWeaponComponent')
AddEventHandler('esx:addPermWeaponComponent', function(weaponName, weaponComponent)
	local playerPed = ESX.PlayerData.cache.playerped
	local weaponHash = GetHashKey(weaponName)
	local componentHash = ESX.GetWeaponComponent(weaponName, weaponComponent).hash

	GiveWeaponComponentToPed(playerPed, weaponHash, componentHash)
end)

RegisterNetEvent('esx:setPermWeaponAmmo')
AddEventHandler('esx:setPermWeaponAmmo', function(weaponName, weaponAmmo)
	local playerPed = ESX.PlayerData.cache.playerped
	local weaponHash = GetHashKey(weaponName)

	SetPedAmmo(playerPed, weaponHash, weaponAmmo)
end)

RegisterNetEvent('esx:setPermWeaponTint')
AddEventHandler('esx:setPermWeaponTint', function(weaponName, weaponTintIndex)
	local playerPed = ESX.PlayerData.cache.playerped
	local weaponHash = GetHashKey(weaponName)

	SetPedWeaponTintIndex(playerPed, weaponHash, weaponTintIndex)
end)

RegisterNetEvent('esx:removePermWeapon')
AddEventHandler('esx:removePermWeapon', function(weaponName)
	local playerPed = ESX.PlayerData.cache.playerped
	local weaponHash = GetHashKey(weaponName)

	RemoveWeaponFromPed(playerPed, weaponHash)
	SetPedAmmo(playerPed, weaponHash, 0) -- remove leftover ammo
	for k, v in pairs(ESX.PlayerData.permloadout) do 
		if v and tostring(v.name) then
		if string.lower(v.name) == string.lower(weaponName) then
			table.remove(ESX.PlayerData.permloadout, k)
			break
		end
	end
	end
	DrawSub("- " .. ESX.GetWeaponLabel(weaponName) or "UNKNOWN NAME", 1000)
end)

RegisterNetEvent('esx:removePermWeaponComponent')
AddEventHandler('esx:removePermWeaponComponent', function(weaponName, weaponComponent)
	local playerPed = ESX.PlayerData.cache.playerped
	local weaponHash = GetHashKey(weaponName)
	local componentHash = ESX.GetWeaponComponent(weaponName, weaponComponent).hash

	RemoveWeaponComponentFromPed(playerPed, weaponHash, componentHash)
end)

RegisterNetEvent('esx:teleport')
AddEventHandler('esx:teleport', function(coords)
	local playerPed = ESX.PlayerData.cache.playerped

	-- ensure decmial number
	coords.x = coords.x + 0.0
	coords.y = coords.y + 0.0
	coords.z = coords.z + 0.0

	ESX.Game.Teleport(playerPed, coords)
end)

RegisterNetEvent('esx:spawnVehicle')
AddEventHandler('esx:spawnVehicle', function(vehicleName)
	local model = vehicleName

	if IsModelInCdimage(model) then
		local playerPed = ESX.PlayerData.cache.playerped
		local playerCoords, playerHeading = ESX.PlayerData.cache.coords, ESX.PlayerData.cache.heading

		ESX.Game.SpawnVehicle(model, playerCoords, playerHeading, function(vehicle)
			--TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
		end, "ESX")
	else
	end
end)

RegisterNetEvent('esx:deleteVehicle')
AddEventHandler('esx:deleteVehicle', function(radius)
	local playerPed = ESX.PlayerData.cache.playerped

	if radius and tonumber(radius) then
		radius = tonumber(radius) + 0.01
		local vehicles = ESX.Game.GetVehiclesInArea(ESX.PlayerData.cache.coords, radius)

		for k,entity in ipairs(vehicles) do
			local attempt = 0

			while not NetworkHasControlOfEntity(entity) and attempt < 100 and DoesEntityExist(entity) do
				Citizen.Wait(100)
				NetworkRequestControlOfEntity(entity)
				attempt = attempt + 1
			end

			if DoesEntityExist(entity) and NetworkHasControlOfEntity(entity) then
				ESX.Game.DeleteVehicle(entity)
			end
		end
	else
		local vehicle, attempt = ESX.Game.GetVehicleInDirection(), 0

		if ESX.PlayerData.cache.invehicle then
			vehicle = ESX.PlayerData.cache.vehicle
		end

		while not NetworkHasControlOfEntity(vehicle) and attempt < 100 and DoesEntityExist(vehicle) do
			Citizen.Wait(100)
			NetworkRequestControlOfEntity(vehicle)
			attempt = attempt + 1
		end

		if DoesEntityExist(vehicle) and NetworkHasControlOfEntity(vehicle) then
			ESX.Game.DeleteVehicle(vehicle)
		end
	end
end)

RegisterNetEvent("esx:updateWeaponAmmo")
AddEventHandler("esx:updateWeaponAmmo", function(weaponHash)
	local weapon = ESX.GetWeaponFromHash(weaponHash)

	if weapon then
		local ammoCount = GetAmmoInPedWeapon(ESX.PlayerData.cache.playerped, weaponHash)
		WeaponsAmmo[weapon.name] = ammoCount
		AmmoChanged = true
	end
end)

function StartServerSyncLoops()
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(5)
			local playerPed = ESX.PlayerData.cache.playerped
			
			if IsPedShooting(playerPed) then
				local _,weaponHash = GetCurrentPedWeapon(playerPed, true)
				local weapon = ESX.GetWeaponFromHash(weaponHash)
				if weapon and string.lower(weapon.name) ~= "weapon_snspistol_mk2" then
					local ammoCount = GetAmmoInPedWeapon(playerPed, weaponHash)
					WeaponsAmmo[weapon.name] = ammoCount
					AmmoChanged = true
				end
			end
		end
	end)

	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(2500)
			if AmmoChanged then
			    TriggerServerEvent('esx:updateWeaponsAmmo', WeaponsAmmo)
			    AmmoChanged = false
			else
				Wait(1000)
			end
		end
	end)
end

ESX.SavePlayer = function()
	TriggerServerEvent('esx:syncPlayer')
end
