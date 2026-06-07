ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local function getMoney(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    return xPlayer.getMoney()
end

local function removeMoney(source, amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getMoney() >= amount then
        xPlayer.removeMoney(amount)
        return true
    end
    return false
end

local function addMoney(source, amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addMoney(amount)
    return true
end

local function getBankMoney(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    return xPlayer.getAccount('bank').money
end

local function removeBankMoney(source, amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getAccount('bank').money >= amount then
        xPlayer.removeAccountMoney('bank', amount)
        return true
    end
    return false
end

local function addBankMoney(source, amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addAccountMoney('bank', amount)
    return true
end

local function updateUIForPlayer(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.getIdentifier()
    
    MySQL.Async.fetchAll('SELECT * FROM banking_transactions WHERE identifier = @identifier ORDER BY created_at DESC LIMIT 10', {
        ['@identifier'] = identifier
    }, function(transactions)
        TriggerClientEvent('banking:updateUI', source, {
            balance = getBankMoney(source),
            transactions = transactions
        })
    end)
end

ESX.RegisterServerCallback('banking:getAccountInfo', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.getIdentifier()

    MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
        ['@identifier'] = identifier
    }, function(result)
        if result[1] then
            MySQL.Async.fetchAll('SELECT * FROM banking_transactions WHERE identifier = @identifier ORDER BY created_at DESC LIMIT 10', {
                ['@identifier'] = identifier
            }, function(transactions)
                cb({
                    balance = getBankMoney(source),
                    firstName = result[1].firstname,
                    lastName = result[1].lastname,
                    transactions = transactions
                })
            end)
        end
    end)
end)

ESX.RegisterServerCallback('banking:getTransactionHistory', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.getIdentifier()

    MySQL.Async.fetchAll('SELECT * FROM banking_transactions WHERE identifier = @identifier ORDER BY created_at DESC LIMIT 10', {
        ['@identifier'] = identifier
    }, function(transactions)
        cb(transactions)
    end)
end)

RegisterServerEvent('banking:deposit')
AddEventHandler('banking:deposit', function(amount)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.getIdentifier()

    if amount > 0 and getMoney(source) >= amount then
        if removeMoney(source, amount) then
            addBankMoney(source, amount)
            
            MySQL.Async.execute('INSERT INTO banking_transactions (identifier, amount, type, created_at) VALUES (@identifier, @amount, @type, NOW())', {
                ['@identifier'] = identifier,
                ['@amount'] = amount,
                ['@type'] = 'deposit'
            }, function()
                updateUIForPlayer(source)
                TriggerClientEvent('esx:showNotification', source, 'Vous avez déposé $' .. amount)
            end)
        end
    else
        TriggerClientEvent('esx:showNotification', source, 'Montant invalide ou argent insuffisant')
    end
end)

RegisterServerEvent('banking:withdraw')
AddEventHandler('banking:withdraw', function(amount)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.getIdentifier()

    if amount > 0 and getBankMoney(source) >= amount then
        if removeBankMoney(source, amount) then
            addMoney(source, amount)

            MySQL.Async.execute('INSERT INTO banking_transactions (identifier, amount, type, created_at) VALUES (@identifier, @amount, @type, NOW())', {
                ['@identifier'] = identifier,
                ['@amount'] = amount,
                ['@type'] = 'withdraw'
            }, function()
                updateUIForPlayer(source)
                TriggerClientEvent('esx:showNotification', source, 'Vous avez retiré $' .. amount)
            end)
        end
    else
        TriggerClientEvent('esx:showNotification', source, 'Montant invalide ou fonds insuffisants')
    end
end)

RegisterServerEvent('banking:transfer')
AddEventHandler('banking:transfer', function(target, amount)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(target)
    
    if xTarget and amount > 0 and getBankMoney(source) >= amount then
        if removeBankMoney(source, amount) then
            addBankMoney(target, amount)

            MySQL.Async.execute('INSERT INTO banking_transactions (identifier, amount, type, target_identifier, created_at) VALUES (@identifier, @amount, @type, @target_identifier, NOW())', {
                ['@identifier'] = xPlayer.getIdentifier(),
                ['@amount'] = amount,
                ['@type'] = 'transfer',
                ['@target_identifier'] = xTarget.getIdentifier()
            }, function()
                updateUIForPlayer(source)
                updateUIForPlayer(target)
                
                TriggerClientEvent('esx:showNotification', source, 'Vous avez transféré $' .. amount .. ' à l\'ID: ' .. target)
                TriggerClientEvent('esx:showNotification', target, 'Vous avez reçu $' .. amount .. ' de l\'ID: ' .. source)
            end)
        end
    else
        TriggerClientEvent('esx:showNotification', source, xTarget and 'Montant invalide ou fonds insuffisants' or 'Joueur cible invalide')
    end
end)