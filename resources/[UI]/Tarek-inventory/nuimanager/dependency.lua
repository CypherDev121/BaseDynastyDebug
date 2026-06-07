ESX = nil
Dressing = {}
Pickups = {}

MoneyData = {
    ["money"] = {name = "Liquide"},
    ["black_money"] = {name = "Argent Sale"},
    ["bank"] = {name = "Argent en banque"},
}

Citizen.CreateThread(function()
    while not ESX do 
        Wait(0)
        TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(playerData, isNew, skin)
    while not ESX do 
        Wait(5)
    end
	ESX.PlayerLoaded = true
	ESX.PlayerData = playerData
	ESX.PlayerData.skin = skin
	if isInInventory then
		RefreshInventoryContent(actualFilter, searchFilters["inventory"])
	end
end)

RegisterNetEvent('esx:addInventoryItem')
AddEventHandler('esx:addInventoryItem', function(item, count)
	for k,v in ipairs(ESX.PlayerData.inventory) do
		if v.name == item then
			ESX.PlayerData.inventory[k].count = count
			break
		end
	end
    if isInInventory then
        RefreshInventoryContent(actualFilter, searchFilters["inventory"])
    end
end)

RegisterNetEvent('esx:removeInventoryItem')
AddEventHandler('esx:removeInventoryItem', function(item, count, showNotification)
	for k,v in ipairs(ESX.PlayerData.inventory) do
		if v.name == item then
			ESX.PlayerData.inventory[k].count = count
			break
		end
	end
    if isInInventory then
        RefreshInventoryContent(actualFilter, searchFilters["inventory"])
    end
end)

RegisterNetEvent('esx:setAccountMoney')
AddEventHandler('esx:setAccountMoney', function(account)
	for i = 1, #ESX.PlayerData.accounts, 1 do
		if ESX.PlayerData.accounts[i].name == account.name then
			ESX.PlayerData.accounts[i] = account
			break
		end
	end
    if isInInventory then
        RefreshInventoryContent(actualFilter, searchFilters["inventory"])
    end
end)

RegisterNetEvent('esx:setMaxWeight')
AddEventHandler('esx:setMaxWeight', function(newMaxWeight) 
	ESX.PlayerData.maxWeight = newMaxWeight
    if isInInventory then
        RefreshInventoryContent(actualFilter, searchFilters["inventory"])
    end
end)

-- Loadout

RegisterNetEvent('esx:addWeapon')
AddEventHandler('esx:addWeapon', function(weaponName, ammo, isPerm)
	local permanent = false
	if isPerm and isPerm == true then
		permanent = true
	else
		permanent = false
	end
	table.insert(ESX.PlayerData.loadout, {
		name = weaponName,
		ammo = ammo,
		label = ESX.GetWeaponLabel(weaponName) or "UNKNOWN NAME",
		components = {},
		tintIndex = 0,
		permanent = permanent
	})
    if isInInventory then
        RefreshInventoryContent(actualFilter, searchFilters["inventory"])
    end
end)

RegisterNetEvent('esx:setWeaponAmmo')
AddEventHandler('esx:setWeaponAmmo', function(weaponName, weaponAmmo)
	for k, v in pairs(ESX.PlayerData.loadout) do 
		if string.lower(v.name) == string.lower(weaponName) then
			v.ammo = weaponAmmo
			break
		end
	end
    if isInInventory then
        RefreshInventoryContent(actualFilter, searchFilters["inventory"])
    end
end)

RegisterNetEvent('esx:removeWeapon')
AddEventHandler('esx:removeWeapon', function(weaponName)
	for k, v in pairs(ESX.PlayerData.loadout) do 
		if v and tostring(v.name) then
		if string.lower(v.name) == string.lower(weaponName) then
			table.remove(ESX.PlayerData.loadout, k)
			break
		end
	    end
	end
    if isInInventory then
        RefreshInventoryContent(actualFilter, searchFilters["inventory"])
    end
end)

RegisterNetEvent('esx:updatedPickups')
AddEventHandler("esx:updatedPickups", function(pickups)
	Pickups = {}
	for k,v in pairs(pickups) do
		table.insert(Pickups, v)
	end
    if isInInventory and VaultCache.vaultId == 0 then
        RefreshVaultContent(actualFilter, VaultCache.vaultId or 0, true, searchFilters["vault"])
    end
end)

RegisterNetEvent('esx:updateSkin')
AddEventHandler("esx:updateSkin", function(newskin)
	if newskin then
	    ESX.PlayerData.skin = newskin
	end
end)

RegisterNetEvent("inventory:syncOufits")
AddEventHandler('inventory:syncOufits', function(dressing)
	Dressing = dressing
end)
