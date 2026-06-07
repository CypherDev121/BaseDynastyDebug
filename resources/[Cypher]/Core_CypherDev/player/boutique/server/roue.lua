local AleardyTookFree = {}
local Rolling = false
local DropTypes = {[1] = "epic", [2] = "rare", [3] = "common"}

ESX.RegisterServerCallback('store:RequestRoueStart', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
    local authorise = false
    if xPlayer then
        if not Rolling then
            if not AleardyTookFree[xPlayer.getUUID()] then
                AleardyTookFree[xPlayer.getUUID()] = 1
                authorise = true
            elseif AleardyTookFree[xPlayer.getUUID()] and AleardyTookFree[xPlayer.getUUID()] > 0 then
                if xPlayer.getRank() == "vip" then
                    if AleardyTookFree[xPlayer.getUUID()] < 2 then
                        AleardyTookFree[xPlayer.getUUID()] = AleardyTookFree[xPlayer.getUUID()] + 1
                        authorise = true
                    end
                elseif xPlayer.getRank() == "diamond" then
                    if AleardyTookFree[xPlayer.getUUID()] < 3 then
                        AleardyTookFree[xPlayer.getUUID()] = AleardyTookFree[xPlayer.getUUID()] + 1
                        authorise = true
                    end
                end
            else
                if xPlayer.hasInventoryItem("roueticket") then
                    xPlayer.removeInventoryItem("roueticket", 1)
                    authorise = true
                else
                    cb("notfound")
                end
            end

            if authorise then
                cb("can")
                StartRoueRoll(source)
            end
        else
            cb("aleardy")
        end
    end
end)

function random(x, y)
    local u = 0;
    u = u + 1
    if x ~= nil and y ~= nil then
        return math.floor(x + (math.random(math.randomseed(os.time() + u)) * 999999 % y))
    else
        return math.floor((math.random(math.randomseed(os.time() + u)) * 100))
    end
end

function StartRoueRoll(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        Rolling = true
        SetTimeout(4000, function()
            local percentage = math.random(1, 3)
            local chance = math.random(1, 100)
            local droptype = nil
            local gift = { category = 1, item = 1 }
            local minimalChance = 4
            if chance <= minimalChance and xPlayer.getRank() ~= "default" then
                droptype = DropTypes[1]
                gift.category = StoreConfig.RoueDrops[DropTypes[1]]
                local rand = math.random(1, #gift.category)
                gift.item = gift.category[rand]
            elseif (chance > minimalChance and chance <= 30) or (chance > 80 and chance <= 100) or (chance <= minimalChance) then
                droptype = DropTypes[2]
                gift.category = StoreConfig.RoueDrops[DropTypes[2]]
                local rand = math.random(1, #gift.category)
                gift.item = gift.category[rand]
            else
                droptype = DropTypes[3]
                gift.category = StoreConfig.RoueDrops[DropTypes[3]]
                local rand = math.random(1, #gift.category)
                gift.item = gift.category[rand]
            end
            category = StoreConfig.RoueDrops[DropTypes[percentage]]
            local itemnumber = math.random(1, #category)
            local item = gift.item
            if item then
                if item.type == "account" then
                    if tonumber(item.amount) then
                        xPlayer.addAccountMoney(item.item, tonumber(item.amount))
                    end
                elseif item.type == "weapon" then
                    xPlayer.addWeapon(item.item, 0)
                elseif item.type == "vehicle" then
                    AssignVehicle(source, xPlayer.getUUID(), item.item, GeneratePlate(), item.native)
                elseif item.type == "storepoints" then
                    xPlayer.addStorePoints(tonumber(item.amount))
                end
                TriggerClientEvent("esx:showNotification", source, "Vous avez reçu : " .. item.name .. ", de la catégorie : " .. droptype)
            end
        end)
        SetTimeout(5000, function()
            Rolling = false
        end)
    end
end