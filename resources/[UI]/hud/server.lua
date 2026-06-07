ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('NyseraRPHUD:getPlayerMoney', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then
        print("[ERROR] xPlayer is nil for source: " .. tostring(source))
        return cb(nil)
    end

    local xMoney = xPlayer.getAccount('money') and xPlayer.getAccount('money').money or 0
    local xDirty = xPlayer.getAccount('dirtycash') and xPlayer.getAccount('dirtycash').money or 0
    local xBank = xPlayer.getAccount('bank') and xPlayer.getAccount('bank').money or 0

    -- Send new values to the HUD UI
    TriggerClientEvent("rHud:setInfo", source, xMoney, xDirty, xBank)

    cb({dirty = xDirty, cash = xMoney, bank = xBank})
end)

