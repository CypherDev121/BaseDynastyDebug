isInInventory = false

local controlDisabled = {1, 2, 3, 4, 5, 6, 18, 24, 25, 37, 69, 70, 111, 117, 118, 182, 199, 200, 257}

local alwaysDisabled = {157, 158, 159, 160, 161, 162, 163, 164, 165}

clonedPed = false

actualFilter = "all"

VaultCache = {}

fastItems = {}

searchFilters = {
    ["inventory"] = "",
    ["vault"] = ""
}

ClothesInfo = {
    ["helmet"] = 0,
    ["tshirt"] = 0,
    ["bproof"] = 0,
    ["bags"] = 0,
    ["pants"] = 0,
    ["shoes"] = 0,
    ["mask"] = 0,
    ["glasses"] = 0,
    ["ears"] = -1,
    ["chain"] = -1,
}

local Accounts = {
	black_money = "Argent sale",
	money = "Espèces",
}


InventoryCache = {}

RegisterKeyMapping('openinventory', 'Ouvrir l\'inventaire', 'keyboard', 'TAB')
RegisterCommand('openinventory', function()
    OpenInventory(actualFilter)
end)

function OpenInventory(sort, doSetNearby)
    SetNuiFocus(true, true)
    isInInventory = true
    if doSetNearby then
        RefreshVaultContent(actualFilter, 0, false, searchFilters["vault"])
    end
    RefreshInventoryContent(sort, searchFilters["inventory"], true)
    SendNUIMessage({
        show = true,
        selectedAmount = 1,
        defaultImg = "./assets/img/items/carton.png"
    })
    
    Citizen.CreateThread(function()
        while isInInventory do
            Citizen.Wait(5)
            SetMouseCursorVisibleInMenus(false)
        end
    end)
end

function CloseInventory()
    SetNuiFocus(false, false)
    isInInventory = false
    DestroyPedInMenu()
    SendNUIMessage({
        show = false
    })
    VaultCache = {}
end

local clothesDataListByKey = {}

function GetAllClothesFromPack(pack)
    local clothes = {}
    for k,v in pairs(pack) do
        if string.find(k, "_1") then
            if v ~= 0 then
                local namewithout = k:gsub("%_1", "")
                clothes[namewithout] = {}
                clothes[namewithout][k] = v
                if pack[namewithout .. "_2"] then
                    clothes[namewithout][namewithout .. "_2"] = pack[namewithout .. "_2"]
                end
                if pack[namewithout .. "_3"] then
                    clothes[namewithout][namewithout .. "_3"] = pack[namewithout .. "_3"]
                end
            end
        elseif not string.find(k, "_") then
            clothes[k] = {}
            clothes[k][k] = v
        end
    end
    return clothes
end

function RefreshInventoryContent(sort, search, loadPed)
    if isInInventory then
        local playerPed = PlayerPedId()
        local itemsCount = 0
        local rowsToSend = {}
        local rowsCount = 0
        local rowsToAdd = 0
        local fastToSend = {}
        local fastAdd = 5
        if not search then
            search = ""
        end
        local ValidItemsList = {}
        for k,v in pairs(ESX.PlayerData.inventory) do
            if v.count > 0 then
                itemsCount = itemsCount + (v.count * v.weight)
                ValidItemsList[string.lower(v.name)] = true
                if (sort == "all" or sort == "items") and string.find(string.lower(v.label), string.lower(search)) then
                    table.insert(rowsToSend, {label = v.label, name = v.name, img = "./assets/img/items/" .. v.name .. ".png", amount = v.count, weight = v.weight == 0 and 1 or v.weight, type = 'item', canRemove = v.canRemove, usable = v.usable})
                    rowsCount = rowsCount + 1
                end
            end
        end
        if sort == "all" or sort == "weapons" then
            for k,v in pairs(ESX.PlayerData.loadout) do
                local weaponHash = GetHashKey(v.name)
                local label = ESX.GetWeaponLabel(v.name) or "Unknown Weapon"
                if HasPedGotWeapon(playerPed, weaponHash, false) then
                    ValidItemsList[string.lower(v.name)] = true
                    if string.find(string.lower(label), string.lower(search)) then
                        local ammo = GetAmmoInPedWeapon(playerPed, weaponHash)
                        if ammo then
                            ammo = ammo
                        else
                            ammo = 0
                        end
                        table.insert(rowsToSend, {label = label, name = v.name, img = "./assets/img/weapons/" .. string.upper(v.name) .. ".png", amount = ammo, weight = 0, type = 'weapon', canRemove = (v.permanent and "0") or "1", usable = "false"})
                        rowsCount = rowsCount + 1
                    end
                end
            end
        end
        if sort == "all" or sort == "clothes" then
            for i=1, #Dressing, 1 do
                local dressingData = Dressing[i]
                dressingData.label = dressingData.label or "Unknown Clothes"
                if not dressingData.selected and string.find(dressingData.label, search) then
                    clothesDataListByKey[tostring(i) .. '-' .. "pack"] = {label = dressingData.label, type = "pack", data = dressingData.skin}
                    ValidItemsList[tostring(i) .. '-' .. "pack"] = true
                    table.insert(rowsToSend, {label = dressingData.label .. " (pack)", name = tostring(i) .. '-' .. "pack", img = "./assets/img/items/pack.png", weight = 0, amount = 1, type = 'clothe', canRemove = "0", usable = "false"})
                    rowsCount = rowsCount + 1
                    if sort == "clothes" then
                        local clothesList = GetAllClothesFromPack(dressingData.skin)
                        for k, v in pairs(clothesList) do
                            print(k, v)
                            if k == "helmet" or k == "mask" then
                                clothesDataListByKey[tostring(i) .. '-' .. k] = {label = dressingData.label, type = k, data = v}
                                ValidItemsList[tostring(i) .. '-' .. k] = true
                                table.insert(rowsToSend, {label = dressingData.label .. (" (%s)"):format(k), name = tostring(i) .. '-' .. k, weight = 0, img = "./assets/img/items/" .. k .. ".png", amount = 1, type = 'clothe', canRemove = "0", usable = "false"})
                                rowsCount = rowsCount + 1
                            end
                        end
                    end
                end
            end
        end
        if sort == "all" or sort == "accounts" then
            for k,v in pairs(ESX.PlayerData.accounts) do
                if Accounts[string.lower(v.name)] then
                    ValidItemsList[string.lower(v.name)] = true
                    local label = Accounts[string.lower(v.name)]
                    if string.find(string.lower(label), string.lower(search)) then
                        table.insert(rowsToSend, {label = label, name = v.name, img = "./assets/img/accounts/" .. string.lower(v.name) .. ".png", weight = 0, amount = v.money, type = 'account', canRemove = "1", usable = "false"})
                        rowsCount = rowsCount + 1
                    end
                end
            end
        end
        for k,v in pairs(fastItems) do
            if v then
                if ValidItemsList[string.lower(tostring(v.name))] then
                    fastAdd = fastAdd - 1
                    fastToSend[tonumber(k) + 1] = v
                else
                    fastItems[k] = nil
                end
            end
        end
        SendNUIMessage({
            serverName = "NyseraRP",
            selectedCategory = sort,
            inventories = {
                player = {
                    label = "Inventaire",
                    selectedCategory = sort,
                    weight = itemsCount,
                    maxWeight = ESX.PlayerData.maxWeight,
                    itemsList = rowsToSend,
                }
            },
            fastItems = fastToSend
        })
        if loadPed then
            Citizen.CreateThread(function()
                CreatePedInMenu(true)
            end)
        end
    end
end

AddEventHandler("coffre:loadCoffre", function(selectedInv, vault)
    if selectedInv == "new" then
        actualFilter = "all"
        if not isInInventory then
            OpenInventory(actualFilter)
        end
        RefreshVaultContent(actualFilter, vault.type, false, searchFilters["vault"])
    end
end)

function RefreshVaultContent(sort, vault, usecache, searchfilter)
    local itemsCount = 0
    local rows = {}
    local rowsToAdd = 0
    local VaultTitle = "Coffre"
    local inInv = isInInventory
    local vaulttype = (usecache and VaultCache.vaultId) or vault
    local search = searchfilter
    local eventprefix = "society"
    if not search then
        search = ""
    end
    if vaulttype == 1 or vaulttype == 2 or vaulttype == 3 then
        if vaulttype == 1 then
            VaultTitle = "Coffre Entreprise"
        elseif vaulttype == 2 then
            VaultTitle = "Coffre Organisation"
        elseif vaulttype == 3 then
            VaultTitle = "Coffre d'habitation"
            eventprefix = "housing"
        end
        if usecache then
            for k, v in pairs(VaultCache.rows or {}) do 
                if v.amount > 0 and string.find(string.lower(v.label), string.lower(search)) then
                    if sort == "all" or (v.type .. "s" == sort) then
                        table.insert(rows, v)
                    end
                end
            end
            SendNUIMessage({
                serverName = "NyseraRP",
                selectedCategory = sort,
                inventories = {
                    vault = {
                        label = VaultTitle,
                        selectedCategory = sort,
                        weight = VaultCache.itemsCount,
                        maxWeight = ESX.PlayerData.maxWeight,
                        itemsList = rows,
                        vaultId = vaulttype
                    }
                },
            })
        else
            local maxWeight = 0
            local weight = 0
            ESX.TriggerServerCallback(eventprefix .. ":getStockItems", function(data)
                print("items", json.encode(data))
                for k, item in pairs(data.items) do
                    local itemtype = 'item'
                    if item.count > 0 then
                        itemsCount = itemsCount + item.count
                        table.insert(rows, {label = (item.label or "Unknown"), name = item.name, img = "./assets/img/items/" .. item.name .. ".png", amount = item.count, weight = item.weight or 1, type = 'item', canRemove = "0"})
                    end
                end
                maxWeight = data.maxWeight
                weight = data.weight
                if data.money then
                    local item = data.money
                    table.insert(rows, {label = (item.label or "Unknown"), name = item.name, img = "./assets/img/accounts/" .. item.name .. ".png", amount = item.count, weight = 0, type = 'account', canRemove = "0"})
                end
                local weapons = data.weapons or {}
                for i=1, #weapons, 1 do
                    local v = weapons[i]
                    local label = ESX.GetWeaponLabel(v.name) or "Unknown Weapon"
                    table.insert(rows, {label = label, name = v.name, img = "./assets/img/weapons/" .. string.upper(v.name) .. ".png", amount = v.ammo, weight = 0, type = 'weapon', canRemove = "0"})
                end
                VaultCache = {
                    maxWeight = maxWeight,
                    rows = rows,
                    itemsCount = weight,
                    selectedCategory = sort,
                    vaultId = vaulttype,
                    title = VaultTitle,
                }
                local rowsToSend = {}
                for k, v in pairs(VaultCache.rows or {}) do 
                    if v.amount >= 0 and string.find(string.lower(v.label), string.lower(search)) then
                        if sort == "all" or (v.type .. "s" == sort) then
                            table.insert(rowsToSend, v)
                        end
                    end
                end

                SendNUIMessage({
                    serverName = "NyseraRP",
                    selectedCategory = sort,
                    inventories = {
                        vault = {
                            label = VaultTitle,
                            selectedCategory = sort,
                            weight = VaultCache.itemsCount,
                            maxWeight = VaultCache.maxWeight,
                            itemsList = rowsToSend,
                            vaultId = vaulttype
                        }
                    },
                })
                if not inInv then
                    OpenInventory(actualFilter)
                end
            end, vaulttype)
        end
    elseif vaulttype == 0 then
        local nearbyInventory = exports['Core_CypherDev']:GetNearPickups()

        for k, v in pairs(nearbyInventory) do
            if (sort == "all" or sort == v.props.type .. "s") and string.find(string.lower(v.props.label), string.lower(search)) then
                local row = {}
                if v.props.type == "item" then
                    itemsCount = itemsCount + v.props.count
                    row = {label = v.props.label, name = k, img = "./assets/img/items/" .. v.props.name .. ".png", amount = v.props.count, weight = v.props.weight or 1, type = 'item', canRemove = v.props.canRemove, usable = v.props.usable}
                elseif v.props.type == "weapon" then
                    row = {label = v.props.label, name = k, img = "./assets/img/weapons/" .. string.upper(v.props.name) .. ".png", amount = v.props.count, weight = 0, type = 'weapon', canRemove = (v.props.permanent and "0") or "1", usable = "false"}
                elseif v.props.type == "account" then
                    row = {label = v.props.label, name = k, img = "./assets/img/accounts/" .. string.lower(v.props.name) .. ".png", amount = v.props.count, weight = 0, type = 'account', canRemove = "1", usable = "false"}
                end
                table.insert(rows, row)
            end
        end
        
        VaultCache.vaultId = 0

        SendNUIMessage({
            serverName = "NyseraRP",
            selectedCategory = sort,
            inventories = {
                vault = {
                    label = "à proximité",
                    selectedCategory = sort,
                    weight = itemsCount,
                    maxWeight = -1,
                    itemsList = rows,
                    vaultId = vaulttype
                }
            },
        })
    end
end

Citizen.CreateThread(function()
    for i = 1, 5, 1 do
        RegisterCommand('+fastitem' .. i, function()
            UseFastSlot(i)
        end)
        RegisterKeyMapping('+fastitem' .. i, "Utiliser l'objet n°" .. i .. " de la séléction rapide", "keyboard", tostring(i))
    end
end)

function UseFastSlot(slot)
    local SlotData = fastItems[tostring(slot)]
    if SlotData and not isInInventory then
        if SlotData.type == "item" then
            TriggerEvent("esx:useItem", SlotData.name)
        elseif SlotData.type == "weapon" then
            local playerPed = PlayerPedId()
            local weapon = SlotData.name
            if GetSelectedPedWeapon(playerPed) == GetHashKey(weapon) then
                SetCurrentPedWeapon(playerPed, `WEAPON_UNARMED`,true)
            else
                SetCurrentPedWeapon(playerPed, GetHashKey(weapon), true)
            end
        elseif SlotData.type == "clothe" then
            local clotheData = clothesDataListByKey[SlotData.name]
            if clotheData then
                TriggerEvent("skinchanger:getSkin", function(skin)
                    TriggerEvent("skinchanger:loadClothes", skin, clotheData.data)
                end)
            end
        end
    end
end

RegisterNUICallback('selectCategory', function(data, cb)
    actualFilter = data.category
    RefreshInventoryContent(actualFilter, searchFilters["inventory"])
    RefreshVaultContent(actualFilter, VaultCache.vaultId or 0, true, searchFilters["vault"])
    if cb then
        cb()
    end
end)

RegisterNUICallback('inventoryAction', function(data, cb)
    data.amount = tonumber(data.amount or 1)
    if data.action == "use" then
        if data.itemType == "item" then
            TriggerEvent("esx:useItem", data.itemName)
        end
    elseif data.action == "give" then
        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
        if closestPlayer == -1 or closestDistance >= 2.0 then ESX.ShowNotification("Personne à proximité.") return end
        if data.itemType == "weapon" then
            TriggerServerEvent("esx:giveInventoryItem", GetPlayerServerId(closestPlayer), "item_weapon", data.itemName, nil)
        elseif data.itemType == "item" then
            TriggerServerEvent("esx:giveInventoryItem", GetPlayerServerId(closestPlayer), "item_standard", data.itemName, tonumber(data.amount))
        elseif data.itemType == "account" then
            TriggerServerEvent("esx:giveInventoryItem", GetPlayerServerId(closestPlayer), "item_account", btn.itemname, tonumber(amount))
        end
    elseif data.action == "drop" then
        if data.itemType == "weapon" then
            TriggerServerEvent("esx:removeInventoryItem", "item_weapon", data.itemName, 1)
        elseif data.itemType == "item" then
            TriggerServerEvent("esx:removeInventoryItem", "item_standard", data.itemName, tonumber(data.amount))
        elseif data.itemType == "account" then
            TriggerServerEvent("esx:removeInventoryItem", "item_account", data.itemName, tonumber(data.amount))
        end
    end
    if cb then
        cb()
    end
end)

RegisterNUICallback('CypherInventory', function(data, cb)
    if data.targetInv == "fast" then
        data.targetSlot = tonumber(data.targetSlot)
        if data.itemType == "item" then
            for k, v in pairs(ESX.PlayerData.inventory) do
                if v.name == data.itemName and v.count > 0 then
                    fastItems[tostring(data.targetSlot)] = {name = data.itemName, label = v.label, type = data.itemType, amount = v.count, slot = data.targetSlot, img = ((data.type == "clothe" and clothesDataListByKey[data.item]) and ("./assets/img/items/" .. clothesDataListByKey[data.item].type) .. ".png")}
                    break
                end
            end
        elseif data.itemType == "weapon" then
            for k, v in pairs(ESX.PlayerData.loadout) do
                if v.name == data.itemName then
                    fastItems[tostring(data.targetSlot)] = {name = data.itemName, label = v.label, type = data.itemType, amount = v.ammo, slot = data.targetSlot, img = "./assets/img/weapons/" .. string.upper(data.itemName) .. ".png"}
                    break
                end
            end
        elseif data.itemType == "account" then
            for k, v in pairs(ESX.PlayerData.accounts) do
                if v.name == data.itemName then
                    fastItems[tostring(data.targetSlot)] = {name = data.itemName, label = v.label, type = data.itemType, amount = v.money, slot = data.targetSlot, img = "./assets/img/accounts/" .. string.lower(data.itemName) .. ".png"}
                    break
                end
            end
        end
        RefreshInventoryContent(actualFilter, searchFilters["inventory"])

    elseif data.targetInv == "vault" then
        if tonumber(data.vaultId) == 0 then
            if data.itemType == "weapon" then
                TriggerServerEvent("esx:removeInventoryItem", "item_weapon", data.itemName, 1)
            elseif data.itemType == "item" then
                TriggerServerEvent("esx:removeInventoryItem", "item_standard", data.itemName, tonumber(data.amount))
            elseif data.itemType == "account" then
                TriggerServerEvent("esx:removeInventoryItem", "item_account", data.itemName, tonumber(data.amount))
            end
        else
            local eventprefix = "society"
            if tonumber(data.vaultId) == 3 then
                eventprefix = "housing"
            end
            if data.itemType == "weapon" then
                if eventprefix == "housing" then
                    ESX.TriggerServerCallback(eventprefix .. ":addArmoryWeapon", function()
                        RefreshVaultContent(actualFilter, data.vaultId, false, searchFilters["vault"])
                    end, data.itemName, 1, tonumber(data.vaultId))
                else
                    ESX.TriggerServerCallback(eventprefix .. ":addArmoryWeapon", function()
                        RefreshVaultContent(actualFilter, data.vaultId, false, searchFilters["vault"])
                    end, data.itemName, tonumber(data.vaultId))
                end
            elseif data.itemType == "item" or data.itemType == "account" then
                TriggerServerEvent(eventprefix .. ":putStockItems", data.itemName, tonumber(data.amount), tonumber(data.vaultId))
                Wait(500)
                RefreshVaultContent(actualFilter, tonumber(data.vaultId), false, searchFilters["vault"])
            end
        end
    elseif data.targetInv == "player" then
        if data.inv == "fast" then
            data.targetSlot = tonumber(data.targetSlot)
            fastItems[tostring(data.targetSlot)] = nil
            RefreshInventoryContent(actualFilter, searchFilters["inventory"])
        elseif data.inv == "vault" then
            if tonumber(data.vaultId) == 0 then
                TriggerServerEvent("esx:takePickup", tonumber(data.itemName), tonumber(data.amount or 1))
            else
                local eventprefix = "society"
                if tonumber(data.vaultId) == 3 then
                    eventprefix = "housing"
                end
                if data.itemType == "weapon" then
                    if eventprefix == "housing" then
                        ESX.TriggerServerCallback(eventprefix .. ":removeArmoryWeapon", function()
                            RefreshVaultContent(actualFilter, data.vaultId, false, searchFilters["vault"])
                        end, data.itemName, 1, tonumber(data.vaultId))
                    else
                        ESX.TriggerServerCallback(eventprefix .. ":removeArmoryWeapon", function()
                            RefreshVaultContent(actualFilter, data.vaultId, false, searchFilters["vault"])
                        end, data.itemName, 0, tonumber(data.vaultId))
                    end
                elseif data.itemType == "item" or data.itemType == "account" then
                    TriggerServerEvent(eventprefix .. ":getStockItem", data.itemName, tonumber(data.amount), tonumber(data.vaultId))
                    Wait(500)
                    RefreshVaultContent(actualFilter, tonumber(data.vaultId), false, searchFilters["vault"])
                end
            end
        end
    end

    if cb then
        cb()
    end
end)

RegisterNUICallback('toggleClothe', function(data, cb)
    setUniform(data.part)
    RefreshPedScreen()
    if cb then
        cb()
    end
end)

function setUniform(value)
    local skin = ESX.GetPlayerData().skin
    local ped = PlayerPedId()
      TriggerEvent("skinchanger:getSkin", function(skina)
      if value == "total" then
        TriggerEvent("skinchanger:loadSkin", ESX.PlayerData.skin)
      elseif value == 'tshirt' then
          ClearPedTasks(ped)
  
          if skin.torso_1 ~= skina.torso_1 then
              TriggerEvent('skinchanger:loadClothes', skina, {['torso_1'] = skin.torso_1, ['torso_2'] = skin.torso_2, ['tshirt_1'] = skin.tshirt_1, ['tshirt_2'] = skin.tshirt_2, ['arms'] = skin.arms})
          else
              TriggerEvent('skinchanger:loadClothes', skina, {['torso_1'] = 15, ['torso_2'] = 0, ['tshirt_1'] = 15, ['tshirt_2'] = 0, ['arms'] = 15})
          end
      elseif value == 'pants' then
          if skin.pants_1 ~= skina.pants_1 then
              TriggerEvent('skinchanger:loadClothes', skina, {['pants_1'] = skin.pants_1, ['pants_2'] = skin.pants_2})
          else
              if skin.sex == 0 then
                  TriggerEvent('skinchanger:loadClothes', skina, {['pants_1'] = 21, ['pants_2'] = 0})
              else
                  TriggerEvent('skinchanger:loadClothes', skina, {['pants_1'] = 15, ['pants_2'] = 0})
              end
          end
      elseif value == 'shoes' then
          if skin.shoes_1 ~= skina.shoes_1 then
              TriggerEvent('skinchanger:loadClothes', skina, {['shoes_1'] = skin.shoes_1, ['shoes_2'] = skin.shoes_2})
          else
              if skin.sex == 0 then
                  TriggerEvent('skinchanger:loadClothes', skina, {['shoes_1'] = 34, ['shoes_2'] = 0})
              else
                  TriggerEvent('skinchanger:loadClothes', skina, {['shoes_1'] = 47, ['shoes_2'] = 0})
              end
          end
      elseif value == "mask" then
        ClearPedTasks(ped)
        if skin.mask_1 ~= skina.mask_1 then
          TriggerEvent("skinchanger:loadClothes", skina, {["mask_1"] = skin.mask_1, ["mask_2"] = skin.mask_2})
        else
          TriggerEvent("skinchanger:loadClothes", skina, {["mask_1"] = 0})
        end
      elseif value == "helmet" then
        ClearPedTasks(ped)
        if skin.helmet_1 ~= skina.helmet_1 then
          TriggerEvent("skinchanger:loadClothes", skina, {["helmet_1"] = skin.helmet_1, ["helmet_2"] = skin.helmet_2})
        else
          TriggerEvent("skinchanger:loadClothes", skina, {["helmet_1"] = -1})
        end
    elseif ClothesInfo[value] then
        ClearPedTasks(ped)
        if skin[value .. "_1"] ~= skina[value .. "_1"] then
          TriggerEvent("skinchanger:loadClothes", skina, {[value .. "_1"] = skin[value .. "_1"], [value .. "_2"] = skin[value .. "_2"]})
        else
          TriggerEvent("skinchanger:loadClothes", skina, {[value .. "_1"] = ClothesInfo[value]})
        end
      end
    end)
end

function triggerClothesAnimation()
    local playerSex = ESX.PlayerData.skin.sex
    return lib.progressCircle({
        duration = 2000,
        position = 'bottom',
        useWhileDead = false,
        canCancel = false,
        disable = {
            move = true,
            combat = true,
            car = true,
        },
        anim = {
            dict = (playerSex == 0 and 'clothingtie') or 'mp_clothing@female@shirt',
            clip = (playerSex == 0 and 'try_tie_neutral_d') or 'try_shirt_positive_a'
        }
    }) 
end

RegisterNUICallback('putClothe', function(data, cb)
    local _data = data
    local clotheData = clothesDataListByKey[_data.clothe]
    if clotheData then
        CloseInventory()
        TriggerEvent("skinchanger:getSkin", function(skin)
            TriggerEvent("skinchanger:loadClothes", skin, clotheData.data)
            Citizen.Wait(500)
            RefreshPedScreen()
        end)
        triggerClothesAnimation()
        OpenInventory(actualFilter, true)
    end
    if cb then
        cb()
    end
end)

RegisterNUICallback('close', function(data, cb)
    CloseInventory()
    if cb then
        cb()
    end
end)

RegisterNUICallback('search', function(data, cb)
    searchFilters[data.type] = data.value
    if data.type == "inventory" then
        RefreshInventoryContent(actualFilter, searchFilters[data.type])
    elseif VaultCache and VaultCache.vaultId then
        RefreshVaultContent(actualFilter, VaultCache.vaultId, true, searchFilters[data.type])
    end
    if cb then
        cb()
    end
end)

AddEventHandler("inventory:openInventory", function(selected)
    if selected == "new" then
        OpenInventory(actualFilter, true)
    end
end)

AddEventHandler("inventory:closeInventory", function(selected)
    if selected == "new" then
        CloseInventory()
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(5)
        if IsControlPressed(0, 37) then
            for _,v in pairs(alwaysDisabled) do
                DisableControlAction(0, v, false)
            end
        else
            for _,v in pairs(alwaysDisabled) do
                DisableControlAction(0, v, false)
            end
        end
        if isInInventory then
            for _,v in pairs(controlDisabled) do
                DisableControlAction(0, v, true)
            end
        end
    end
end)


function CreatePedInMenu(firstTime)
    local menuType = "FE_MENU_VERSION_EMPTY_NO_BACKGROUND"
    ActivateFrontendMenu(GetHashKey(menuType), false, -1)
    Wait(100)
    clonedPed = ClonePed(PlayerPedId(), 0, false, false)
    local x, y, z = table.unpack(GetEntityCoords(clonedPed))
    SetEntityCoords(clonedPed, x, y, z - 10)
    FreezeEntityPosition(clonedPed, true)
    N_0x4668d80430d6c299(clonedPed)
    GivePedToPauseMenu(clonedPed, 1)
    SetPauseMenuPedLighting(true)
    SetPauseMenuPedSleepState(true)
    RequestScaleformMovie("PAUSE_MP_MENU_PLAYER_MODEL")
    ReplaceHudColourWithRgba(117, 0, 0, 0, 0)
    if firstTime then
        SetPauseMenuPedSleepState(false)
        Wait(1000)
        SetPauseMenuPedSleepState(true)
    else
        SetPauseMenuPedSleepState(true)
    end
end

function DestroyPedInMenu()
    if DoesEntityExist(clonedPed) then
        DeleteEntity(clonedPed)
    end
    SetFrontendActive(false)
    ReplaceHudColourWithRgba(117, 0, 0, 0, 186)
end

function RefreshPedScreen()
    if DoesEntityExist(clonedPed) then
        DestroyPedInMenu()
        Wait(500)
        if isInInventory then
            CreatePedInMenu(false)
        end
    end
end